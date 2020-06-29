---
layout: post
title:  "The Waiting Time Paradox"
date:   2020-06-27
---

Why is my train always late?
Why do lightbulbs last so long?
Are prison sentences too harsh?

These are some questions which can perhaps be answered with
an understanding of the phenomenon underlying
the waiting time paradox and the inspection paradox.
Source code for the simulations is available on
[GitHub](https://github.com/WGUNDERWOOD/waiting-time/).



{% include mathjax.html %}

<div style="display:none">
  $\newcommand \Exp {\mathrm{Exp}}$
</div>



## Introduction

Sometimes it feels like trains are always late.
You know they arrive roughly every ten minutes,
so why do you so often have to wait for fifteen or twenty?
Is this just bad luck,
or is it probability theory?
In fact this is possibly an example of a well-known phenomenon,
known as the waiting time paradox.
In this post,
the waiting time paradox and the related inspection paradox
are presented,
and perhaps you can find examples of other circumstances
under which they might be relevant.

## The Waiting Time Paradox

Consider again the scenario of waiting for a train
which arrives approximately every ten minutes.
How long do you actually have to wait?
First let's define this question more rigorously.

### The problem

Suppose that every day,
trains start running at 4am,
and the gaps (in minutes)
between trains arriving
(the so-called *interarrival times*)
are independently distributed
$\Exp(10)$.
This means that the expected time interval
between two trains is ten minutes.
Every day you arrive at the station at 8am,
and wait for a train to arrive.
What is the expected amount of time you have to wait?

### An naive "solution"

It seems very natural to perform the following calculation:
"Trains arrive every ten minutes,
and on average I get to the station right
between two trains,
so I should expect to wait five minutes."

Before getting too technical,
lets test this empirically and see if this reasoning is right.
When running this experiment
10 000
times,
I observed that the empirical average waiting time was
10.1 minutes,
with a standard error of 0.10.
It seems as though our initial estimate
of five minutes was wrong,
and perhpas we conjecture that the correct answer
is in fact ten minutes!

### What went wrong?

Let's examine both of our assumptions carefully,
and verify them empirically.

#### "Trains arrive every ten minutes"

The interarrival times are independently distributed
$\Exp(10)$,
so the average interval between trains is indeed
10 minutes.
When generating
10 000
random intervals,
I observed that the empirical average interval was
9.8 minutes,
with a standard error of 0.10.
Hence this assumption seems correct.

#### "On average I get to the station right between two trains"

For this assumption we need to check that
on average when you get to the station,
the difference between the time since the last train
and the time until the next train
is approximately 0.
When running the experiment
10 000
times,
I observed that the empirical average waiting time was
0.10 minutes,
with a standard error of 0.10.
So this assumption also seems to be correct.

This should be very concerning:
both assumptions seem correct,
so how did we get the wrong answer?
This is the waiting time paradox.

### An intuitive explanation

The reason for our errors is perhaps rather subtle,
but should quickly become quite obvious.
The key is that while indeed the average length of
*some* interval is 10 minutes,
the average length of the interval
*during which we arrive at the station*
is longer than this.
We are unlikely to arrive during the tiny interval
between two trains which arrive almost simultaneously,
and likewise if there is a long gap between two trains,
there's a good chance we get to the station sometime
during it.

Hence what actually happens most of the time
is that we get to the station in the middle of
an unusually long gap between trains.





TODO average time



## References
