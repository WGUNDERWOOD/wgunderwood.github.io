---
layout: post
title:  "Julia Sets and the Mandelbrot Set"
date:   2020-06-08
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
[GitHub](https://github.com/WGUNDERWOOD/wgunderwood.github.io/tree/main/_posts/julia_mandelbrot).



## Julia sets

<img style="float: right; padding-left: 30px; padding-top: 0px; width: 250px"
src="/assets/posts/julia_mandelbrot/julia.png">

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
  f_c^{n+1}(z) &= f_c(f_c^n(z)) \\
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

I have
[implemented this](https://github.com/WGUNDERWOOD/julia-julia),
and what better language to use than
[Julia](https://julialang.org/)?
The plots produced indeed make nice desktop wallpapers,
as hoped.

Some care should be taken when randomly selecting
$c$, as many choices will lead to "boring"
Julia sets.
We propose a method for avoiding this
after introducing the
Mandelbrot set.




## The Mandelbrot set

<img style="float: right; padding-left: 30px; padding-top: 0px; width: 250px"
src="/assets/posts/julia_mandelbrot/mandelbrot.png">

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

That is, a point $c$ is in the Mandelbrot
if its associated Julia set contains zero.

### Properties of the Mandelbrot set

A point $c$ is in the Mandelbrot set precisely when
the corresponding Julia set $J_c$ is connected.
While the Mandelbrot set has many other interesting
properties,
we focus instead on its relationship to Julia sets.

### Plotting the Mandelbrot set

<img style="float: right; padding-left: 30px; padding-top: 0px; width: 250px"
src="/assets/posts/julia_mandelbrot/buddhabrot.png">

Again simpling by iterating a complex quadratic,
we can plot the Mandelbrot set,
with its complement coloured by the number of iterations
until escape.
I wrote a
[Python notebook](https://github.com/WGUNDERWOOD/mandelbrot-buddhabrot)
some time ago to demonstrate this.
The notebook also contains a plot known as
the Buddhabrot,
which arises from colouring points by the number of
escaping trajectories which pass through them.

### Using the Mandelbrot set to find interesting Julia sets

As promised,
the Mandelbrot set can be used to find Julia sets which
are visually appealing.
The concept is that the "boring" Julia sets
correspond to $c$ values which are far from
the boundary of the Mandelbrot set
(either inside or outside).
For example, points deep inside the main bulb
of the Mandelbrot set generate Julia sets
which are slightly deformed circles,
while those far outside the Mandelbrot set
generate extremely sparse "dust".
Hence for each randomly chosen $c$-value
candidate,
we iterate $f_c$ a few times
started from zero and check that it
does not converge quickly to zero
or to infinity.
Only when the validity of $c$ is confirmed
do we proceed with generating the Julia set.

## References

- The Wikipedia pages on
  [Julia sets](https://en.wikipedia.org/wiki/Mandelbrot_set),
  the [Mandelbrot set](https://en.wikipedia.org/wiki/Julia_set)
  and the [Buddhabrot](https://en.wikipedia.org/wiki/Buddhabrot)
- Melinda Green's original
  [Buddhabrot technique](http://superliminal.com/fractals/bbrot/bbrot.htm)
- Drakopoulos, Vasileios. (2002). Comparing Rendering Methods for Julia Sets
