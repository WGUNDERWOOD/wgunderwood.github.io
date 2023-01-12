---
layout: post
title:  "Bernstein's Inequality"
date:   2022-11-02
---

Bernstein's inequality is an important concentration inequality.
In this post we motivate and prove it,
and also show its approximate optimality
through weak convergence.

{% include mathjax.html %}

<div style="display:none">
  $ \newcommand \P {\mathbb{P}} $
  $ \newcommand \E {\mathbb{E}} $
</div>

## Introduction

Concentration inequalities are central to
probability theory, mathematical statistics and the
theory of machine learning,
providing a mathematical framework to the notion that
"with enough samples you eventually get the right answer."
More precisely, they provide a bound on the probability
that a sum of random variables deviates from its expected value
by a certain quantity.
We begin this post by giving some basic concentration
inequalities and their proofs.

## Basic concentration inequalities

The following concentration inequalities are the
building blocks of more sophisticated results,
and help to build intuition.
We start with Markov's inequality,
the fundamental result on which
almost all other concentration inequalities rest.

<div class="box-rounded">

<h4> Theorem 1 (Markov's inequality) </h4>

Let $X \geq 0$ be a random variable
and $t>0$. Then
$
\P\left(X > t\right)
\leq \frac{1}{t} \E[X].
$

</div>





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
