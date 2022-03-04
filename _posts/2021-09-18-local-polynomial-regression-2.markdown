---
layout: post
title:  "Local Polynomial Regression 2: Bandwidth Selection"
date:   2021-09-18
---

This post, the second in a series on local polynomial regression,
investigates bandwidth selection procedures for the
Nadaraya--Watson estimator introduced in
[part one](/2021/09/05/local-polynomial-regression-1.html).

In the previous post we defined the Nadaraya--Watson estimator
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
</div>

## Bandwidth selection in theory

A key concept in understanding bandwidth selection is the *bias-variance tradeoff*.
Intuitively, the bias of an estimator is the error it makes on average,
while the variance is a measure of how unpredictable the estimator is.

Crucially, a more "complex" estimator has less bias but more variance,
while more data tends to reduce the variance and does not affect the bias.
As such, we can control the bias-variance tradeoff by increasing the complexity
as more data becomes available.

Let $\widehat \mu(x)$ be an estimator of the regression function
$\mu(x) = \E[y_i \mid x_i = x]$.
Then the bias and variance of $\widehat \mu(x)$ are defined as

$$
B(x) = \E\big[ \widehat \mu(x) \big] - \mu(x), \qquad
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
B^2 = \int_\R B(x)^2 \diff{x}, \qquad
V = \int_\R V(x) \diff{x}.
$$

We can then aim to minimize the integrated MSE (IMSE)

$$
\IMSE = B^2 + V.
$$


### Theory of the Nadaraya--Watson estimator

Recall from
[part one](/2021/09/05/local-polynomial-regression-1.html)
that the Nadaraya--Watson estimator is defined as

$$
\widehat \mu(x) =
\frac{\sum_{i=1}^n y_i K\left(\frac{x_i-x}{h}\right)}
{\sum_{i=1}^n K\left(\frac{x_i-x}{h}\right)}.
$$

#### Bias

Assume that the data $(x_i, y_i)$ are independent
and identically distributed.
Let $x_i$ have density function $f(x)$ and write
$\sigma_K^2 = \int_\R x^2 K(x) \diff{x}$.
Then we can calculate the approximate bias
using Taylor's theorem as

$$
\begin{align*}
\E\big[\widehat \mu(x)\big] - \mu(x)
&\approx
\frac{\E\left[y_i \frac{1}{h} K\left(\frac{x_i-x}{h}\right)\right]}
{\E\left[\frac{1}{h} K\left(\frac{x_i-x}{h}\right)\right]}
- \mu(x) \\
&\approx
\frac{\mu(x)f(x) + h^2 \sigma_K^2
\big(\mu'(x)f'(x) + \mu''(x)f(x)/2 + \mu(x)f''(x)/2\big)}
{f(x) + h^2 \sigma_K^2 f''(x)/2}
- \mu(x) \\
&\approx
h^2 \sigma_K^2
\left( \frac{\mu'(x)f'(x)}{f(x)} + \frac{\mu''(x)}{2} \right).
\end{align*}
$$

#### Variance

Similarly if we write
$\sigma_\varepsilon^2 = \Var[y_i \mid x_i = x]$
(this does not depend on $x$
so we say the model is homoscedastic)
and $R_K = \int_\R K(x)^2 \diff{x}$
then the variance can be approximated using
$\Var[X/Y] \approx
(\Var[X]\E[Y]^2 + \Var[Y]\E[X]^2 - 2\Cov[X,Y]\E[X]\E[Y])/\E[Y]^4$:

$$
\begin{align*}
\Var\left[\frac{1}{n} \sum_{i=1}^n
y_i \frac{1}{h} K\left(\frac{x_i-x}{h}\right)\right]
&\approx
\frac{1}{nh} f(x) R_K \big( \mu(x)^2 + \sigma_\varepsilon^2 \big), \\
\Var\left[\frac{1}{n} \sum_{i=1}^n
\frac{1}{h} K\left(\frac{x_i-x}{h}\right)\right]
&\approx
\frac{1}{nh} f(x) R_K, \\
\Cov\left[\frac{1}{n} \sum_{i=1}^n
y_i \frac{1}{h} K\left(\frac{x_i-x}{h}\right),
\frac{1}{n} \sum_{i=1}^n
\frac{1}{h} K\left(\frac{x_i-x}{h}\right) \right]
&\approx
\frac{1}{nh} \mu(x) f(x) R_K
\end{align*}
$$

so


$$
\begin{align*}
\Var\big[\widehat \mu(x)\big]
&\approx
\frac{1}{nh} \frac{R_K \sigma_\varepsilon^2}{f(x)}.
\end{align*}
$$

#### MSE

Therefore the MSE and IMSE of the Nadaraya--Watson
are approximately

$$
\begin{align*}
\MSE(x)
&\approx
h^4 \sigma_K^4
\left( \frac{\mu'(x)f'(x)}{f(x)} + \frac{\mu''(x)}{2} \right)^2
+ \frac{1}{nh} \frac{R_K \sigma_\varepsilon^2}{f(x)}, \\
\IMSE
&\approx
h^4 \sigma_K^4
\int_\R
\left( \frac{\mu'(x)f'(x)}{f(x)} + \frac{\mu''(x)}{2} \right)^2
\diff{x}
+ \frac{1}{nh}
\int_\R
\frac{R_K \sigma_\varepsilon^2}{f(x)}
\diff{x}.
\end{align*}
$$

In principle it is now possible to select the bandwidth
by minimizing the IMSE over $h$.
However the IMSE depends on
$\mu(x)$, $f(x)$ and $\sigma_\varepsilon^2$,
each of which is itself unknown.
Nonetheless, balancing the bias and variance terms
shows that the optimal bandwidth must be on the order of
$h \asymp n^{-1/5}$.







## Bandwidth selection in practice

Since minimizing the IMSE is not feasible,
we investigate some alternative methods for selecting
the bandwidth.

### Minimizing the empirical integrated mean squared error

A natural first attempt at practical bandwidth selection
is to minimize some estimate of the IMSE.
We can replace the true IMSE

$$
\IMSE(x)
= \int_\R
\E\Big[ \big(\widehat \mu(x) - \mu(x) \big)^2 \Big]
\diff{x}
$$

with its (reweighted) sample version

$$
\widehat\IMSE(x)
= \frac{1}{n} \sum_{i=1}^n
\big(y_i - \widehat \mu(x_i) \big)^2
$$

and minimize this instead.
However this does not work,
since as $h \to 0$,
we have
$\widehat \mu(x_i) \to y_i$!
To see this, note that whenever $h$ is less than
the smallest gap between any two points $x_i$,
then the kernel centered at $x_i$ cannot
"see" any other points, so

$$
\widehat \mu(x) =
\frac{y_i K\left(\frac{x_i-x}{h}\right)}
{K\left(\frac{x_i-x}{h}\right)}
= y_i.
$$

Therefore this naive method will always select $h \approx 0$.
This phenomenon is illustrated in TODO

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
