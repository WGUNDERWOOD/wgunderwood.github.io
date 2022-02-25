---
layout: post
title:  "Local Polynomial Regression 2: Bandwidth Selection"
date:   2021-09-18
---

This post, the second in a series on local polynomial regression,
investigates bandwidth selection procedures for the
Nadaraya-Watson estimator introduced in
[part one](/2021/09/05/local-polynomial-regression-1.html).

In the previous post we defined the Nadaraya-Watson estimator
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
  $\newcommand{\diff}[1]{\,\mathrm{d}#1}$
  $\DeclareMathOperator{\MSE}{MSE}$
  $\DeclareMathOperator{\IMSE}{IMSE}$
</div>

## Bandwidth selection in theory

A key concept in understanding bandwidth selection is the *bias-variance tradeoff*.
Intuitively, the bias of an estimator is the error it makes on average,
while the variance is a measure of how unpredictable the estimator is.

Crucially, a more "complex" estimator has less bias but more variance,
while more data tends to reduce the variance and does not affect the bias.
As such, we can control the bias-variance tradeoff by increasing the complexity
as more data becomes available.

Let $\widehat \mu(x)$ be an estimator of the regression function $\mu(x)$.
Then the bias and variance of $\widehat \mu(x)$ are defined as

$$
B(x) = \E\big[ \widehat \mu(x) \big] - \mu(x), \\
V(x) = \E\Big[ \big(\widehat \mu(x) - \E\big[ \widehat \mu(x) \big] \big)^2 \Big]
$$

respectively.
Crucially, the bias and variance together determine the
pointwise mean squared error (MSE) of the estimator defined as

$$
\MSE(x)
= \E\Big[ \big(\widehat \mu(x) - \mu(x) \big)^2 \Big]
= B(x)^2 + V(x).
$$

This property is know as the *bias-variance decomposition*.
Since we want an estimator which performs well over all points $x$,
it is common to define the following integrated versions of the bias and variance.

$$
B^2 = \int_R B(x)^2 \diff{x}, \\
V = \int_R V(x) \diff{x}. \\
$$

We can then aim to minimize the integrated MSE (IMSE)

$$
\IMSE = B^2 + V.
$$


### Theory of the Nadaraya-Watson estimator

TODO Derive optimal bandwidth for N-W
TODO Useful for approximate magnitude but is infeasible

Recall from
[part one](/2021/09/05/local-polynomial-regression-1.html)
that the Nadaraya--Watson estimator is defined as

$$
\widehat \mu(x) =
\frac{
  \sum_{i=1}^n
  y_i K\left(\frac{x_i-x}{h}\right)
}
{
  \sum_{i=1}^n
  K\left(\frac{x_i-x}{h}\right)
}.
$$

TODO read NPR N-W Estimator.pdf



## Bandwidth selection in practice

TODO Investigate some potential methods

### Minimizing the empirical integrated mean squared error

TODO Does not work -- overfit
TODO Plot this


### Leave-one-out cross-validation

TODO Define LOO-CV
TODO Plot this




### Estimating the mean squared error

TODO Actually don't know how well this works...
TODO Plot this



## Concluding remarks

TODO Sometimes there is no global optimal bandwidth
TODO Solutions to this?
