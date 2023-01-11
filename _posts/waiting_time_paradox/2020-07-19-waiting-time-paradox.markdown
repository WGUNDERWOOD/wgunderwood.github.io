---
layout: post
title:  "The Waiting Time Paradox"
date:   2020-07-19
---

Why is my train always late?
Do light bulbs last longer than they should?
These questions can be answered with
the
waiting time paradox
and the
inspection paradox.

Source code for the simulations
(Python)
and the diagram
(LaTeX)
is available on
[GitHub](https://github.com/WGUNDERWOOD/wgunderwood.github.io/
tree/main/_posts/waiting_time_paradox).



{% include mathjax.html %}

<div style="display:none">
  $\newcommand \Exp {\mathrm{Exp}}$
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \U {\mathcal{U}}$
  $\newcommand \Gamma {\mathrm{Gamma}}$
  $\newcommand \dx {\,\mathrm{d}x}$
</div>



## Introduction

Sometimes it feels like trains are always late.
You know they arrive roughly every ten minutes,
so why do you so often have to wait for fifteen or twenty minutes?
Is this just bad luck,
or is it probability theory?

In fact this is an example of a phenomenon
called the
*waiting time paradox*.
In this post,
the waiting time paradox and the related *inspection paradox*
are presented,
and perhaps after reading you can think of
some other circumstances
under which these paradoxes might occur.

## The Waiting Time Paradox

Consider again the scenario of waiting for a train
which arrives approximately every ten minutes.
Once you arrive at the station,
how long do you actually have to wait?
First let's define this question more rigorously.

### The problem

Suppose that every day,
trains start running at 4am
(call this $t=0$),
and the gaps (in minutes)
between trains arriving
(the so-called *interarrival times*)
are independently distributed
$\Exp(10)$.
This means that the expected time interval
between two trains arriving is ten minutes.
Every day you reach the station at 9am
($t=300$),
and wait for a train to arrive.

Figure 1 shows a typical timeline:
trains arrive at times
$T_1, T_2, \ldots$,
with independent interarrival times
$Z_1, Z_2, \ldots \sim \Exp(10)$.
You reach the station at time $300$,
and take the $N$th train that day
(note that $N$ is a random variable).
$E$ minutes have elapsed since
the train you just missed,
and you have to wait for $W$
minutes at the station.
The total time interval between the train
you missed and the train you catch is
$I = Z_N = E + W$ minutes.

We are interested in calculating the expected
waiting time,
$\E[W]$.

<figure>
<img style="float: center; width: 600px; padding-bottom: 10px;
  padding-top: 5px; padding-right: 40px; padding-left: 50px;"
src="/assets/posts/waiting_time_paradox/time_diagram.svg">
<figcaption>
  Figure 1: A typical timeline
</figcaption>
</figure>



### A naive and incorrect approach

It seems very natural to perform the following calculation:
"Trains arrive every ten minutes,
and on average you get to the station half way
between two trains,
so you should expect to wait five minutes."
In mathematical notation,
this argument reads:

1. $Z_N$ is an interarrival time, so $\E[I] = \E[Z_N] = 10$
2. Conditional on $I$, we have the uniform distribution $W\|I \sim \U[0, I]$
3. Therefore by the tower law,
$\E[W] = \E[\E[W\|I]] = \E[\U[0,I]] = \E[I/2] = 10/2 = 5$

Lets test this empirically.
Table 1 shows the guesses of variable values using the reasoning above,
and also the empirical means of these values when simulating
the scenario 100 000 times.

While we correctly guessed the
average gap $Z_1$ between the first two trains,
and the average number of trains to arrive $N$,
we are underestimating the other times
$I$, $E$ and $W$ by a factor of two!
This discrepancy is called the waiting time paradox.


| Variable | $Z_1$ | $I$ | $E$ | $W$ | $N$ |
|:--:|
| Naive guess | 10 | 10 | 5 | 5 | 30 |
| Simulated | 9.97 | 20.05 | 9.99 | 10.06 | 30.00 |

<center>Table 1: Disagreement between naive guesses and simulation</center>
<br>



### An intuitive explanation

The first error in our naive reasoning was in
calculating $\E[I]$.
While it is true that $I$ is an interarrival time
(it is equal to $Z_N$),
it is crucial to note that $N$ is *random*.
Hence we cannot expect $Z_N$ to behave the same as
$Z_1$.

Perhaps now an intuitive explanation becomes clear:
you are likely to reach the station
during a longer-than-average gap between trains.
You are unlikely to get there during the tiny interval
of time between two trains which arrive almost simultaneously.


### Size-biased distributions

Now that we know
the distribution
of $Z_N$
cannot be
$\Exp(10)$,
what is its true distribution?
With the previous comments in mind,
it is natural to suggest the following procedure.
Suppose $Z_1$ has probability density function $f_1$.
Then because $Z_N$ is similar to $Z_1$,
but with larger values being proportionally more likely,
we suggest the density of $Z_N$ as
$ f_N(x) \propto x f_1(x)$.
To make this a genuine
probability density function,
we normalize it by
$ f_N(x) = \frac{x f_1(x)}{\E[Z_1]}$.
This is called the
*size-biased*
distribution based on $f_1$.

For our case of
$Z_1 \sim \Exp(10)$,
we have
$f_1(x) = \frac{1}{10} e^{-x/10}$
and
$\E[Z_1] = 10$,
giving
$f_N(x) = \frac{x}{100} e^{-x/10}$.
This is in fact the probability
density function of the
$\Gamma(2,10)$ distribution,
which has expected value 20,
consistent with the simulations.


### Asymptotic convergence

Of course,
if you reached the station at 4am every morning,
you would be guaranteed to board the first train of
the day, with no waiting at all!
For this reason,
the results we state are
asymptotic:
it is assumed that we reach the station
long enough after the trains begin to run
that the system has "forgotten"
exactly when the first few trains arrived.

The two theorems below give
(without proof)
asymptotic
corrected versions of our earlier incorrect assumptions,
using size-biased distributions.

#### Theorem 1 (Convergence in distribution of observed interval)

Suppose that the interarrival times
$Z_1, Z_2, \ldots$
are independent
and identically distributed continuous random variables
with Lebesgue density $f_1$.
Let $N_t$ be the train taken by someone
who reaches the station at time $t$, and
$I_t$ be the length of the gap between
trains $N_{t-1}$ and $N_t$.
That is,
$I_t = Z_{N_t} = T_{N_t} - T_{N_t-1}$.

Then $I_t$ converges in distribution
as $t \to \infty$ to
$L$, which has
a size-biased distribution with Lebesgue density
$f(x) = \frac{x f_1(x)}{\E[Z_1]}$.



#### Theorem 2 (Convergence in distribution of waiting time)

Under the same conditions as the previous theorem,
the waiting time $W_t$ converges in distribution
as $t \to \infty$
to $L U$,
where $L$ has
a size-biased distribution with Lebesgue density
$f(x) = \frac{x f_1(x)}{\E[Z_1]}$,
and $U \sim \U[0,1]$ is independent of $L$.


### Summary

Let's use these theorems to verify the simulated results
in Table 1.
Let $L$ have the size-biased distribution
which has Lebesgue density
$f(x) = \frac{x f_1(x)}{\E[Z_1]} = \frac{x}{100} e^{-x/10}$.
Then assuming that you arrive at the station
a sufficient amount of time after the trains
begin running:

* $ \E[I]
  \approx \E[L]
  = \int_0^\infty x f(x) \dx
  = \int_0^\infty \frac{x^2}{100} e^{-x/10} \dx = 20$
* $ \E[W]
  \approx \E[LU]
  = \E[L] \E[U]
  = 20 / 2
  = 10$
* $ \E[E]
  \approx \E[L - LU]
  = \E[L] \E[1-U]
  = 20 / 2
  = 10$

These are now all consistent with the simulated results
in Table 1.




## The Inspection Paradox

The inspection paradox is very closely
related to the waiting time paradox,
but with a slightly different interpretation.
The scenario to imagine here is changing a light bulb,
and the observed effect is that most light bulbs
last an unusually long time before breaking.

### The light bulb scenario

Suppose that light bulbs have independently-distributed
lifetimes
$Z_1, Z_2, \ldots$
where
$Z_1$ is either one second or two years,
with equal probability
(to account for the fact that light bulbs
frequently break almost immediately).

Then clearly the expected lifetime of a light bulb
is just over one year,
but when ignoring bulbs that break immediately,
the rest of the bulbs in fact last for two years,
almost twice their expected lifespan.

While this light bulb example may seem
contrived,
it is representative of a great many situations
in which a similar phenomenon occurs,
perhaps more subtly.




## Other examples

The waiting time and inspection paradoxes
occur whenever data taking large values
are proportionately over-sampled or over-represented.
We described this phenomenon mathematically
using size-biased distributions.
However this effect is actually very common
in statistics
(it is a form of selection bias),
and not just when dealing with
point processes such as arrival times.
Here are a few other examples of phenomena
related to the waiting time and inspection
paradoxes.

* Radioactive decay almost perfectly exhibits
exponential interarrival times, and so when a detector is
first switched on,
the expected time until the first detection is
the same as the expected interarrival time
(not half of this as might naively be suggested).

* When asking students about the size of their class,
large classes will submit more responses,
and hence be over-represented.

* If you visit a prison,
most people you meet will be serving
longer-than-average sentences.

* Most people you meet at the gym
go there more often than you.

* Most of your friends have more friends than you (sorry).





## References

* The University of Oxford's course in Applied Probability,
taught by Paul Chleboun in 2017

* A great post from
[Jake VanderPlas' blog](http://jakevdp.github.io/blog/2018/09/13/
waiting-time-paradox/)

* Real-world examples from
[Allen Downey's blog](http://allendowney.blogspot.com/2015/08/
the-inspection-paradox-is-everywhere.html)
