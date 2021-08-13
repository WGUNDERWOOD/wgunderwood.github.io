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
  $\DeclareMathOperator{\MSE}{MSE}$
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
$x_i$ as the
amount of drug administered to person $i$,
while $y_i$ could represent
the change in blood pressure for person $i$.


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
to calculate a function $\widehat \mu$
which estimates the unknown regression function $\mu$.
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

The simplest regression estimator
is the parametric linear regression.
This estimator gives $\widehat \mu$
as the linear function which minimises
the mean squared error (MSE)
defined by

$$
\MSE(\widehat \mu)
= \frac{1}{n} \sum_{i=1}^n
\big(y_i - \widehat \mu(x_i) \big)^2.
$$

Figure 1 shows how
linear regression can fit a straight line
to the data.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/linear_fit_linear_data.png">
<figcaption>
  Fig. 1: Linear regression works well when the regression function is linear.
</figcaption>
</figure>

However
if the regression function
is not linear,
this method can perform poorly,
as seen in Figure 2.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/linear_fit_quadratic_data.png">
<figcaption>
<br>
  Fig. 2: Linear regression does not work well when the regression function
  is non-linear.
</figcaption>
</figure>



### Linear regression with transformed features

One possible solution to this problem
is to include transformations of $x_i$
as extra features.
For example,
suppose that $x_i \in \R$,
so that $d=1$.
Then one could use not only the variables $x_i$
but also $x_i^2$,
allowing quadratic curves to be fitted to the data.
This gives rise to so-called
*polynomial regression*.
Figure 3 shows how including $x_i^2$
can give a much better fit to the data.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/quadratic_fit_quadratic_data.png">
<figcaption>
<br>
  Fig. 3: Quadratic regression fits the quadratic regression function well.
</figcaption>
</figure>


However if the regression function is not
a low-degree polynomial,
this method can still perform poorly,
as seen in Figure 4.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/quadratic_fit_general_data.png">
<figcaption>
<br>
  Fig. 4: Quadratic regression does not work well with non-quadratic regression functions.
</figcaption>
</figure>


While it is tempting to use higher and higher-degree
polynomials,
this can lead to overfitting
as shown in Figure 5,
especially when there are not many data points.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 500px; margin-left: auto; margin-right: auto;"
src="/assets/graphics/posts/images_local-polynomial-regression/polynomial_fit_general_data.png">
<figcaption>
<br>
  Fig. 5: Polynomial regression can overfit.
</figcaption>
</figure>


## The Nadaraya-Watson Estimator

### Kernels


## Next time

## References
