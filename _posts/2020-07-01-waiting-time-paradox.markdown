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

Suppose that every day,
trains start running at 4am,
and the gaps (in minutes)
between trains arriving
(the so-called *interarrival times*)
are independently distributed
$\Exp(10)$.
Figure TODO shows the pdf...

TODO plot exp pdf

Every day you arrive at the station at 8am,
and wait for a train to arrive.
What is the expected amount of time you have to wait?
It seems very natural to perform the following calculation:
"Trains arrive every ten minutes,
and on average I arrive right between two trains,
so I should expect to wait five minutes."

Before getting too technical,
lets test this empirically and see if this reasoning is right.

TODO average time



## References
