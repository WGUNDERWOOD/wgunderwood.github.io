---
layout: post
title:  "Goodstein Sequences"
date:   2020-01-04 23:44:28 +0000
---

Goodstein sequences grow fast and appear to diverge to infinity.
But a neat application of ordinal arithmetic gives a surprising result.

{% include mathjax.html %}

## Cantor normal form

Before we define the Goodstein sequences,
we need to know how to write a number $n$ in Cantor normal form with base $b$.

To do this, first expand $n$ in base $b$.
Then if there are exponents larger than $b$,
expand those in base $b$ too.
Repeat this until every number seen is at most $b$.

For example, we can write $n=2020$ in Cantor normal form with base $b=4$:

$$
\begin{align*}
  2020
  &= 4^5 + 3 \cdot 4^4 + 3 \cdot 4^3 + 2 \cdot 4^2 + 4 \\
  &= 4^{4+1} + 3 \cdot 4^4 + 3 \cdot 4^3 + 2 \cdot 4^2 + 4
\end{align*}
$$

## Goodstein sequences

Now we can define a Goodstein sequence, started from $N$:

- First write $N$ in Cantor normal form, base $2$. <br>
  Replace every $2$ with a $3$, and subtract $1$.

- Then write $N$ in Cantor normal form, base $3$. <br>
  Replace every $3$ with a $4$, and subtract $1$. <br>
$\vdots$
- Then write $N$ in Cantor normal form, base $k$. <br>
  Replace every $k$ with a $k+1$, and subtract $1$. <br>
$\vdots$

### Example

Take $N=5$.

- $5 = 2^2 + 1$ <br>
  $\to 3^3 + 1 - 1$ <br>
  $= 27$

- $27 = 3^3$ <br>
  $\to 4^4 - 1$ <br>
  $= 255$

- $255 = 3 \cdot 4^3 + 3 \cdot 4^2 + 3 \cdot 4 + 3$ <br>
  $\to 3 \cdot 5^3 + 3 \cdot 5^2 + 3 \cdot 5 + 3 - 1$ <br>
  $= 467$

- $467 = 3 \cdot 5^3 + 3 \cdot 5^2 + 3 \cdot 5 + 2$ <br>
  $\to 3 \cdot 6^3 + 3 \cdot 6^2 + 3 \cdot 6 + 1$ <br>
  $= 775$ <br>
$\vdots$<br>

So we see that this sequence grows at each step.
In fact the first eight elements
of the Goodstein sequence started at 5 are:

$$G_5 = (
  5,
  27,
  255,
  467,
  775,
  1197,
  1751,
  2454
)$$

The growth is even faster when we start with a larger number,
such as 10:

$$G_{10} = (
  10,
  83,
  1025,
  15625,
  279935,
  4215754,
  84073323,
  1937434592
)$$

## Goodstein's Theorem

It is tempting to conjecture that all the Goodstein sequences started from
some $N \geq 5$ diverge to infinity. However, this is not true, due to
a remarkable theorem of Goodstein TODO link this

#### Theorem (Goodstein, 1944)

Every Goodstein sequence converges to zero!

### Ordinal numbers

Before we attempt a proof of Goodstein's theorem, it is helpful to introduce
ordinal numbers.
