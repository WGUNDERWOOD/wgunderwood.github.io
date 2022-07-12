---
layout: post
title:  "Local Polynomial Regression 3: Correcting Bias"
date:   2022-04-14
---

This post is the third in a series on local polynomial regression,
motivating the local polynomial estimator through bias reduction.

Towards the end of
[part one](/2021/09/05/local-polynomial-regression-1.html)
we briefly noted some potential problems
regarding the bias of the Nadaraya--Watson estimator.
In this post we will finally introduce the local polynomial estimator
and show how it can alleviate these problems.

{% include mathjax.html %}

<div style="display:none">
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \P {\mathbb{E}}$
  $\newcommand \R {\mathbb{R}}$
  $\newcommand \Var {\mathrm{Var}}$
  $\newcommand \Cov {\mathrm{Cov}}$
  $\newcommand{\diff}[1]{\,\mathrm{d}#1}$
  $\DeclareMathOperator{\MSE}{MSE}$
  $\DeclareMathOperator{\IMSE}{IMSE}$
  $\DeclareMathOperator{\LOOCV}{LOO-CV}$
</div>

## Boundary bias

The Nadaraya--Watson is susceptible to *boundary bias*,
a phenomenon where an estimator consistently over or underestimates
the true regression function at the edge of the data.
Note how in Figure 1 the estimated function lies significantly
below the true function at the left edge of the plot.



<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/boundary_bias.png">
<figcaption>
  Fig. 1: TODO.
</figcaption>
</figure>

The reason for this effect is related to the gradient of the true
regression function at the boundary.
In particular, suppose that the regression function is decreasing
at the left boundary, as in Figure 1.
When evaluating the estimator near this boundary point,
almost all of the data "seen" by the kernel lies to the right.
Then the negative gradient implies that these data points are
on average lower than would be expected if the data were to continue
beyond the edge of the plot.
As a result, the estimator is downward biased at the left edge.

This effect worsens with the bandwidth since a wider kernel
accesses data which is more biased.
Note that this phenomenon also appears at the right edge of
Figure 1, but to a lesser extent,
due to the relatively small positive gradient
of the regression function at the right boundary.


## Local linear smoother
TODO
Recap of linear regression with formula
Give formula for local linear smoother
DONE Plot: boundary bias fixed with linear smoother

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/boundary_bias_fixed.png">
<figcaption>
  Fig. 2: TODO.
</figcaption>
</figure>

## The local polynomial estimator
Generalization
Give formula for local polynomial smoother
