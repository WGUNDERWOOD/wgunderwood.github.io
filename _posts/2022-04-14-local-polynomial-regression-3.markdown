---
layout: post
title:  "Local Polynomial Regression 3: Bias Correction"
date:   2022-04-14
---

TODO
This post, the second in a series on local polynomial regression,
investigates bandwidth selection procedures for the
Nadaraya--Watson estimator introduced previously.

TODO
In [part one](/2021/09/05/local-polynomial-regression-1.html)
we defined the Nadaraya--Watson estimator
with kernel $K$ and bandwidth $h$
and showed how it can be used to estimate a regression function.
Throughout this post we will focus for simplicity on the
popular Epanechnikov kernel $K(x) = \frac{3}{4}(1-x^2)$
and consider methods for selecting the bandwidth $h$.

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
