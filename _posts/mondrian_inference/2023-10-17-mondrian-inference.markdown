---
layout: post
title:  "Inference with Mondrian random forests"
date:   2023-10-17
---

I'm excited to share my new preprint,
titled "Inference with Mondrian random forests"
and coauthored with
[Matias Cattaneo](https://mdcattaneo.github.io/)
and
[Jason Klusowski](https://klusowski.princeton.edu/).

It can be found at
[arXiv:2310.09702](https://arxiv.org/abs/2310.09702).

<div class="frame">
<a href="https://arxiv.org/abs/2310.09702">
<img
style="width: 190px; margin-top: 5px; margin-left: 20px; margin-bottom: 15px;"
src="/assets/posts/mondrian_inference/piet.jpg">
</a>
</div>

{% include mathjax.html %}

# Abstract

Random forests are popular methods for classification and regression,
and many different variants have been proposed in recent years.
One interesting example is the Mondrian random forest,
in which the underlying trees are constructed according to a Mondrian process.
In this paper we give a central limit theorem
for the estimates made by a Mondrian random forest
in the regression setting.
When combined with a bias characterization and a consistent variance estimator,
this allows one to perform asymptotically valid statistical inference,
such as constructing confidence intervals, on the unknown regression function.
We also provide a debiasing procedure for Mondrian random
forests which allows them to achieve minimax-optimal estimation rates
with $\beta$-Hölder regression functions, for all $\beta$
and in arbitrary dimension, assuming appropriate parameter tuning.
