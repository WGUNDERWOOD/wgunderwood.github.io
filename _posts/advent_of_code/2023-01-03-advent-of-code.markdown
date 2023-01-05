---
layout: post
title:  "Advent of Code 2022"
date:   2023-01-03
---

In 2022 I tackled Advent of Code for the first time,
using the Julia language. Here are some of my thoughts.

## First impressions

Advent of Code (AoC) consists of twenty-five problems increasing in difficulty
from 1st to 25th December.
I enjoyed solving all the problems,
which were varied enough to avoid repetition,
but also fell into a few distinct categories
giving some familiarity.
The first few problems were very easy,
typically requiring just a few lines of code
and no particular insights -- the obvious solution "just worked."
The later problems presented various challenges,
including

TODO write this intro





## The Julia language

TODO think about the order of these sections

Since this was my first attempt at AoC,
I decided to use a language which I am already comfortable with
but wanted to learn more about.
Julia is a high-level yet high-performance language which is as easy to write
as Python and almost as fast as C TODO cite.
Some of my favourite features,
which I tried to understand more fully during AoC include:

#### Just-in-time compilation

Julia is compiled just-in-time (JIT),
an approach offering a compromise between
ahead-of-time (AOT) compilation
(where the program is first compiled to
machine code and then executed, like C)
and interpretation
(where the program is run line by line, like Python).
This allows the program to be recompiled while it is running,
so that the most performance-critical parts are made as fast as possible.

#### Fast loops

A great example of the benefit of JIT compilation is
Julia's fast loops, which require no vectorization
(unlike Python, where loops are painfully slow
unless vectorized in numpy).
Simply write out the loops you need and the compiler will handle
the execution.
That said, Julia does have vectorization macros which
can allow for neater code.
For example, to add one to the array
`A::Vector{Int}`{:.language-julia .highlight},
we write `A .+ 1`{:.language-julia .highlight},
using the dot operator to broadcast over
the elements of `A`{:.language-julia .highlight}.

#### Type annotation

Julia's type system is another place where it combines the best of
low-level AOT compiled languages and high-level interpreted languages.
Type annotations are *optional* in Julia.
If you don't want to think about types,
you can opt to leave variables and function arguments untyped,
as in Python or R.
However adding type annotations such as
`x::Float64`{:.language-julia .highlight}
or `add_one(x::Float64) = x + 1`{:.language-julia .highlight}
can help the compiler optimize your code better
and prevent you from making mistakes such as passing the wrong
object into a function.

#### First-class arrays

Arrays in Julia are very easy to use,
working seamlessly with the rest of its type system
and requiring no additional packages (I'm looking at you, numpy).
For example, dimension is well-defined
and included in the type declaration:

* `Array{Int, 1}`{:.language-julia .highlight}
is a one-dimensional array of integers,
with the alias `Vector{Int}`{:.language-julia .highlight}.

* `Array{Int, 2}`{:.language-julia .highlight}
is a two-dimensional array of integers,
equivalent to `Matrix{Int}`{:.language-julia .highlight}.

* `Array{Array{Int, 1}, 1}`{:.language-julia .highlight}
is a one-dimensional array of one-dimensional arrays of integers.
It is *not* equivalent to `Array{Int, 2}`{:.language-julia .highlight}.

This is very useful in many circumstances -- if you want
a rectangular array, use `Matrix{Int}`{:.language-julia .highlight}.
If you want a ragged array,
use `Vector{Vector{Int}}`{:.language-julia .highlight}.
Julia has no confusion between two-dimensional
arrays with only one column and one-dimensional arrays:
one has size `(n, 1)`{:.language-julia .highlight}
while the other has size `(n)`{:.language-julia .highlight}.

#### Multiple dispatch

Julia allows the creation of composite types
(also known as objects or structs).


{% highlight julia %}
struct Elf
    height::Int
    weight::Int
end
{% endhighlight %}

However, unlike objected-oriented languages such as Python,
Julia does not define methods for its objects.
Instead, we write a normal function and annotate its arguments
to be of certain types.
For example,
`bmi(elf::Elf) = elf.weight / elf.height^2`{:.language-julia .highlight}
rather than
`elf.bmi() = elf.weight / elf.height^2`{:.language-julia .highlight}
Multiple dispatch means that the type of *every* argument must agree
in order for the function to be called.







Learned about data structures
Hardest part was usually finding the right data structure
Network algorithms were the hardest, with heuristics
Divisibility tricks
Guessing and preparing for part 2
Representing lists/ranges without allocating (day 15)
In-place vs returning functions
Copying, deepcopying and pointers
Dynamic programming
Dijkstra's algorithm -- Google trends spike Dec 12
Cellular automata
Dynamic allocation with growing arrays (day 17, 23)

## Daily comments

Day 23 was worried part 2 would take a huge amount of time but no
Day 20 just tricky indexing
