---
layout: post
title:  "Local Polynomial Regression 4: Application to Global Warming"
date:   2022-08-09
---

In this final post on local polynomial regression
we apply the local polynomial estimator
to global warming data from NASA.

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

## Data

We use time-series data from
[NASA's Goddard Institute for Space](https://climate.nasa.gov/vital-signs/global-temperature/).
The data set takes the form of yearly measurements
of global temperature anomaly between 1880 and 2021,
giving 142 samples in total.
We set the independent variable $x_i$ as the measurement year
and the dependent variable $y_i$ as the temperature anomaly,
defined as the difference between the average yearly temperature
and the average temperature between 1951 and 1980.

## Estimator

To fit our model we use a local linear smoother (polynomial of degree 1).
As we saw in the
[first three posts](/posts/) on local polynomial regression,
this estimator has the following attractive properties:

- Flexible estimation of a wide variety of regression functions
- Local estimation (predictions only affected by "nearby" data points)
- Only one hyperparameter to choose (the bandwidth)
- Easy bandwidth selection via leave-one-out cross-validation (LOO-CV)
- Robustness against boundary bias and other first-order bias

The data is also well-suited to such an estimator as:

- The independent variable is low-dimensional (one-dimensional in this case)
- The independent variable is evenly distributed with no large gaps
- It is not clear that the regression function should take any
  specific parametric form
- There are no significant outliers visible in the data
- The data set is small so estimation is computationally tractable



## Results

In Figure 1 we plot the fit of the estimator,
animated over a range of bandwidths.
As expected, larger bandwidths give a smoother curve
with more bias and less variance.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
    src="/assets/posts/local_polynomial_regression/global_warming.svg">
<figcaption>
  Fig. 1: Local linear estimation of global warming with
  varying bandwidth
</figcaption>
</figure>


Selecting the bandwidth with leave-one-out cross-validation
as in the
[second post](/2022/03/29/local-polynomial-regression-2.html)
in this series yields Figure 2.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
    src="/assets/posts/local_polynomial_regression/global_warming_loocv.svg">
<figcaption>
  Fig. 2: Local linear estimation of global warming with
  LOO-CV bandwidth
</figcaption>
</figure>

It is possible that the fit is slightly undersmoothed here
(bandwidth too small), as the line appears to be more
jagged than one might expect.
This may be because LOO-CV relies on the assumption
that the samples are *independent*,
which may well not be true of measurements in
consecutive years.
More sophisticated methods are available for the
time-series setting which address this issue.



Nonetheless the fit seems reasonable and captures the overall trend
of the data.
We note that the smoothed version presented by
[NASA](https://climate.nasa.gov/vital-signs/global-temperature/)
indeed seems to use a larger bandwidth than we obtained by LOO-CV,
though their methodology may be slightly different.

## References

- Data from
[NASA's Goddard Institute for Space](https://climate.nasa.gov/vital-signs/global-temperature/),
accessed July 2022
