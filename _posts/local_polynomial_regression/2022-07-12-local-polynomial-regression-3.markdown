---
layout: post
title:  "Local Polynomial Regression 3: Correcting Bias"
date:   2022-07-12
---

This post is the third in a series on local polynomial regression,
motivating the local polynomial estimator through bias reduction.

Towards the end of
[part one](/2021/09/05/local-polynomial-regression-1.html)
we briefly noted some potential problems
regarding the bias of the Nadaraya--Watson estimator.
In this post we will finally introduce the local polynomial estimator
and show how it can alleviate these issues.
As in
[part two](/2022/03/29/local-polynomial-regression-2.html)
we focus on the Epanechnikov kernel,
and in this post the plots will be significantly oversmoothed
(bandwidth too large)
to better display the effects of bias.

{% include mathjax.html %}

<div style="display:none">
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \P {\mathbb{E}}$
  $\newcommand \R {\mathbb{R}}$
  $\newcommand \Var {\mathrm{Var}}$
  $\newcommand \Cov {\mathrm{Cov}}$
  $\newcommand \T {\mathsf{T}}$
  $\newcommand{\diff}[1]{\,\mathrm{d}#1}$
  $\DeclareMathOperator{\MSE}{MSE}$
  $\DeclareMathOperator{\IMSE}{IMSE}$
  $\DeclareMathOperator{\LOOCV}{LOO-CV}$
</div>

## Boundary bias

The Nadaraya--Watson is susceptible to *boundary bias*,
where an estimator consistently over or underestimates
the true regression function at the edge of the support of the data.
Note how in Figure 1 the estimated function lies significantly
below the true function at the left edge of the plot.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 700px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/boundary_bias.svg">
<figcaption>
  Fig. 1: The Nadaraya-Watson estimator exhibits boundary bias.
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

This effect worsens as the bandwidth increases since a wider kernel
uses data further from the point of interest.
Note that this phenomenon also appears at the right boundary of
Figure 1, but to a lesser extent,
due to the relatively small positive gradient
of the regression function at the right edge.


## The local linear smoother

A popular method to fix the issue of boundary bias is to use
a *local linear smoother*.
Recall that the Nadaraya--Watson estimator is a local average,
with locality measured by the kernel function:

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

Suppose that at each evaluation point we fit a
local linear model rather than a simple local average.
This is equivalent to weighted least-squares regression,
with the weights given by the kernel,
and yields the following formulation:

$$
\widehat \mu(x) = e_1^\T
\big(P(x)^\T W(x) P(x)\big)^{-1} P(x)^\T W(x) Y
$$

where $e_1 = (1, 0)^\T \in \R^2$
is a standard basis vector,
$P(x) \in \R^{n \times 2}$
with
$P(x)\_{i1} = 1$
and $P(x)\_{i2} = \frac{X\_i - x}{h}$,
and $W(x) \in \R^{n \times n}$
is diagonal with
$W(x)\_{ii} = \frac{1}{h} K\left(\frac{X_i - x}{h}\right)$.




<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 700px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/boundary_bias_fixed.svg">
<figcaption>
  Fig. 2: The local linear smoother has much less boundary bias.
</figcaption>
</figure>


As seen in Figure 2, the local linear smoother is able to
reproduce the linear trend at boundaries and thus
accounts for boundary bias much better than the
Nadaraya--Watson estimator.

## The local polynomial estimator

A subtle bias problem still remains with the estimator
depicted in Figure 2.
Note how in the center of the plot
the estimator is significantly above the regression function.
This is because we used a linear (first-order) smoother
which is unable to take into account the second-order curvature of
the regression function.

We could address this issue by using a local quadratic smoother
or even a higher-order polynonial.
This leads to the *degree-p local polynomial estimator*,
defined analogously to the local linear smoother as

$$
\widehat \mu(x) = e_1^\T
\big(P(x)^\T W(x) P(x)\big)^{-1} P(x)^\T W(x) Y
$$

where $e_p = (1, 0, \ldots, 0)^\T \in \R^{p+1}$
is a basis vector,
$P(x) \in \R^{n \times (p+1)}$
with
$P(x)\_{i1} = 1$
and $P(x)\_{ij} = \left(\frac{X\_i - x}{h}\right)^{j-1}$,
and $W(x) \in \R^{n \times n}$
is diagonal with
$W(x)\_{ii} = \frac{1}{h} K\left(\frac{X_i - x}{h}\right)$.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 700px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/second_order_bias_fixed.svg">
<figcaption>
  Fig. 3: The local quadratic smoother removes second-order bias.
</figcaption>
</figure>

Figure 3 shows that indeed a second-order (quadratic) local polynomial
estimator is able to remove the systematic underestimation due to
curvature, but note how the fit is less smooth.
This is a general principle: bias reduction comes at the expense
of increased variance.
Therefore in practice the degree is usually taken as
$p=0$ (Nadaraya--Watson)
or $p=1$ (local linear smoother)
to avoid overfitting.

The bandwidth for a local polynomial estimator
can be selected by leave-one-out cross-validation (LOO-CV),
as was presented in
[part two](/2022/03/29/local-polynomial-regression-2.html).


## Next time

In the next and final post we will apply the concepts discussed during the previous three
parts to some real-world data and discuss the conclusions.

## References


* The University of Oxford's course in
Applied and Computational Statistics,
taught by
[Geoff Nicholls](http://www.stats.ox.ac.uk/%7Enicholls/) in 2018

* The [Wikipedia article](https://en.wikipedia.org/wiki/Local_regression)
on local regression
