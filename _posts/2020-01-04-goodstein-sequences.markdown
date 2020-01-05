---
layout: post
title:  "Goodstein Sequences"
date:   2020-01-04 23:44:28 +0000
---

Goodstein sequences grow fast and appear to diverge to infinity.
But an unexpected application of ordinal arithmetic gives a surprising result.

{% include mathjax.html %}

## Cantor normal form

Before we define the Goodstein sequences,
we need to know how to write a number $n$ in *Cantor normal form with base* $b$.
To do this, expand $n$ in base $b$.
Then if there are exponents larger than $b$,
expand those in base $b$ too.

For example, we can expand $n=2020$ in base $b=4$.



$$
\begin{align*}

  2020
  &= 4^5 + 3*4^4 + 3*4^3 + 2*4^2 + 4 \\
  &= 4^{4+1} + 3*4^4 + 3*4^3 + 2*4^2 + 4
\end{align*}
$$
