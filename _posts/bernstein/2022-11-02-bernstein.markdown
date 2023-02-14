---
layout: post
title:  "Bernstein's Inequality"
date:   2022-11-02
---

Bernstein's inequality is an important concentration inequality.
In this post we motivate, state and prove a
"maximal inequality "version which I think
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
  $ \newcommand \erfc {\mathrm{erfc}} $
</div>

## Introduction

Concentration inequalities are central to
probability theory, mathematical statistics and theoretical machine learning,
providing a mathematical framework to the notion that
"with enough samples you eventually get the right answer."
More precisely, they provide bounds on the
typical deviations
that a random variable makes away from its expected value.
Bernstein's inequality allows us to control
the size of a sum of random variables
where variance and almost sure bounds on the summands are available.

## Motivation

In many applications, we need to control the maximum
of many random variables.
For example,
we might be proving uniform convergence
of a statistical estimator,
establishing consistency for a
binary classifier under empirical risk minimization,
or controlling the regret of an online learning algorithm.

### Setup

As such, we propose the following setup:
for each $1 \leq j \leq d$
let $X_{1j}, \ldots, X_{nj}$ be
independent and identically distributed (i.i.d.)
real-valued random variables.
We assume that $\E[X_{1j}] = 0$ and consider the sum
$\sum_{i=1}^n X_{ij}$.
Of course, we will need to make some further assumptions
on the distribution of each $X_{1j}$.
Firstly we insist that the variance is bounded:
$\max_{1 \leq j \leq d} \V[X_{1j}] \leq \sigma^2$.
This tells us about the approximate scale
of the random variables,
but in order to get better bounds,
we also make an assumption on the maximum size
of any summand:
$|X_{1j}|_\infty \leq M$ almost surely.
Note that we do not make any assumptions
on dependencies between different values of $j$.
These assumptions will be discussed more later in the post.

## Bernstein's inequality

Now let's state the main result,
a maximal version of Bernstein's inequality.
The proof is provided later in the post,
to avoid distracting from the discussion.

<div class="box-rounded">

<h4> Theorem (Bernstein's maximal inequality) </h4>

For each $1 \leq j \leq d$,
let $X_{1j}, \ldots, X_{nj}$ be
i.i.d. real-valued random variables.
Suppose $\E[X_{1j}] = 0$,
$\max_{1 \leq j \leq d} \V[X_{1j}] \leq \sigma^2$
and |$X_{1j}| \leq M$ almost surely.
Then

$$
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{ij}
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
and the usual formulation.
These differences can be summarized as follow.


- The result is stated for the maximum of $d$ random variables.
  This is to highlight the dependence of the resulting bound on $d$.

- This version is stated as an expectation rather than a tail probability
  to avoid notational complexity,
  but can be easily strengthened to include the tail bound.

- The terms on the right hand side are rather complicated
  and perhaps unfamiliar,
  but allow us to explicitly see the typical size of maximum.
  The more standard version of Bernstein's inequality makes it difficult
  to read off this value.

### Interpreting the bound

The resulting bound of
$\sqrt{2 n \sigma^2 \log 2d} + \frac{M}{3} \log 2d$
consists of two terms
which are worth discussing separately.

- The first term is
  $\sqrt{2 n \sigma^2 \log 2d}$.
  Note that this depends on $n$ and $\sigma^2$ but not $M$,
  and has a sub-Gaussian-type dependence on the dimension.
  This is exactly the bound obtained if we assume that
  each $X_{1j}$ is $\sigma^2$-sub-Gaussian,
  and this term corresponds in some sense
  to the central limit theorem.

- The second term is
  $\frac{M}{3} \log 2d$
  and depends on $M$ but not $n$ or $\sigma^2$.
  This is a sub-exponential-type tail
  which captures rare event phenomena associated with
  bounded random variables.
  This term corresponds in some cases
  to a Poisson weak convergence of
  $\sum_{i=1}^n X_i$.


It is worth remarking at this point that
[Bennett's inequality](https://en.wikipedia.org/wiki/Bennett%27s_inequality)
provides a further refinement of Bernstein's inequality,
but the difference is minor in many
applications so we will not discuss it here.




## Examples

In this section we provide two explicit examples
which show why each of the two terms discussed above are necessary.
It is somewhat remarkable that these examples are so easy to find,
providing a straightforward demonstration of the
(approximate) optimality of Bernstein's maximal inequality.

### Example 1: central limit theorem

Let $X_{ij} = \pm \sigma$
with equal probability
and be i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Note $\E[X_{ij}] = 0$ and $\V[X_{ij}] = \sigma^2$.
By the central limit theorem
with $X_i = (X_{i1}, \ldots, X_{id})$,

$$
\begin{align*}
\frac{1}{\sigma \sqrt n}
\sum_{i=1}^n X_i
\rightsquigarrow
\cN(0,I_d)
\end{align*}
$$

as $n \to \infty$.
This implies that by a Gaussian
lower bound in the appendix,

$$
\begin{align*}
\lim_{n \to \infty} \,
\E\left[
\max_{1 \leq j \leq d}
\frac{1}{\sigma \sqrt n}
\sum_{i=1}^n X_{ij}
 \right]
=
\E\big[
\|\cN(0, I_d)\|_\infty
\big]
\geq
\frac{1}{3}
\sqrt{\log d}
\end{align*}.
$$



Thus the first term in Bernstein's maximal inequality
is unimprovable up to constants.





### Example 2: sub-exponential-type concentration




Now let $X_{ij} = M\left(1 - \frac{1}{n}\right)$
with probability $1/n$
and $-\frac{M}{n}$ with probability $1 - 1/n$,
i.i.d. for $1 \leq i \leq n$
and $1 \leq j \leq d$.
Then, using moment generating functions,

$$
\begin{align*}
\P\left(\sum_{i=1}^n \left(\frac{X_{ij}}{M} + \frac{1}{n}\right) = k\right)
&= \frac{n!}{k!(n-k)!}
\left(\frac{1}{n}\right)^k
\left(1 - \frac{1}{n}\right)^{n-k} \\
&= \frac{1}{k!}
\frac{n(n-1) \cdots (n-k+1)}{n^k}
\left(1 - \frac{1}{n}\right)^n
\left(1 - \frac{1}{n}\right)^{-k} \\
&\to \frac{e^{-1}}{k!}
\end{align*}
$$

as $n \to \infty$.
Thus with $X_i = (X_{i1}, \ldots, X_{id})$,

$$
\begin{align*}
\sum_{i=1}^n X_i
\rightsquigarrow
M (\Pois(1)-1, \ldots, \Pois(1)-1)
\end{align*}
$$

as $n \to \infty$ where each coordinate is independent.
Hence by a Poisson lower bound given in the appendix,

$$
\begin{align*}
\liminf_{n \to \infty} \,
\E\left[
\max_{1 \leq j \leq d}
\sum_{i=1}^n X_{ij}
\right]
\geq
\frac{M}{2}
\frac{\log d}{\log \log d}.
\end{align*}
$$

for large enough $d$.
Hence the second term in Bernstein's maximal inequality
is also unimprovable up to constants.




TODO check
arxiv.org/pdf/0903.4373.pdf

TODO also Kimber: note on Poisson maxima




## Appendix: proofs

<div class="box-rounded">

<h4> Proof  (Bernstein's maximal inequality) </h4>

We begin by bounding the moment generating function
of $X_{ij}$. Let $t > 0$ and note that by
the mean-zero property and by the variance
and almost sure bounds,

$$
\begin{align*}
\E\left[
e^{t X_{ij}}
\right]
&=
1 + \sum_{k=2}^\infty
\frac{t^k \E[X_{ij}^k]}{k!}
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
e^{t X_{ij}}
\right]
&\leq
1 + \frac{t^2 \sigma^2}{2}
\sum_{k=2}^\infty
\left( \frac{tM}{3} \right)^{k-2}
 =
1 + \frac{t^2 \sigma^2/2}{1 - tM/3}
\leq
\exp\left(
\frac{t^2 \sigma^2/2}{1 - tM/3}
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
\sum_{i=1}^n X_{ij}
\right]
&\leq
\frac{1}{t}
\log \E\left[
\exp
\max_{1 \leq j \leq d}
\sum_{i=1}^n t X_{ij}
\right] \\
&\leq
\frac{1}{t}
\log \E\left[
\sum_{j=1}^d
\exp
\sum_{i=1}^n t X_{ij}
\right] \\
&\leq
\frac{1}{t}
\log
\big(
d \,
\E\left[
\exp
t X_{ij}
\right]^n
\big) \\
&\leq
\frac{1}{t}
\log d
+ \frac{n \sigma^2 t}{2 - 2Mt/3}.
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
\sum_{i=1}^n X_{ij}
\right]
&\leq
\sqrt{2 n \sigma^2 \log d}
+ \frac{M}{3} \log d.
\end{align*}
$$

Finally we set $X_{i (d+j)} = -X_{ij}$ for $1 \leq j \leq d$
to see that

$$
\begin{align*}
\E\left[
\max_{1 \leq j \leq d}
\left|
\sum_{i=1}^n X_{ij}
\right|
\right]
&\leq
\sqrt{2 n \sigma^2 \log 2d}
+ \frac{M}{3} \log 2d.
\end{align*}
$$


</div>




TODO CLT, Poisson proofs

## References
* [Four lectures on probabilistic
  methods for data science](https://arxiv.org/abs/1612.06661)
  by Roman Vershynin

* The University of Oxford's course on Algorithmic Foundations of Learning,
  taught by
  [Patrick Rebeschini](https://www.stats.ox.ac.uk/~rebeschi/)
