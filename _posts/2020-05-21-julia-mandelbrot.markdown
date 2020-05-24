---
layout: post
title:  "Julia Sets and the Mandelbrot Set"
date:   2020-05-21
---

Julia sets and the Mandelbrot set arise naturally in complex dynamics.
We explore some of their properties and methods for plotting them.
TODO mention julialang

{% include mathjax.html %}

TODO long intro

## Julia sets

In this post we consider only the Julia sets of simple quadratic functions,
though they can be defined for any holomorphic function.

### Definition of quadratic Julia sets

Consider the complex quadratic $f_c : \mathbb{C} \to \mathbb{C}$ given by

$$
  f_c(z) = z^2 + c
$$

Fixing a point $z \in \mathbb{C}$ and a number
$n \in \mathbb{N}$ we can define the
$n$th iterate of $f_c$ on $z$ inductively as

$$
\begin{align*}
  f_c^0(z) &= 1 \\
  f_c^{n+1}(z) &= f(f_c^n(z)) \\
\end{align*}
$$

Define the positive constant
$R_c = \frac{1}{2} \big(1 + \sqrt{1 + 4 |c|}\, \big)$.
Then the Julia set of $f_c$ is

$$
  J_c = \{ z \in \mathbb{C} \
          : \forall n \in \mathbb{N}, \
          |z_n| \leq R_c
        \}
$$

That is $J_c$ is the set of complex numbers whose
$f_c$-orbits remain bounded by $R_c$.


### Properties of Julia sets

Clearly the Julia set $J_c$ is $f_c$-invariant,
and also $f_c^{-1}$-invariant.
In fact it is the smallest closed set which contains
at least three points and has this property.
TODO connectedness?

### Plotting Julia sets

The definition above gives a natural algorithm for plotting Julia sets:
Fix $c$ and for each point in the plotting region,
iterate it under $f_c$ until either it escapes
the ball of radius $R_c$,
or a maximum iteration count is reached.
The complement of $J_c$ can further be coloured
according to how many iterations it took
for each point to escape.

I have implemented this on
GitHub,
TODO link
and what better language to use than
Julia?
TODO link
The plots produced make excellent desktop wallpapers, too.


## The Mandelbrot set

The Mandelbrot set can be thought of an
"index" of Julia sets
TODO definitions

TODO properties

### Plotting the Mandelbrot set

## References
