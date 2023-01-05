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

Since this was my first attempt at AoC,
I decided to use a language which I am already comfortable with
but wanted to learn more about.
Julia is a high-level yet high-performance language which is as easy to write
as Python and almost as fast as C TODO cite.
Some of my favourite features
which I tried to understand more fully during AoC include
the following.

### First-class arrays

Arrays in Julia are very easy to use,
working seamlessly with the rest of its type system
and requiring no additional packages (I'm looking at you, numpy).
For example, dimension is well-defined
and included in the type declaration:

* `Array{Int, 1}`{:.language-julia .highlight}
or `Vector{Int}`{:.language-julia .highlight}
is a one-dimensional array of integers.

* `Array{Int, 2}`{:.language-julia .highlight}
or `Matrix{Int}`{:.language-julia .highlight}
is a two-dimensional array of integers.

* `Array{Array{Int, 1}, 1}`{:.language-julia .highlight}
or `Vector{Vector{Int}}`{:.language-julia .highlight}
is a one-dimensional array of one-dimensional arrays of integers.
It is not equivalent to `Matrix{Int}`{:.language-julia .highlight}.

This is useful in many circumstances -- for
a rectangular array, use `Matrix{Int}`{:.language-julia .highlight}.
For a ragged array,
use `Vector{Vector{Int}}`{:.language-julia .highlight}.
Julia has no confusion between two-dimensional
arrays with only one column and one-dimensional arrays:
the former has size `(n, 1)`{:.language-julia .highlight}
while the latter has size `(n)`{:.language-julia .highlight}.
Unlike dimension, the size of an array
is not included in the type, allowing
pushing and popping.


### Just-in-time compilation

Julia is compiled just-in-time (JIT),
an approach offering a compromise between
ahead-of-time (AOT) compilation
(where the program is first compiled to
machine code and then executed, like C)
and interpretation
(where the program is run line by line, like Python).
This allows the program to be recompiled while it is running,
so that the most performance-critical parts are made as fast as possible.

### Fast loops

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

### Type annotation

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

### Multiple dispatch

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
`elf.bmi() = elf.weight / elf.height^2`{:.language-julia .highlight}.
Multiple dispatch means that the type of *every* argument must agree
in order for the function to be called.


There is plenty more to like about Julia,
including its parametric type system,
its great standard libraries for
multi-threading, linear algebra and statistics,
its package manager and its testing functionality,
but I won't go into any more detail here.


## General comments

I learned more than I expected to while completing Advent of Code.
While the solutions are perhaps not very surprising,
the actual implementation details are worth thinking about
more carefully.
In particular, I definitely improved my understanding of the following.

### Data structures

Since I have never studied computer science formally,
I would often be confused by the obsession with
"data structures" -- what's wrong with arrays?
AoC definitely helped me appreciate this more -- in fact
I think the hardest part of most of the problems was finding the right
data structures to use.
I became more familiar with hash maps
(dictionaries) and tuples, and their respective strengths and weaknesses.
Type unions were also useful, particularly for handling
missing or non-existent values through the
`Nothing`{:.language-julia .highlight}
and
`Union{T, Nothing}`{:.language-julia .highlight} types.

### Network algorithms

While I had seen dynamic programming methods such as Dijkstra's algorithm
TODO cite
for shortest paths before, I had no experience in implementing them.
This turned out to be relatively straightforward,
keeping track of temporary variables in a new array.

More challenging for me were the network search algorithms,
including breadth-first search (BFS)
and depth-first search (DFS).
I didn't really understand which one to use in a given scenario
and ended up doing quite a bit of trial and error
with various heuristics to keep the run time reasonable.
Julia's
`push!`{:.language-julia .highlight}
and
`pushfirst!`{:.language-julia .highlight}
functions allow easy switching between
stacks and queues TODO cite,
along with the analogous functions
`pop!`{:.language-julia .highlight}
and
`popfirst!`{:.language-julia .highlight}.


### Avoiding unnecessary allocation and copying

Many problems in AoC (particuarly part 2 of the problems)
contain inputs so large that the obvious solutions
are impossible due to memory allocation.
One common fix is to represent the data without allocating much memory,
for example by representing ranges of numbers by their start and end points,
either manually or by using an
`AbstractRange`{:.language-julia .highlight}
object, rather than collecting all the elements into an array.
Another common solution was to use various divisibility tricks,
storing only the remainders of numbers modulo some divisor,
rather than keeping the whole number.
This can help avoid storing huge integers.

A similar challenge was to avoid copying large arrays.
Julia uses exclamation marks to distinguish "in-place" functions
such as
`sort!`{:.language-julia .highlight}
which modify their arguments, from
"returning" functions such as
`sort`{:.language-julia .highlight}
which simply return a new value,
in this case the sorted array.
This often allows one to reuse the same memory,
modifying the entries of an array without copying the whole object.












## Day-by-day

Some brief comments on each day's problems are given below.

### Day 1

TODO timings

Day 23 was worried part 2 would take a huge amount of time but no
Day 20 just tricky indexing
Guessing and preparing for part 2 -- did this in the 14 char day
Dijkstra's algorithm -- Google trends spike Dec 12
Dynamic allocation with growing arrays (day 17, 23)

Representing lists/ranges without allocating (day 15)

## Concluding remarks


Julia was overall a good language to use,
offering a compromise between ease of use
(for those familiar with Python, R and MATLAB, at least),
and performance.
One downside is that Julia is not a scripting language and has a poor
startup time. This means that most of the time is spent
compiling rather than running the program, and it is impossible
to separate these two steps.
Next time I might try to learn Rust TODO cite.
