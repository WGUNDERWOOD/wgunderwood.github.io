---
layout: post
title:  "Local Polynomial Regression 1: Introduction"
date:   2021-01-10
---

Local polynomial regression is an important statistical tool
for non-parametric regression.
This post, the first in a short series,
covers the general problem setup
and introduces the Nadaraya-Watson estimator.



{% include mathjax.html %}

<div style="display:none">
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \P {\mathbb{E}}$
  $\newcommand \R {\mathbb{R}}$
</div>



## Regression

Regression problems form a large class of problems
which are central to statistical theory and methods.

### The data

Suppose we observe $n$ pairs of observations
$(x_i, y_i)$,
where each
$x_i \in \R^d$
for some dimension $d \geq 1$, and each
$y_i \in \R$.

For example, we might perform an experiment
on $n = 100$ people to determine
whether a drug helps to lower blood pressure.
We could take
$x_i$ as the pair containing both the
amount of drug administered to person $i$,
and also the age of person $i$.
The change in blood pressure for person $i$
would be represented by $y_i$.


### The model

It is natural to assume that the change in blood pressure
depends on the amount of drug administered,
possibly with some noise in the observations.
This gives the model


$$
y_i = \mu(x_i) + \varepsilon_i ,
$$

where $\mu$ is an unknown function
describing the dependence of $y$ on $x$,
and $\varepsilon_i$ is the unknown error in
observation $i$.
This error could come from
the drug affecting different people in different ways,
from measurement error in the blood pressure reading,
or any other source of noise.
We impose the condition that
$\E[\varepsilon_i | x_i] = 0$
for each $i$
to ensure that on average
each error is zero,
allowing $\mu$ to be identified.

### Parametric vs. non-parametric

The aim of regression is to use the data points
$(x_i, y_i)$
to estimate the function $\mu$.
If we assume that $\mu$ is a specific type
of function which can be determined by finitely many parameters,
then the problem is known as *parametric regression*.
Otherwise, when we do not assume a certain form for $\mu$,
the problem is called *non-parametric regression*.
For example if we suppose that $\mu$ is a quadratic
function (hence determined by its three coefficients),
the problem is parametric.
In these posts we will focus on
the more general setting of
the non-parametric problem.





## Linear regression


Plot: linear fit to linear data

Plot: linear fit to quadratic data



### Linear regression with transformed features


Plot: quadratic fit to quadratic data

Plot: quadratic fit to non-quadratic data

## The Nadaraya-Watson Estimator

### Kernels


## Next time

## References
