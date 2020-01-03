---
layout: post
title:  "Modes of Convergence"
date:   2020-01-02 21:17:31 +0000
categories: mathematics math probability analysis
---

This is a short article on the probabilistic notion of
*modes of convergence*.
In particular it focuses on the relative strengths of these convergences,
and includes a helpful diagram.
The original PDF and source code files are available on
[GitHub](https://github.com/WGUNDERWOOD/convergence-modes/).




{% include mathjax.html %}

<div style="display:none">
  $\newcommand \dP {\;\mathrm{d}\mathbb{P}}$
</div>



## Introduction

In probability theory, we use several notions of "convergence" for
a sequence of random variables.
Some of these notions are stronger than others, so it is natural to ask
when one convergence implies another.
In the following definitions and results, we assume that $X$ and $(X_n)_{n \geq 1}$ are all
real-valued random variables on some complete probability space
$(\Omega, \mathcal{F}, \mathbb{P})$.

## Definitions

Below are definitions for a few of the more
commonly-used modes of convergence.

### Almost sure convergence ($a.s.$)

$X_n \xrightarrow{a.s.} X$
if
$$\mathbb{P}(X_n \to X \text{ as } n \to \infty) = 1$$

### Convergence in probability ($\mathbb{P}$)

$X_n \xrightarrow{\mathbb{P}} X$
if for all $\epsilon > 0$,
as $n \to \infty$,
$$\mathbb{P}(|X_n - X| > \epsilon) \to 0$$

### Convergence in distribution ($d$)

$X_n \xrightarrow{d} X$
if whenever $\mathbb{P}(X \leq \,\boldsymbol{\cdot}\,)$ is continuous at $x$,
then as $n \to \infty$,
$$\mathbb{P}(X_n \leq x) \to \mathbb{P}(X \leq x)$$

### Convergence in $L^p$, for $1 \leq p < \infty$

$X_n \xrightarrow{L^p} X$
if as $n \to \infty$,
$$\mathbb{E}[|X_n - X|^p] \to 0$$

### Convergence in $L^\infty$

First define $\\|X\\|_\infty = \inf\\{M: |X| \leq M$ almost surely$\\}$.
Then $X_n \xrightarrow{L^\infty} X$
if as $n \to \infty$,
$$\|X_n - X\|_\infty \to 0$$

### Notes on definitions

Almost sure convergence is the natural measure-theoretic extension of the
notion of pointwise convergence of functions.
We simply require the convergence to occur at almost every point rather
than at every point.

Convergence in probability is (as we will see) weaker than this, and means that
with high probability, $(X_n)$ will not make large deviations from $X$.

Convergence in distribution is even weaker, and depends only on the
*distributions* of the random variables.
The random variables do not even need to be defined on the same probability space.

The $L^p$ spaces define a whole family of modes of convergence, with a larger value of $p$ giving
stronger convergence.
Convergence in $L^\infty$ is the same as uniform convergence almost everywhere.


## Results

All of the results are summarised in Figure 1.
Arrows indicate strength of convergence.


<img style="float: left; padding-bottom: 30px; padding-top: 5px;"
src="/assets/graphics/posts/images_modes-of-convergence/diagram.png">




## Proofs

A proof is given for each arrow in Figure 1.

### 1. $L^\infty$ convergence implies $L^p$ convergence
$$
\begin{align*}
  \mathbb{E}[|X_n - X|^p]
  &= \int_\Omega |X_n - X|^p \dP \\
  &\leq \|X_n - X\|_\infty^p \int_\Omega \dP \\
  &\to 0
\end{align*}
$$


### 2. $L^p$ convergence implies $L^1$ convergence
$$
\begin{align*}
  \mathbb{E}[|X_n - X|]^p
  &\leq \mathbb{E}[|X_n - X|^p]
  & \text{(Jensen's inequality for $p \geq 1$)} \\
  &\to 0
\end{align*}
$$

### 3. $L^1$ convergence implies convergence in probability
$$
\begin{align*}
  \mathbb{P}(|X_n - X| > \epsilon)
  &= \int_\Omega \mathbb{I}\{|X_n - X| > \epsilon\} \dP \\
  &\leq \int_\Omega \frac{1}{\epsilon} \, |X_n - X| \dP & \text{(Markov's inequality)} \\
  &\leq \frac{1}{\epsilon} \, \mathbb{E}[|X_n - X|] \\
  &\to 0
\end{align*}
$$

### 4. Convergence in probability implies convergence in $L^1$, in a uniformly integrable family
Assuming $(X_n)$ is uniformly integrable; for any $\epsilon > 0$,
there is a $\delta > 0$ such that for
any $B \in \mathcal{F}$,
$$\mathbb{P}(B) < \delta \implies \int_\Omega |X_n - X| \, \mathbb{I}_B \dP < \frac{\epsilon}{2}$$

Also, $X_n \xrightarrow{\mathbb{P}} X$ so there is an $N \in \mathbb{N}$ such that
$$n \geq N \implies \mathbb{P}\left(|X_n - X| \geq \frac{\epsilon}{2}\right) < \delta$$

Putting these together:

$$
\begin{align*}
  \mathbb{E}[|X_n - X|]
  &= \int_\Omega |X_n - X| \, \mathbb{I}\left\{|X_n - X| < \frac{\epsilon}{2}\right\} \dP \\
  &\qquad + \int_\Omega |X_n - X| \, \mathbb{I}\left\{|X_n - X| \geq \frac{\epsilon}{2}\right\} \dP \\
  &< \epsilon
\end{align*}
$$



### 5. $L^\infty$ convergence implies almost sure convergence
Since $\\|X_n - X\\|_\infty \to 0$;
for any $\epsilon>0$ there is an $N \in \mathbb{N}$ such that
$$n \geq N \implies \|X_n - X\|_\infty < \epsilon$$

So by the definition of $\\|\cdot\\|_\infty$,

$$
\begin{align*}
  &\quad \,\, \mathbb{P}(|X_n - X| > \epsilon \text{ for some } n \geq N) \\
  &\leq \mathbb{P}(|X_n - X| > \|X_n - X\|_\infty \text{ for some } n \geq N) \\
  &= \mathbb{P}\Big(\bigcup_{n=1}^\infty \big\{|X_n - X| > \|X_n - X\|_\infty \big\} \Big) \\
  &\leq \sum_{n=1}^\infty \mathbb{P}\big(|X_n - X| > \|X_n - X\|_\infty \big) \\
  &= 0
\end{align*}
$$

### 6. Almost sure convergence implies convergence in probability
Fix $\epsilon$ and let
$A_N = \{|X_n - X| < \epsilon \text{ for all } n \geq N\}$.
Note that $A_N$ increases to
$$\bigcup_{N=1}^\infty A_N = \{|X_n - X| < \epsilon \text{ eventually}\}
\supseteq \{X_n \to X\}$$

Therefore

$$
\begin{align*}
  \mathbb{P}(|X_N - X| < \epsilon)
  &\geq \mathbb{P}(A_N) \\
  &\to \mathbb{P}\Big(\bigcup_{N=1}^\infty A_N\Big) \\
  &\geq \mathbb{P}(X_n \to X) \\
  &= 1
\end{align*}
$$

### 7. Convergence in probability implies convergence in distribution
Take $x$ to be a continuity point of $\mathbb{P}(X \leq \,\boldsymbol{\cdot}\,)$, and
fix an $\epsilon > 0$. Then
$$
\begin{align*}
  \mathbb{P}(X_n \leq x)
  &\leq \mathbb{P}(X \leq x+\epsilon) + \mathbb{P}(|X_n - X| > \epsilon) \\
  &\to \mathbb{P}(X \leq x+\epsilon) \qquad \text{as } n \to \infty
\end{align*}
$$

Similarly

$$
\begin{align*}
  \mathbb{P}(X_n \leq x)
  &\geq \mathbb{P}(X \leq x-\epsilon) - \mathbb{P}(|X_n - X| > \epsilon) \\
  &\to \mathbb{P}(X \leq x-\epsilon) \qquad \text{as } n \to \infty
\end{align*}
$$

So $\mathbb{P}(X_n \leq x) \to \mathbb{P}(X \leq x)$, by continuity at $x$.
