---
layout: post
title:  "Bernstein's Inequality"
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
  $ \newcommand \Ber {\mathrm{Ber}} $
  $ \newcommand \Pois {\mathrm{Pois}} $
  $ \newcommand \Bin {\mathrm{Bin}} $
  $ \newcommand \cN {\mathcal{N}} $
  $ \newcommand \N {\mathbb{N}} $
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

## Motivation

In many applications, we need to control the largest entry in a sum
of possibly high-dimensional random vectors.
For example,
we might be proving uniform convergence
of a statistical estimator,
establishing consistency for a
binary classifier under empirical risk minimization,
or controlling the regret of an online learning algorithm.

### Setup

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
Note that we do not make any assumptions
on dependencies between the coordinates of $X_1$.
These assumptions will be discussed more later in the post.

## Bernstein's inequality

Now let's state the main result.
The proof of Bernstein's inequality
is provided later in the post,
to avoid distracting from the discussion.

<div class="box-rounded">

<h4> Theorem  (Bernstein's maximal inequality) </h4>

For $n \geq 1$ and $d \geq 1$,
let $X_1, \ldots, X_n$ be
i.i.d. random variables taking values in $\R^d$.
Suppose $\E[X_1] = 0$,
$\max_{1 \leq j \leq d} \V[X_1]_{jj} \leq \sigma^2$
and $\|X_1\|_\infty \leq M$ almost surely.
Then

$$
\E\left[
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right]
\leq
\sqrt{24 n \sigma^2 \log 2d}
+ 4 M \log 2d.
$$

</div>

### Why this formulation?

If you have seen Bernstein's inequality before,
you may notice a few differences between this version
and the usual formulation.
These differences can be summarized as follow.


- The result is stated for the infinity norm of a random vector,
  rather than for a real random variable.
  This is to highlight the dependence of the resulting bound
  on the dimension $d$.

- This version is stated as an expectation rather than a tail probability.
  In fact, this result can be easily strengthened to include the tail bound,
  but this distracts from the main point of the post.

- The terms on the right hand side are rather complicated
  and perhaps unfamiliar,
  but allow us to explicitly see the typical size of the infinity norm.
  The more standard version of Bernstein's inequality makes it difficult
  to read off this value.

### Interpreting the bound

The resulting bound of
$\sqrt{24 n \sigma^2 \log 2d} + 4 M \log 2d$
consists of two terms
which are worth discussing separately.

- The first term is
  $\sqrt{24 n \sigma^2 \log 2d}$.
  Note that this depends on $n$ and $\sigma^2$ but not $M$
  and has a Gaussian-type dependence on the dimension
  ($t \mapsto \sqrt{\log t}$ is the inverse of
  $t \mapsto e^{-t^2}$, a term appearing in the Gaussian tail probability).
  This is very similar to the bound obtained if we assume that
  $X_1$ is $\sigma^2$-subgaussian,
  and in fact this term corresponds in some sense
  to the central limit theorem.

- The second term is
  $4 M \log 2d$
  and depends on $M$ but not $n$ or $\sigma^2$.
  This is an exponential-type tail
  ($t \mapsto \log t$ is the inverse of
  $t \mapsto e^{-t}$, the exponential tail probability).
  which captures rare event phenomena associated with
  bounded random variables.
  We will see that this term corresponds in some cases
  to a Poisson weak convergence of
  $\sum_{i=1}^n X_i$.

### Bennett's inequality

It is worth remarking at this point that Bennett's inequality
TODO cite
provides a further refinement of Bernstein's inequality,
but the difference is minor in many
applications so we will not discuss it here.





## Examples

In this section we provide two explicit examples
which show why each of the two terms discussed above are necessary.
It is somewhat remarkable that these examples are so easy to find,
providing a straightforward demonstration of the
(approximate) optimality of Bernstein's maximal inequality.

### Example 1: subgaussian-type concentration

Let $X_{ij} = \pm \sigma$
with equal probability
and be i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Note that $\E[X_{ij}] = 0$ and $\V[X_{ij}] = \sigma^2$.
Further, by Hoeffding's inequality, TODO cite
$\E[e^{tX_{ij}}] \leq e^{t^2 \sigma^2 / 2}$.
So by Jensen's inequality on the concave logarithm function,
writing $X_i = (X_{i1}, \ldots, X_{id})$ and for any $t > 0$,

$$
\begin{align*}
\E\left[
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right]
&\leq
\frac{1}{t}
\log \E\left[
\exp
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right] \\
&\leq
\frac{1}{t}
\log \E\left[
\sum_{j=1}^d
\exp
\sum_{i=1}^n X_{ij}
\right] \\
&\leq
\frac{1}{t}
\log
\big(
d \,
\E\left[
\exp
X_{ij}
\right]^n
\big) \\
&\leq
\frac{1}{t}
\log d
+ \frac{n t \sigma^2}{2}.
\end{align*}
$$

Selecting $t = \sqrt{\frac{2 \log d}{n \sigma^2}}$
gives

$$
\begin{align*}
\E\left[
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right]
&\leq
\sqrt{2 n \sigma^2 \log d}.
\end{align*}
$$

Thus we recover the first term in Bernstein's inequality up to constants.
Here we took advantage of the fact that the uniform bound $M$
and the standard deviation $\sigma$ are actually equal,
so Hoeffding's inequality is fairly tight.




### Example 2: subexponential-type concentration

Now let $X_{ij} = M$ with probability $1/n$
and $-\frac{M}{n-1}$ with probability $1 - 1/n$,
i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Following the approach from the previous example but
this time using the elementary bound
$\E[e^{tX_{ij}}] \leq 1 + \frac{e^{tM}}{n}$,

$$
\begin{align*}
\E\left[
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right]
&\leq
\frac{1}{t}
\log
\big(
d \,
\E\left[
\exp
X_{ij}
\right]^n
\big) \\
&\leq
\frac{1}{t}
\log d
+ \frac{n}{t}
\log\left(
1 + \frac{e^{tM}}{n}
\right) \\
&\leq
\frac{1}{t}
\log d
+ \frac{1}{t} e^{tM}.
\end{align*}
$$

Setting $t = 1/M$ gives

$$
\begin{align*}
\E\left[
\left\|
\sum_{i=1}^n X_i
\right\|_\infty
\right]
&\leq
M (e + \log d)
\leq 4 M \log 2d,
\end{align*}
$$

and so we have the second term in Bernstein's inequality.




TODO format subgaussian etc
TODO mention CLT, Poisson

Refs
1612 arxiv vershynin
Patricks notes
