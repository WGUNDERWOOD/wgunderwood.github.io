---
layout: post
title:  "Bernstein's Inequality"
date:   2022-11-02
---

This post is about Bernstein's inequality

{% include mathjax.html %}

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
