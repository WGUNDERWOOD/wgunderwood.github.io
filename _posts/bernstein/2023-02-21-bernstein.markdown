---
layout: post
title:  "Bernstein's Inequality"
date:   2023-02-21
---

Bernstein's inequality is an important concentration inequality.
In this post we motivate, state and prove a
"maximal inequality" version which I think
is clearer than the usual formulation.

{% include mathjax.html %}

<div style="display:none">
  $ \newcommand \R {\mathbb{R}} $
  $ \newcommand \P {\mathbb{P}} $
  $ \newcommand \E {\mathbb{E}} $
  $ \newcommand \I {\mathbb{I}} $
  $ \newcommand \V {\mathbb{V}} $
  $ \newcommand \cX {\mathcal{X}} $
  $ \newcommand \Ber {\mathrm{Ber}} $
  $ \newcommand \Pois {\mathrm{Pois}} $
  $ \newcommand \Bin {\mathrm{Bin}} $
  $ \newcommand \cN {\mathcal{N}} $
  $ \newcommand \N {\mathbb{N}} $
  $ \newcommand \diff {\,\mathrm{d}} $
</div>

## Introduction

[Concentration inequalities](https://en.wikipedia.org/wiki/
Concentration_inequality)
are central to
probability theory, mathematical statistics and theoretical machine learning,
providing a mathematical framework to the notion that
"with enough samples you eventually get the right answer."
More precisely, they provide bounds on the
typical deviations
that a random variable makes from its expected value.
[Bernstein's inequality](https://en.wikipedia.org/wiki/
Bernstein_inequalities_(probability_theory))
allows us to control
the size of a sum of independent zero-mean random variables
where variance and almost sure bounds on the summands are available.

In this post we state and prove Bernstein's inequality,
and also demonstrate its approximate optimality
by establishing two different lower bounds.
The Julia code for the simulations is available on
[GitHub](https://github.com/WGUNDERWOOD/wgunderwood.github.io/
tree/main/_posts/bernstein).

## Motivation

In many applications we need to control the maximum
of a collection of random variables.
For example,
we might be proving uniform convergence of a
[statistical estimator](https://en.wikipedia.org/wiki/Kernel_regression),
establishing consistency for a
[binary classifier](https://en.wikipedia.org/wiki/Binary_classification)
under
[empirical risk minimization](https://en.wikipedia.org/
wiki/Empirical_risk_minimization),
or controlling the regret of a
[reinforcement learning](https://en.wikipedia.org/wiki/Reinforcement_learning)
algorithm.
Understanding how this maximum behaves as a function
of the number of variables is essential
(Figure 1).
In this post we focus on maximal inequalities for
sums of independent random variables.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/bernstein/maximum.svg">
<figcaption>
  Fig. 1: With $X_j \sim \cN(0,1)$ independent,
  $\max_{1 \leq j \leq d} |X_j|$ grows with $d$.
</figcaption>
</figure>


### Setup

We propose the following setup which is widely applicable
in practice.

- $X_{i j}$ are real-valued random variables for
  $1 \leq i \leq n$ and $1 \leq j \leq d$.

- $X_{1j}, \ldots, X_{n j}$ are
  independent and identically distributed (i.i.d.)
  for each $j$.

- $\E[X_{1j}] = 0$ for each $j$.

- $\max_{1 \leq j \leq d} \V[X_{1j}] \leq \sigma^2$.

- $\max_{1 \leq j \leq d} \|X_{1j}\| \leq M$ almost surely (a.s.).

- We will provide expectation bounds for the variable
  $\max_{1 \leq j \leq d} \left| \sum_{i=1}^n X_{i j} \right|$.

A brief discussion is in order.
Firstly, the mean-zero property and the variance bound
tell us that
$\max_{1 \leq j \leq d}
\E\big[\left| \sum_{i=1}^n X_{i j} \right|\big] \leq \sqrt{n\sigma^2}$.
However in order to put the maximum inside the sum,
we need finer control on the tails of the summands,
attained by imposing the almost sure bound.
Note that we do not make any assumptions
regarding the dependencies between
different values of $j$.


## Bernstein's inequality

Now let's state the main result,
a maximal version of Bernstein's inequality.
The proof is provided later in the post,
to avoid distracting from the discussion.

<div class="box-rounded">

<h4> Theorem (Bernstein's maximal inequality) </h4>

For each $1 \leq j \leq d$,
let $X_{1j}, \ldots, X_{n j}$ be
i.i.d. real-valued random variables.
Suppose $\E[X_{1j}] = 0$ for each $j$,
$\max_{1 \leq j \leq d} \V[X_{1j}] \leq \sigma^2$
and
$\max_{1 \leq j \leq d} |X_{1j}| \leq M$ a.s. Then

$$
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{i j}
\right|
\right]
\leq
\sqrt{2 n \sigma^2 \log 2d}
+ \frac{M}{3} \log 2d.
$$

</div>

### Why this formulation?

If you have seen Bernstein's inequality before,
you may notice a few differences between this version
and the usual formulation, including:


- This result is stated for the maximum of $d$ random variables.
  This is to highlight the dependence of the resulting bound on $d$.

- This version is stated as an expectation rather than a tail probability
  to avoid notational complexity,
  but can be easily strengthened to include the tail bound.

- The terms on the right hand side are rather complicated
  and perhaps unfamiliar,
  but allow us to more directly parse the bound on the maximum.
  The more standard version of Bernstein's inequality makes it difficult
  to read off this value.

### Interpreting the bound

The resulting bound of
$\sqrt{2 n \sigma^2 \log 2d} + \frac{M}{3} \log 2d$
consists of two terms
which are worth discussing separately.

- The first term is
  $\sqrt{2 n \sigma^2 \log 2d}$,
  which depends on $n$ and $\sigma^2$ but not $M$,
  and has a sub-Gaussian-type dependence on the dimension.
  This is the bound obtained if we assume that
  each $X_{1j}$ is $\sigma^2$-sub-Gaussian,
  and this term corresponds
  to the
  [central limit theorem](https://en.wikipedia.org/wiki/
  Central_limit_theorem)
  for
  $\frac{1}{\sqrt{n \sigma^2}}\sum_{i=1}^n X_{i j}$.

- The second term is
  $\frac{M}{3} \log 2d$
  and depends on $M$ but not $n$ or $\sigma^2$.
  This is a sub-exponential-type tail
  which captures rare event phenomena associated with
  bounded random variables.


It is worth remarking at this point that
[Bennett's inequality](https://en.wikipedia.org/wiki/Bennett%27s_inequality)
provides a further refinement of Bernstein's inequality,
but the difference is minor in many applications.




## Approximate optimality

In this section we provide two explicit examples
which show why each of the two terms discussed above are necessary.
It is somewhat remarkable that these examples are so easy to find,
providing a straightforward demonstration of the
near-optimality of Bernstein's maximal inequality.

### Example 1: central limit theorem

Let $X_{i j} = \pm \sigma$
with equal probability
be i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Note $\E[X_{i j}] = 0$, $\V[X_{i j}] = \sigma^2$
and $|X_{i j}| = \sigma$ a.s., so Bernstein's inequality gives

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{i j}
\right|
\right]
&\leq
\sqrt{2 n \sigma^2 \log 2d}
+ \frac{\sigma}{3} \log 2d,
\end{align*}
$$

and hence for fixed $d \geq 1$

$$
\begin{align*}
\limsup_{n \to \infty}
\E\left[
\max_{1 \leq j \leq d}
\left|
\frac{1}{\sqrt{n \sigma^2}}
\sum_{i=1}^n X_{i j}
\right|
\right]
&\leq
\sqrt{2 \log 2d}.
\end{align*}
$$

However we also have by the central limit theorem that

$$
\begin{align*}
\frac{1}{\sqrt{n \sigma^2}}
\sum_{i=1}^n
(X_{i1}, \ldots, X_{id})
\rightsquigarrow
(Z_1, \ldots, Z_d)
\end{align*}
$$

as $n \to \infty$,
where $Z_j \sim \cN(0,1)$ are i.i.d.
So by a Gaussian lower bound in the appendix,

$$
\begin{align*}
\lim_{n \to \infty} \,
\E\left[
\max_{1 \leq j \leq d}
\left|
\frac{1}{\sqrt{n \sigma^2}}
\sum_{i=1}^n X_{i j}
\right|
\right]
= \E\left[
\max_{1 \leq j \leq d}
|Z_j|
 \right]
\geq
\frac{1}{2}
\sqrt{\log d}
\end{align*}.
$$



Thus the first term in Bernstein's maximal inequality
is unimprovable up to constants.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/bernstein/normal.svg">
<figcaption>
  Fig. 2: Bernstein's upper bound of
  $\sqrt{2 n \sigma^2 \log 2d} + \frac{\sigma}{3} \log 2d$
  and simulated <br> values of
  $\E\left[\max_{1 \leq j \leq d}
  \left| \sum_{i=1}^n X_{i j} \right| \right]$
  for Example 1 with $n = 50$ and $\sigma^2 = 1$.
</figcaption>
</figure>





### Example 2: Poisson weak convergence

Now let $X_{i j} = M\left(1 - \frac{1}{n}\right)$
with probability $1/n$
and $-\frac{M}{n}$ with probability $1 - 1/n$ be
i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Note that $\E[X_{i j}] = 0$,
$\V[X_{i j}] = \frac{n-1}{n^2} M^2$
and $|X_{i j}| \leq \frac{n-1}{n} M$ a.s.,
so Bernstein's inequality gives

$$
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{i j}
\right|
\right]
\leq
\sqrt{2 M^2 \log 2d}
+ \frac{M}{3} \log 2d,
$$

and hence

$$
\limsup_{d \to \infty}
\limsup_{n \to \infty}
\E\left[
\max_{1 \leq j \leq d}
\left|
\frac{1}{M \log d}
\sum_{i=1}^n X_{i j}
\right|
\right]
\leq
\frac{1}{3}.
$$

However also note the binomial distribution limit

$$
\begin{align*}
\P\left(\sum_{i=1}^n \left(\frac{X_{i j}}{M} + \frac{1}{n}\right) = k\right)
&= \frac{n!}{k!(n-k)!}
\left(\frac{1}{n}\right)^k
\left(1 - \frac{1}{n}\right)^{n-k}
\to \frac{1}{e k!}
\end{align*}
$$

as $n \to \infty$.
Thus we have the Poisson weak convergence

$$
\begin{align*}
\frac{1}{M}
\sum_{i=1}^n
(X_{i1}, \ldots, X_{id})
+ (1, \ldots, 1)
\rightsquigarrow
(Z_1, \ldots, Z_d)
\end{align*}
$$

as $n \to \infty$ where $Z_j \sim \Pois(1)$ are i.i.d.
So by a Poisson lower bound in the appendix,

$$
\begin{align*}
\liminf_{d \to \infty}
\lim_{n \to \infty}
\E\left[
\max_{1 \leq j \leq d}
\left|
\frac{\log \log d}{M \log d}
\sum_{i=1}^n X_{i j}
\right|
\right]
 =
\liminf_{d \to \infty}
\frac{\log \log d}{\log d}
\left(
\E\left[\max_{1 \leq j \leq d} Z_j \right] - 1
\right)
\geq
\frac{1}{6}.
\end{align*}
$$

Hence the second term in Bernstein's inequality
is tight up to a factor of $\log \log d$.
This factor diverges so slowly that
Bernstein's inequality is practically optimal
in many applications.
For example, $\log \log d \geq 6$
already requires ${d > 10^{175}}$, far more than the number
of particles in the universe!

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/bernstein/poisson.svg">
<figcaption>
  Fig. 3: Bernstein's upper bound of
  $\sqrt{2 M^2 \log 2d} + \frac{M}{3} \log 2d$
  and simulated <br> values of
  $\E\left[\max_{1 \leq j \leq d}
  \left| \sum_{i=1}^n X_{i j} \right| \right]$
  for Example 2 with $n = 50$ and $M = 1$.
</figcaption>
</figure>




## References
* [Four lectures on probabilistic
  methods for data science](https://arxiv.org/abs/1612.06661)
  by Roman Vershynin

* The University of Oxford's course on Algorithmic Foundations of Learning,
  taught by
  [Patrick Rebeschini](https://www.stats.ox.ac.uk/~rebeschi/)
  in 2018.

* [A note on the distribution of the maximum
  of a set of Poisson random variables](arxiv.org/abs/0903.4373)
  by K. M. Briggs, L. Song and T. Prellberg, 2009.

* [A note on Poisson maxima](https://link.springer.com/article/
  10.1007/BF00533727)
  by A.C. Kimber, 1983.



## Appendix: proofs

We begin by proving the main result
of this post.

<div class="box-rounded">

<h4> Proof of Bernstein's maximal inequality </h4>

We first bound the
moment generating function
of $X_{i j}$. Let $t > 0$ and note that by
the mean-zero property and the variance
and almost sure bounds,

$$
\begin{align*}
\E\left[
e^{t X_{i j}}
\right]
&=
1 + \sum_{k=2}^\infty
\frac{t^k \E[X_{i j}^k]}{k!}
\leq
1 + t^2 \sigma^2
\sum_{k=2}^\infty
\frac{t^{k-2} M^{k-2}}{k!}.
\end{align*}
$$

Now since
$k! \geq 2 \cdot 3^{k-2}$ for all $k \geq 2$
and $1 + x \leq e^x$ for all $x$,
we have for $t < 3/M$

$$
\begin{align*}
\E\left[
e^{t X_{i j}}
\right]
&\leq
1 + \frac{t^2 \sigma^2}{2}
\sum_{k=2}^\infty
\left( \frac{t M}{3} \right)^{k-2}
 =
1 + \frac{t^2 \sigma^2/2}{1 - t M/3}
\leq
\exp\left(
\frac{t^2 \sigma^2/2}{1 - t M/3}
\right).
\end{align*}
$$

Now we bound the expected maximum,
using Jensen's inequality
on the convex logarithm function,
to see

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
\sum_{i=1}^n X_{i j}
\right]
&\leq
\frac{1}{t}
\log \E\left[
\exp
\max_{1 \leq j \leq d}
\sum_{i=1}^n t X_{i j}
\right] \\
&\leq
\frac{1}{t}
\log \E\left[
\sum_{j=1}^d
\exp
\sum_{i=1}^n t X_{i j}
\right] \\
&\leq
\frac{1}{t}
\log
\big(
d \,
\E\left[
\exp
t X_{i j}
\right]^n
\big) \\
&\leq
\frac{1}{t}
\log d
+ \frac{n \sigma^2 t / 2}{1 - Mt/3}.
\end{align*}
$$

Minimizing the bound using calculus
by selecting
$t = \frac{2}{2M/3 + \sqrt{2n \sigma^2 / \log d}}$
gives

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
\sum_{i=1}^n X_{i j}
\right]
&\leq
\sqrt{2 n \sigma^2 \log d}
+ \frac{M}{3} \log d.
\end{align*}
$$

Finally we set $X_{i (d+j)} = -X_{i j}$ for $1 \leq j \leq d$
to see that

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{i j}
\right|
\right]
&\leq
\sqrt{2 n \sigma^2 \log 2d}
+ \frac{M}{3} \log 2d.
\end{align*}
$$


</div>

Next we prove the Gaussian lower bound
used in Example 1.

<div class="box-rounded">

<h4> Lemma (Gaussian lower bound) </h4>

Let $Z_1, \ldots, Z_d$ be i.i.d.
$\cN(0,1)$ random variables.
Then

$$
\E\left[
\max_{1 \leq j \leq d}
|Z_j|
\right]
\geq \frac{1}{2} \sqrt{\log d}.
$$

<h4> Proof </h4>

For any $t > 0$, we have by Markov's
inequality

$$
\E\left[
\max_{1 \leq j \leq d}
|Z_j|
\right]
\geq t \, \P\left(
\max_{1 \leq j \leq d}
|Z_j| \geq t
\right)
 =
t \left(1 - \left(1 -
\P\left(|Z_j| \geq t \right)
\right)^d \right).
$$

Now note that by the Gaussian
density function and since
$s^2 \leq 2(s-t)^2 + 2t^2$,

$$
\begin{align*}
\P\left(|Z_j| \geq t \right)
&=
\sqrt\frac{2}{\pi}
\int_t^\infty e^{-s^2/2} \diff{s}
\geq
\sqrt\frac{2}{\pi}
e^{-t^2}
\int_t^\infty e^{-(s-t)^2} \diff{s}
\geq
e^{-t^2}.
\end{align*}
$$

Hence because $1-x \leq e^{-x}$,

$$
\E\left[
\max_{1 \leq j \leq d}
|Z_j|
\right]
\geq
t \left(1 - \left(1 -
e^{-t^2}
\right)^d \right)
\geq
t \left(1 -
\exp\left(-d e^{-t^2}
\right) \right).
$$

Finally set $t = \sqrt{\log d}$
to see

$$
\E\left[
\max_{1 \leq j \leq d}
|Z_j|
\right]
\geq
\sqrt{\log d} \left(1 - 1/e \right)
\geq
\frac{1}{2}\sqrt{\log d}.
$$

</div>

Finally we establish the
Poisson lower bound
used in Example 2.

<div class="box-rounded">

<h4> Lemma (Poisson lower bound) </h4>

Let $Z_1, \ldots, Z_d$ be i.i.d.
$\Pois(1)$ random variables.
Then for $d \geq 16$,

$$
\E\left[
\max_{1 \leq j \leq d}
Z_j
\right]
\geq \frac{\log d}{6 \log \log d}.
$$

<h4> Proof </h4>

As for the Gaussian lower bound, we have for any integer $t \geq 2$

$$
\E\left[
\max_{1 \leq j \leq d}
Z_j
\right]
\geq
t \left(1 - \left(1 -
\P\left(Z_j \geq t \right)
\right)^d \right).
$$

Now note that

$$
\begin{align*}
\P\left(Z_j \geq t \right)
&=
\frac{1}{e} \sum_{k=t}^\infty
\frac{1}{k!}
\geq
\frac{1}{e t!}
\geq
\frac{1}{e t^t}.
\end{align*}
$$

Hence noting that $\log \log \log d \geq 0$ and setting
$\frac{e-1}{e}\frac{\log d}{\log \log d}
\leq t \leq \frac{\log d}{\log \log d}$
gives

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
|Z_j|
\right]
&\geq
t \left(1 - \left(1 -
\frac{1}{e t^t}
\right)^d \right) \\
&\geq
t \left(1 - \left(1 -
e^{-1} \exp(-t \log t)
\right)^d \right) \\
&\geq
\frac{e-1}{e}
\frac{\log d}{\log \log d}
\left(1 - \left(1 -
e^{-1} \exp\left(
-\frac{\log d}{\log \log d}
\log \frac{\log d}{\log \log d}
\right)
\right)^d \right) \\
&\geq
\frac{e-1}{e}
\frac{\log d}{\log \log d}
\left(1 - \left(1 -
\frac{1}{e d}
\right)^d \right) \\
&\geq
\frac{e-1}{e}
\frac{\log d}{\log \log d}
\left(1 - e^{-1/e} \right) \\
&\geq
\frac{\log d}{6 \log \log d}.
\end{align*}
$$

</div>
