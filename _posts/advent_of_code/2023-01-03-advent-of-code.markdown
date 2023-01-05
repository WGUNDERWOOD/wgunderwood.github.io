---
layout: post
title:  "Advent of Code 2022"
date:   2023-01-03
---

In 2022 I tackled Advent of Code for the first time,
using the Julia language. Here are some of my thoughts.

{% include mathjax.html %}

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

TODO link to my gh
TODO link to AoC each day

<h3> Day 1: Calorie Counting
<span style="float: right; color: #777777; font-size: 24px;">
(0.272s)
</span>
</h3>

Iterating through the input lines allows us to calculate the
total calories for each elf,
storing the totals in a
`Vector{Int}`{:.language-julia .highlight}.
Finding the most calorific elf (part 1)
and the most calorific three elves (part 2)
is easy with the
`maximum`{:.language-julia .highlight}
and
`sort`{:.language-julia .highlight}
functions.



<h3> Day 2: Rock Paper Scissors
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

For each part I kept a lookup table of type
`Dict{String, Int}`{:.language-julia .highlight}
for the score based on the input.
For example for part 1 we have
`"A X" => 1 + 3`{:.language-julia .highlight}
and for part 2 we have
`"A X" => 3 + 0`{:.language-julia .highlight}.
Summing the scores over an iterator of the input file
gives the answer without allocating much memory.


<h3> Day 3: Rucksack Reorganization
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

This problem is about finding common characters in several strings.
While I could have just done this for two or three strings as required
in the question, I wrote a recursive function to handle
an arbitrary length
`Vector{String}`{:.language-julia .highlight}
based on intersecting the first pair repeatedly until only one
string remains.


<h3> Day 4: Camp Cleanup
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

For this question we are given a list of pairs of integer ranges
and asked for how many pairs do the two ranges
contain each other (part 1) or overlap (part 2).
Despite the numbers in this question being quite small,
it still seemed sensible to represent the ranges by their endpoints
using a
`Tuple{Int, Int}`{:.language-julia .highlight}
rather than collecting all the values in between into a
`Vector{Int}`{:.language-julia .highlight}.
Given the endpoints it is easy to write
functions to check if one contains the other or if they overlap.


<h3> Day 5: Supply Stacks
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

Did someone say stacks?
Moving one crate at a time (part 1) is easily achieved by using
`push!`{:.language-julia .highlight}
and
`pop!`{:.language-julia .highlight}
multiple times on the relevant
`Vector{Char}`{:.language-julia .highlight}
and this extends to moving multiple crates (part 2)
by pushing them first to a
temporary "holding array" and then to their final destinations.
The hardest part was reading the oddly-formatted input.


<h3> Day 6: Tuning Trouble
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

This was the first puzzle where I predicted what the second part
might be and planned accordingly.
Both parts involve finding the first position in a string where
the preceding $n$ characters are all distinct,
with $n=4$ in the first part and $n=14$ in the second.
As such I made sure the complexity of
my solution did not depend much on the size of $n$.
Using a simple loop through the string checking at each point if the
preceding $n$ characters are distinct was enough to solve this.


<h3> Day 7: No Space Left On Device
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

This was the first day I found difficult,
and also the first for which I used custom composite types.
The goal is to imitate a simple file system which can run
`cd` and `ls`.
After some unsuccessful attempts at recursive types
(directories in directories etc.),
I settled on the following simple data structures,
using full paths in the
`name`{:.language-julia .highlight}
fields.

{% highlight julia %}
mutable struct Directory
    name::String
    size::Real
    parent::Union{String, Nothing}
end

struct File
    name::String
    size::Int
    parent::String
end

mutable struct Filesystem
    structure::Dict{String, Union{File, Directory}}
    cwd::String
end
{% endhighlight %}

Firstly I made a pass through the problem input to get the structure
of the filesystem and the sizes of the files,
setting each directory size to
`NaN::Float64`{:.language-julia .highlight},
Julia's "not a number" value.
The main challenge was to then recursively
propagate the file sizes up to the
directories which contain them.
I did this by looping over every directory
in the file system
and checking that

* Its current `size` is
`NaN::Float64`{:.language-julia .highlight}

* All of its children have a `size` which is not
`NaN::Float64`{:.language-julia .highlight}

If so then the size of this directory is the sum of the sizes of
its children.
I repeated this process $d$ times where $d$ is the depth
of the filesystem to ensure propagation has terminated.
I'm sure there are better ways to do this, but it worked for me.

TODO next day




'a':'z' is neat
Dijkstra's algorithm -- Google trends spike Dec 12
Guessing and preparing for part 2 -- did this in the 14 char day
Representing lists/ranges without allocating (day 15)
Dynamic allocation with growing arrays (day 17, 23)
Day 23 was worried part 2 would take a huge amount of time but no
Day 20 just tricky indexing

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
