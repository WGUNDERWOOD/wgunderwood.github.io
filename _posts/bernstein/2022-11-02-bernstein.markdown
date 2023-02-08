---
layout: post
title:  "Bernstein's Inequality 1: Introduction"
date:   2022-11-02
---

Bernstein's inequality is an important concentration inequality.
In this post we motivate, state and prove a
version which I think
is clearer than the usual formulation.

{% include mathjax.html %}

<div style="display:none">
  $ \newcommand \R {\mathbb{R}} $
  $ \newcommand \P {\mathbb{P}} $
  $ \newcommand \E {\mathbb{E}} $
  $ \newcommand \I {\mathbb{I}} $
  $ \newcommand \V {\mathbb{V}} $
  $ \newcommand \cX {\mathcal{X}} $
</div>

## Introduction

Concentration inequalities are central to
probability theory, mathematical statistics and theoretical machine learning,
providing a mathematical framework to the notion that
"with enough samples you eventually get the right answer."
More precisely, they provide a bound on the probability
that a random variable deviates from its expected value
by more than a specified amount.
Bernstein's inequality allows tight control
on the tail probabilities of a sum of random variables
where variance and almost sure bounds on the summands are available.

## Setup

In many applications, we need to control the largest entry in a sum
of possibly high-dimensional random vectors.
For example,
we might be proving uniform convergence
of a statistical estimator,
establishing consistency for a
binary classifier under empirical risk minimization,
or controlling the regret of an online learning algorithm.

As such, we propose the following setup:
for $n \geq 1$, let $X_1, \ldots, X_n$ be
independent and identically distributed (i.i.d.)
random variables taking values in $\R^d$ for some $d \geq 1$.
We assume that $\E[X_1] = 0$ and consider the sum
$\sum_{i=1}^n X_i$.
Of course, we will need to make some further assumptions
on the distribution of $X_1$.
Firstly we insist that the variance of each component
is bounded:
$\max_{1 \leq j \leq d} \V[X_1]\_{jj} \leq \sigma^2$.
This tells us about the approximate scale
of the random variables,
but in order to get better (exponential rather than $L^2$)
bounds, we also make an assumption on the maximum size
of any component:
$\\\|X_1\\\|_\infty \leq M$ almost surely.
These assumptions will be discussed more later in the post.

## Bernstein's inequality

Now let's state the main result.
The proof of Bernstein's inequality
is provided later in the post,
to avoid distracting from the discussion.

<div class="box-rounded">

<h4> Theorem  (Bernstein's inequality) </h4>

For $n \geq 1$ and $d \geq 1$,
let $X_1, \ldots, X_n$ be
i.i.d. random variables taking values in $\R^d$.
Suppose $\E[X_1] = 0$,
$\max_{1 \leq j \leq d} \V[X_1]_{jj} \leq \sigma^2$
and $\|X_1\|_\infty \leq M$ almost surely.
Then

$$
\P\left(
\left\|
\sum_{i=1}^n
X_i
\right\|_\infty
\geq
\sqrt{4 n \sigma^2 (t + \log 4d)}
+ \frac{4}{3} M (t + \log 4d)
\right)
\leq e^{-t}.
$$


</div>

## Sums of random variables

independent and identically distributed





Let $X_1, \ldots, X_n$ be independent and identically distributed
(i.i.d.) random variables which are non-negative.
Then



a version of Bernstein's inequality
which I think is easier to understand than the form usually presented.


<div style="display:none">
  $\newcommand \N {\mathbb{N}}$
  $\newcommand \P {\mathbb{P}}$
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \Var {\mathrm{Var}}$
  $\newcommand \cN {\mathcal{N}}$
  $\newcommand \Ber {\mathrm{Ber}}$
  $\newcommand \Bin {\mathrm{Bin}}$
  $\newcommand \Pois {\mathrm{Pois}}$
</div>

Let $X_1, \ldots, X_n \sim \Ber(p)$ be independent where $p \in (0,1)$.
Note that $\E[X_i] = p$ and $\Var[X_i] = p(1-p)$,
so by the central limit theorem we have

$$
\frac{1}{\sqrt{n p(1-p)}}
\sum_{i=1}^n (X_i - p)
\xrightarrow{d} \cN(0,1).
$$

Now let $X_1, \ldots, X_n \sim \Ber(p/n)$ be independent where $p \in (0,1)$.
Note that $\sum_{i=1}^n X_i \sim \Bin(n, p/n)$
so for any $k \in \N$ we have

$$
\begin{align*}
\P\left(\sum_{i=1}^n X_i = k\right)
&= \frac{n!}{k!(n-k)!}
\left(\frac{p}{n}\right)^k
\left(1 - \frac{p}{n}\right)^{n-k} \\
&= \frac{p^k}{k!}
\frac{n(n-1) \cdots (n-k+1)}{n^k}
\left(1 - \frac{p}{n}\right)^n
\left(1 - \frac{p}{n}\right)^{-k} \\
&\to \frac{p^k e^{-p}}{k!}
\end{align*}
$$

and so we conclude that

$$
\sum_{i=1}^n X_i
\xrightarrow{d} \Pois(p).
$$


TODO show that these two examples prove that both terms
are necessary in Bernstein's inequality
