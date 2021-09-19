---
layout: post
title:  "Local Polynomial Regression 2: Bandwidth Selection"
date:   2021-09-18
---

TODO INTRO

{% include mathjax.html %}

<div style="display:none">
  $\newcommand \E {\mathbb{E}}$
  $\newcommand \P {\mathbb{E}}$
  $\newcommand \R {\mathbb{R}}$
  $\DeclareMathOperator{\MSE}{MSE}$
</div>

## Bandwidth selection in theory

TODO Define MSE
TODO Bias variance tradeoff


### Theory of the Nadaraya-Watson estimator

TODO Derive optimal bandwidth for N-W
TODO Useful for approximate magnitude but is infeasible


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
