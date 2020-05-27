---
layout: post
title:  "Julia Sets and the Mandelbrot Set"
date:   2020-05-21
---

Julia sets and the Mandelbrot set arise naturally in complex dynamics.
We explore some of their properties and methods for plotting them.

{% include mathjax.html %}

I recently decided it would be nice to be able to procedurally generate
unique wallpapers to use on my laptop,
and fractals seemed an obvious choice.
More specifically,
I wanted to generate and plot quadratic Julia sets
with randomised parameters.
This also seemed a good opportunity to try a new language,
so of course I wrote it in
[Julia](https://julialang.org/).
The source code is available on
[GitHub](https://github.com/WGUNDERWOOD/julia-julia).



## Julia sets

In this post we consider only the Julia sets of a
simple class of quadratic functions,
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
  f_c^1(z) &= f_c(z) \\
  f_c^{n+1}(z) &= f(f_c^n(z)) \\
\end{align*}
$$

Define the positive constant
$R_c = \frac{1}{2} \big(1 + \sqrt{1 + 4 |c|}\, \big)$.
Then the Julia set of $f_c$ is

$$
  J_c = \{ z \in \mathbb{C} \
          : \forall n \in \mathbb{N}, \
          |f_c^n(z)| \leq R_c
        \}
$$

That is $J_c$ is the set of complex numbers whose
$f_c$-orbits remain bounded by $R_c$.


### Properties of Julia sets

Clearly the Julia set $J_c$ is $f_c$-invariant,
and it is also $f_c^{-1}$-invariant.
In fact it is the smallest closed set which contains
at least three points and has this property.
If a Julia set is disconnected,
then in fact it has infinitely many connected components,
and is sometimes referred to as
"Cantor dust".

### Plotting Julia sets

The definition above gives a natural algorithm for plotting Julia sets:
Fix $c$ and for each point in the plotting region,
iterate it under $f_c$ until either it escapes
the ball of radius $R_c$,
or a maximum iteration count is reached.
The complement of $J_c$ can then be coloured
according to how many iterations it took
for each point to escape.

I have implemented this on
[GitHub](https://github.com/WGUNDERWOOD/julia-julia),
and what better language to use than
[Julia](https://julialang.org/)?
The plots produced indeed make nice desktop wallpapers,
as hoped.

Some care should be taken when randomly selecting
$c$, as many choices will lead to "boring"
Julia sets which either look like
a slightly distorted circle,
or are composed of extremely sparse
isolated points.
TODO explain how to avoid this




## The Mandelbrot set

The Mandelbrot set can be thought of an
"index" of Julia sets in that instead of
varying the initial point $z$,
we vary the parameter $c$.

### Definition of the Mandelbrot set

With the same notation for $f_c^n$ as above,
the Mandelbrot set is

$$
  M = \{ c \in \mathbb{C} \
          : \forall n \in \mathbb{N}, \
          |f_c^n(0)| \leq 2
        \}
$$

### Properties of the Mandelbrot set

A point $c$ is in the Mandelbrot set precisely when
the corresponding Julia set $J_c$ is connected.
TODO properties

### Plotting the Mandelbrot set
TODO plotting

## References
https://en.wikipedia.org/wiki/Mandelbrot_set
https://en.wikipedia.org/wiki/Julia_set
