---
layout: post
title:  "Sub-Gaussian Chaining and Dudley's Theorem"
date:   2023-02-21
---

Chaining is a fundemental technique for bounding
the suprema of Gaussian and sub-Gaussian stochastic processes.
In this post we state and prove Dudley's theorem,
along with some simulations and diagrams.

{% include mathjax.html %}


<div style="display:none">
  $ \newcommand \cT {\mathcal{T}} $
  $ \newcommand \R {\mathbb{R}} $
  $ \newcommand \E {\mathbb{E}} $
  $ \newcommand \diff {\,\mathrm{d}} $
</div>

## Introduction

TODO Controlling sup of stochastic processes is important -- examples
TODO Define subg process and separable processes
TODO Motivation -- read 550 notes, do finite case first then argue smaller mesh sizes

## Covering numbers

TODO Define and give properties

## Dudley's theorem

<div class="box-rounded">

Let $(\cT,d)$ be a TODO not metric! metric space and
$X_t$ be real-valued random variables for
$t \in \cT$.
Suppose $\E[X_t]=0$ for all $t$
and assume the sub-Gaussian increments condition

$$
\begin{align*}
\E\big[
\exp\big(
\lambda (X_t - X_s)
\big)
\big]
&\leq
\exp\left(
\frac{\lambda^2 d(s,t)^2}{2}
\right)
\end{align*}
$$

for all $s, t \in \cT$ and $\lambda \in \R$.
Assume that there is a countable
subset $\cT' \subseteq \cT$
with $\sup_{t \in \cT} X_t = \sup_{t' \in \cT'} X_{t'}$ almost surely.
Then

$$
\begin{align*}
\E\left[
\sup_{t \in \cT}
X_t
\right]
&\leq
12
\int_{0}^{\infty}
\sqrt{\log N(\varepsilon, \cT, d)}
\diff{\varepsilon}.
\end{align*}
$$


</div>

## Sub-Gaussian chaining

TODO Use the chaining method to prove Dudley's theorem

## Examples


### Example 1: radial basis function kernel

$d_l(s, t) = \exp\left(-\frac{(s-t)^2}{2 l^2}\right)$

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/traj_RBF_l1.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/traj_RBF_l2.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/bounds_RBF.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>

### Example 2: Ornstein--Uhlenbeck kernel

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/traj_OU_l1.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/traj_OU_l2.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/gaussian_chaining/bounds_OU.svg">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>
