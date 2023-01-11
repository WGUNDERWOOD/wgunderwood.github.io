---
layout: post
title:  "Local Polynomial Regression 1: Introduction"
date:   2021-09-05
---

Local polynomial regression is an important statistical tool
for non-parametric regression.
This post, the first in a short series,
covers the general problem setup
and introduces the Nadaraya--Watson estimator.

The Python code is available on
[GitHub](https://github.com/WGUNDERWOOD/wgunderwood.github.io/tree/main/_posts/local_polynomial_regression).


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
Their applications include prediction, variable selection
and causality analysis.

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
or from any other source of noise.
We impose the condition that
$\E[\varepsilon_i | x_i] = 0$
for each $i$
to ensure that on average
each error is zero,
allowing $\mu$ to be identified.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/data.svg">
<figcaption>
  Fig. 1: The responses $y_i$ are plotted against the independent variables $x_i$. <br>
  The line indicates the regression function.
</figcaption>
</figure>



### Parametric vs. non-parametric

The aim of regression is to use the data points
$(x_i, y_i)$
to calculate a function $\widehat \mu$
which estimates the unknown regression function $\mu$.
If we assume that $\mu$ is a specific type
of function which can be determined by finitely many parameters,
then the problem is known as *parametric regression*.
Otherwise, when we do not assume anything about the form of $\mu$,
the problem is called *non-parametric regression*.
For example if we suppose that $\mu$ is a quadratic
function (hence determined by its three coefficients),
the problem is parametric.
In these posts we will explore
the more general setting of
the non-parametric problem.





## Parametric linear regression

The simplest regression estimator
is the parametric linear regression.
This estimator gives $\widehat \mu$
as the linear function
which minimises
the mean squared error (MSE)
defined by

$$
\MSE(\widehat \mu)
= \frac{1}{n} \sum_{i=1}^n
\big(y_i - \widehat \mu(x_i) \big)^2.
$$

Figure 2 shows how
linear regression fits a straight line
to the data.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/linear_fit_linear_data.svg">
<figcaption>
  Fig. 2: Linear regression works well when the regression function is linear.
</figcaption>
</figure>

However
if the regression function
is not linear,
this method can perform poorly,
as seen in Figure 3.
Here the regression function is clearly some kind of curve,
but our estimator is limited to straight lines.



<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/linear_fit_quadratic_data.svg">
<figcaption>
  Fig. 3: Linear regression does not work well when the regression function
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
Figure 4 shows how including $x_i^2$
can give a much better fit to the data.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/quadratic_fit_quadratic_data.svg">
<figcaption>
  Fig. 4: Quadratic regression fits the quadratic regression function well.
</figcaption>
</figure>


However if the regression function is not well-approximated
by any low-degree polynomial,
this regression method can still perform poorly,
as seen in Figure 5.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/quadratic_fit_general_data.svg">
<figcaption>
  Fig. 5: Quadratic regression does not work well with non-quadratic regression functions.
</figcaption>
</figure>


While it is tempting to use higher and higher-degree
polynomials such as cubics, quartics and quintics,
this can lead to overfitting
as shown in Figure 6,
especially when there are not many data points.

<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/polynomial_fit_general_data.svg">
<figcaption>
  Fig. 6: A degree-50 polynomial regression will often overfit.
</figcaption>
</figure>


## Non-parametric local regression

Non-parametric estimators attempt to solve these problems in
a variety of ways.
The idea behind *local* regression methods is that
at each evaluation point
the fitted regression function only needs to depend on the
data points "nearby."
This concept is made more concrete using the notion of a kernel function.


### Kernels

A kernel $K$ is a function from $\R$ to $\R$ which allows
us to quantify the local nature of a non-parametric estimator.
If $x$ is a point at which we want to estimate the regression function
and $x_i$ is a data point,
then we can use

$$
K\left(\frac{x_i - x}{h}\right)
$$

as a measure of the influence of $x_i$ at $x$,
where $h>0$ is a parameter called the *bandwidth*.
Kernels must integrate to one,
and are typically (though not always) symmetric
non-negative functions.
Figure 7 shows some commonly-used examples.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/kernels.svg">
<figcaption>
  Fig. 7: Some popular kernel functions.
</figcaption>
</figure>

The bandwidth $h$ controls how much locality is present.
If $h$ is very small then only data points which are very close to the evaluation
point are used.
If $h$ is larger then further-away points are used too.

### The Nadaraya--Watson estimator

The simplest local regression estimator is the Nadaraya--Watson estimator,
which works as follows.
First pick a kernel and a bandwidth.
For each evaluation point $x$,
find the "importance" of each data point $x_i$ using the kernel function
and bandwidth.
Then average all of the responses $y_i$, weighted according to this importance.
As an equation, this gives

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

Note how we do not assume anything about the form of the
underlying regression function,
though it is necessary to choose an appropriate bandwidth $h$.


<figure style="display: block; margin-left: auto; margin-right: auto;">
<img style="width: 600px; margin-left: auto; margin-right: auto;"
src="/assets/posts/local_polynomial_regression/nadaraya_fit_general_data.svg">
<figcaption>
  Fig. 8: The Nadaraya&ndash;Watson estimator adapts to a broad class of functions.
</figcaption>
</figure>

There are several interesting features in Figure 8.
Firstly, note how $\widehat \mu$
underestimates $\mu$ where $\mu$ is concave (around $x=1$) and
overestimates $\mu$ where $\mu$ is convex (around $x=2$).
Secondly, note how $\widehat \mu$
overestimates $\mu$ at the left boundary and
underestimates $\mu$ at the right boundary.
These illustrate problems relating to the *bias*
of the Nadaraya--Watson estimator,
which will be investigated in later posts.

## Next time

In the next post we will address the issue of
how to choose an appropriate bandwidth
for a local regression estimator,
both in theory and in practice.
