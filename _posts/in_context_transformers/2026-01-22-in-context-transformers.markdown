---
layout: post
title:  "Minimax-optimal in-context nonparametric regression with transformers"
date:   2026-01-22
---

Excited to share a collaboration with three brilliant undergraduate/masters
students, Michelle Ching, Ioana Popescu and Nico Smith!

{% include mathjax.html %}

In "Efficient and
minimax-optimal in-context nonparametric regression with transformers", we show
that deep transformer networks require only order $log n$ parameters to attain
optimal rates in smooth regression problems.
The paper is joint work with
[Michelle Ching](https://www.linkedin.com/in/michelle-ching-408557294/),
[Ioana Popescu](https://www.linkedin.com/in/ioana-popescu-409294253/),
[Nico Smith](https://www.linkedin.com/in/nico-smith-4730562a1/),
[Tianyi Ma](https://tianyima2000.github.io/)
and
[Richard Samworth](https://www.statslab.cam.ac.uk/~rjs57/),
and can be found at
[arXiv:2601.15014](https://arxiv.org/abs/2601.15014).


# Abstract

We study in-context learning for nonparametric regression with
$\alpha$-Hölder smooth regression functions, for some $\alpha>0$. We
prove that, with $n$ in-context examples and $d$-dimensional
regression covariates, a pretrained
transformer with $\Theta(\log n)$ parameters and
$\Omega\bigl(n^{2\alpha/(2\alpha+d)}\log^3 n\bigr)$ pretraining sequences can
achieve the minimax-optimal rate of convergence
$O\bigl(n^{-2\alpha/(2\alpha+d)}\bigr)$ in mean squared error.
Our result requires substantially fewer
transformer parameters and pretraining sequences
than previous results in the literature.
This is achieved by showing that
transformers are able to
approximate local polynomial estimators efficiently
by implementing a
kernel-weighted polynomial basis
and then running gradient descent.
