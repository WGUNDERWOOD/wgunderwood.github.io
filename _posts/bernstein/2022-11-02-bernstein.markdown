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

TODO can we do better? check where the proof gives the fraction-style version.

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

- The lower bound inside the probability is rather complicated.
  This is so one can explicitly see the typical size of the infinity norm.
  The more standard version of Bernstein's inequality makes it difficult
  to see this bound.

### Interpreting the bound

The resulting bound of
$\sqrt{4 n \sigma^2 (t + \log 4d)} + \frac{4}{3} M (t + \log 4d)$
consists of two terms
which are worth discussing separately.

- The first term is
  $\sqrt{4 n \sigma^2 (t + \log 4d)}$.
  Note that this depends on $n$ and $\sigma^2$ but not $M$
  and has a Gaussian-type dependence on the dimension.
  This is very similar to the bound obtained if we assume that
  $X_1$ is $\sigma^2$-subgaussian.
  In fact, we will see that this term corresponds in some sense
  to the central limit theorem for $\sum_{i=1}^n X_i$.

- The second term is
  $\frac{4}{3} M (t + \log 4d)$,
  and depends on $M$ but not $n$ or $\sigma^2$.
  This is a Poisson-type tail
  which captures rare event phenomena associated with
  bounded random variables.
  We will see that this term corresponds in some cases
  to a Poisson weak convergence of
  $\sum_{i=1}^n X_i$.

### Bennett's inequality

It is worth remarking at this point that Bennett's inequality
TODO cite
provides a further refinement of Bernstein's inequality,
but the difference is minor in many applications so we will not discuss it here.





## Examples

In this section we provide two explicit examples
which show why each of the two terms discussed above are necessary.
It is somewhat remarkable that these examples are so easy to find,
providing a straightforward demonstration of the
(approximate) optimality of Bernstein's inequality.

### Example 1: the central limit theorem

Let $X_{ij} \sim \Ber(p) - p$ be i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$ where $p \in (0,1)$.
Note that $\E[X_{ij}] = 0$ and $\sigma^2 = \V[X_{ij}] = p(1-p)$,
so by the central limit theorem we have

$$
\frac{1}{\sqrt{n \sigma^2}}
\sum_{i=1}^n X_{ij}
\xrightarrow{d} \cN(0,1)
$$

for each $1 \leq j \leq d$.
By a union bound,
writing $X_i = (X_{i1}, \ldots, X_{id})$,
we therefore have

$$
\P\left(
\left\|
\sum_{i=1}^n
X_i
\right\|_\infty
\geq
\sqrt{2 n \sigma^2 (t + \log 2d)}
\right)
\lesssim e^{-t},
$$

where we write $\lesssim$ for "approximately at most".
Thus we recover the first term in Bernstein's inequality up to constants.




### Example 2: weak convergence to a Poisson distribution




Now let $X_{ij} \sim \Ber(p/n) - p/n$ be i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$ where $p \in (0,1)$.
Note that $\sum_{i=1}^n (X_{ij} + p/n) \sim \Bin(n, p/n)$
for each $ 1\ \leq j \leq d$,
so for any $k \in \N$ we have

$$
\begin{align*}
\P\left(\sum_{i=1}^n (X_{ij} + p/n) = k\right)
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

and so

$$
\sum_{i=1}^n (X_{ij} + p/n)
\xrightarrow{d} \Pois(p).
$$

Again by a union bound, this implies that
TODO get a tail bound for the Poisson
