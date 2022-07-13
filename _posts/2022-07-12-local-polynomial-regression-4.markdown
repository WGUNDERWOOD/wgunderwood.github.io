---
layout: post
title:  "Local Polynomial Regression 4: Application to Global Warming"
date:   2022-07-12
---

In this final post on local polynomial regression
we apply the local polynomial estimator
to global warming data.

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
The data set takes the form of yearly mesasurements
of global temperature anomaly between 1880 and 2021,
giving 142 samples in total.
We set the independent variable as the measurement year
and the dependent variable as the temperature anomaly,
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



## Results

TODO

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
    src="/assets/graphics/posts/images_local-polynomial-regression/global_warming_small.gif">
<figcaption>
  Fig. 1: TODO
</figcaption>
</figure>


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
    src="/assets/graphics/posts/images_local-polynomial-regression/global_warming_loocv.png">
<figcaption>
  Fig. 2: TODO
</figcaption>
</figure>

TODO talk about non-independence maybe leading to smaller bandwidth choice
