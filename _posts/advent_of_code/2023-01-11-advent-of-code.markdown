---
layout: post
title:  "Advent of Code 2022"
date:   2023-01-11
---

In 2022 I tackled
[Advent of Code](https://adventofcode.com/)
for the first time, using the Julia language.
Here are some of my thoughts;
my code is on
[GitHub](https://github.com/WGUNDERWOOD/advent-of-code-2022).

{% include mathjax.html %}

## First impressions

[Advent of Code](https://adventofcode.com/)
(AoC) consists of twenty-five problems increasing in difficulty
from the 1st to the 25th of December.
I enjoyed solving all the problems,
which were varied enough to avoid repetition,
but which also fell into a few distinct categories
giving some familiarity.
The first few problems were very easy,
typically requiring just a few lines of code
and no particular insights -- the obvious solution "just worked."
The later problems presented various challenges,
including knowledge of network search algorithms,
computational complexity
and memory considerations,
and plenty of general-purpose problem solving.



<div class="frame">
<a href="https://julialang.org/">
<img
style="width: 170px; margin-top: 25px; margin-left: 15px"
src="/assets/posts/advent_of_code/julia.svg">
</a>
</div>

## The Julia language

Since this was my first attempt at AoC,
I decided to use a language which I am already comfortable with
but wanted to learn more about.
[Julia](https://julialang.org/)
is a high-level yet high-performance language which is
as easy to write as Python and
[almost as fast as C](https://julialang.org/benchmarks/).
Some of my favourite features
which I tried to understand more fully during AoC include
the following.

### First-class arrays

[Arrays](https://docs.julialang.org/en/v1/manual/arrays/)
in Julia are very easy to use,
working seamlessly with the rest of its type system
and requiring no additional packages
(I'm looking at you, [numpy](https://numpy.org/)).
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

Julia is compiled
[just-in-time](https://en.wikipedia.org/wiki/
Just-in-time_compilation)
(JIT),
an approach offering a compromise between
[ahead-of-time](https://en.wikipedia.org/wiki/Compiler)
compilation
(where the program is first compiled to
machine code and then executed, like C)
and
[interpretation](https://en.wikipedia.org/wiki/
Interpreter_(computing))
(where the program is run line-by-line, like Python).
This allows the program to be recompiled while it is running,
so that the most performance-critical parts are made as fast as possible.

### Fast loops

A great example of the benefit of JIT compilation is Julia's
[fast loop](https://julialang.org/benchmarks/)
implementation,
which requires no explicit vectorisation
(unlike Python, where loops are painfully slow
unless vectorised with list comprehensions or numpy).
Simply write out the loops you need and the JIT compiler will handle
the execution.
That said, Julia does have
[vectorisation macros](https://docs.julialang.org/en/v1/
manual/mathematical-operations/#man-dot-operators)
which can allow for neater code.
For example, to add one to the array
`A::Vector{Int}`{:.language-julia .highlight},
we write `A .+ 1`{:.language-julia .highlight},
using the dot operator to broadcast over
the elements of `A`{:.language-julia .highlight}.

### Type annotation

Julia's
[type system](https://docs.julialang.org/en/v1/manual/types/)
is another place where it combines the best of
low-level compiled languages and high-level interpreted languages.
Type annotations are *optional* in Julia.
If you don't want to think about types,
you can opt to leave variables and function arguments untyped,
as in Python or R.
However adding type annotations such as
`x::Float64`{:.language-julia .highlight}
or `add_one(x::Float64) = x + 1`{:.language-julia .highlight}
can help the compiler optimise your code better
and prevent you from making mistakes such as passing the wrong
object into a function.

### Multiple dispatch

Julia allows the creation of
[composite types](https://docs.julialang.org/en/v1/
manual/types/#Composite-Types)
(also known as structs or objects).

{% highlight julia %}
struct Elf
    height::Int
    weight::Int
end
{% endhighlight %}

However, unlike objected-oriented languages such as Python,
Julia does not define methods for its objects.
Instead, we write a regular
[function](https://docs.julialang.org/en/v1/manual/functions/)
and annotate its arguments
to be of certain types.
For example,
`bmi(elf::Elf) = elf.weight / elf.height^2`{:.language-julia .highlight}
rather than
`elf.bmi() = elf.weight / elf.height^2`{:.language-julia .highlight}.
Multiple dispatch means that the type of *every* argument must agree
in order for the function to be called.


There is plenty more to like about Julia,
including its
[parametric type system](https://docs.julialang.org/en/v1/
manual/types/#Parametric-Types),
its great standard libraries for
[multi-threading](https://docs.julialang.org/en/v1/base/multi-threading/),
[linear algebra](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/)
and [statistics](https://docs.julialang.org/en/v1/stdlib/Statistics/),
its [package manager](https://docs.julialang.org/en/v1/stdlib/Pkg/)
and its
[testing](https://docs.julialang.org/en/v1/stdlib/Test/)
functionality,
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
I became more familiar with
[dictionaries](https://docs.julialang.org/en/v1/base/collections/#Dictionaries)
(hash maps) and
[tuples](https://docs.julialang.org/en/v1/manual/functions/#Tuples),
and their respective strengths and weaknesses.
[Type unions](https://docs.julialang.org/en/v1/manual/types/#Type-Unions)
were also useful, particularly for handling
missing or non-existent values through the
`Nothing`{:.language-julia .highlight}
and
`Union{T, Nothing}`{:.language-julia .highlight} types.

### Network algorithms

While I had seen dynamic programming methods such as
[Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
for shortest paths before, I had no experience in implementing them.
This turned out to be relatively straightforward,
keeping track of temporary variables in a new array.

More challenging for me were the network search algorithms,
including
[breadth-first search](https://en.wikipedia.org/wiki/Breadth-first_search)
(BFS) and
[depth-first search](https://en.wikipedia.org/wiki/Depth-first_search)
(DFS).
I didn't really understand which one to use in a given scenario
and ended up doing quite a bit of trial and error
with various heuristics to keep the run time reasonable.
Julia's
`push!`{:.language-julia .highlight}
and `pushfirst!`{:.language-julia .highlight}
functions allow easy switching between
[stack](https://computersciencewiki.org/index.php/Stack)
and [queue](https://computersciencewiki.org/index.php/Queue)
behaviour,
along with the analogous functions
`pop!`{:.language-julia .highlight}
and
`popfirst!`{:.language-julia .highlight}.


### Avoiding unnecessary allocation and copying

Many problems in AoC (particularly part 2 of the problems)
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
This helped avoid storing huge integers.

A similar challenge was to avoid copying large arrays.
Julia uses exclamation marks to distinguish "in-place" functions
such as
`sort!`{:.language-julia .highlight},
which modify their arguments, from
"returning" functions such as
`sort`{:.language-julia .highlight}
which simply return a new value,
in this case the sorted array.
This often allows one to reuse the same memory,
modifying the entries of an array without copying the whole object.


## Day-by-day

Some brief comments on each day's problems are given below,
along with the approximate execution time after precompilation.
My solutions are available on
[GitHub](https://github.com/WGUNDERWOOD/advent-of-code-2022).

<h3>
<a href="https://adventofcode.com/2022/day/1" style="color:#F1FA9C">
Day 1: Calorie Counting
</a>
<span style="float: right; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day01.jl" style="color:#777777">
0.034 s
</a>
</span>
</h3>

Iterating through the input lines allowed us to calculate the
total calories for each elf,
storing the totals in a
`Vector{Int}`{:.language-julia .highlight}.
Finding the most calorific elf (part 1)
and the most calorific three elves (part 2)
was easy with the
`maximum`{:.language-julia .highlight}
and
`sort`{:.language-julia .highlight}
functions.



<h3>
<a href="https://adventofcode.com/2022/day/2" style="color:#F1FA9C">
Day 2: Rock Paper Scissors
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day02.jl" style="color:#777777">
0.080 s
</a>
</span>
</h3>

For each part I kept a lookup table of type
`Dict{String, Int}`{:.language-julia .highlight}
for the score based on the input.
For example for part 1 we have
`"A X" => 1 + 3`{:.language-julia .highlight}
while for part 2 we have
`"A X" => 3 + 0`{:.language-julia .highlight}.
Summing the scores over an iterator of the input file
gave the answer without allocating much memory.


<h3>
<a href="https://adventofcode.com/2022/day/3" style="color:#F1FA9C">
Day 3: Rucksack Reorganization
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day03.jl" style="color:#777777">
0.434 s
</a>
</span>
</h3>

This problem was about finding common characters in several strings.
While I could have just done this for two or three strings as required
in the question, I wrote a recursive function to handle
an arbitrary length
`Vector{String}`{:.language-julia .highlight}
based on intersecting the first pair repeatedly until only one
string remains.


<h3>
<a href="https://adventofcode.com/2022/day/4" style="color:#F1FA9C">
Day 4: Camp Cleanup
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day04.jl" style="color:#777777">
0.173 s
</a>
</span>
</h3>

For this question we were given a list of pairs of integer ranges
and asked for how many pairs do the two ranges
contain each other (part 1) or overlap (part 2).
Despite the numbers in this question being quite small,
it still seemed sensible to represent the ranges by their endpoints
using a
`Tuple{Int, Int}`{:.language-julia .highlight}
rather than collecting all the values in between into a
`Vector{Int}`{:.language-julia .highlight}.
Given the endpoints it was easy to write
functions to check if one contains the other or if they overlap.


<h3>
<a href="https://adventofcode.com/2022/day/5" style="color:#F1FA9C">
Day 5: Supply Stacks
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day05.jl" style="color:#777777">
0.179 s
</a>
</span>
</h3>

Did someone say stacks?
Moving one crate at a time (part 1) was easily achieved by using
`push!`{:.language-julia .highlight}
and
`pop!`{:.language-julia .highlight}
multiple times on the relevant
`Vector{Char}`{:.language-julia .highlight}
and this extended to moving multiple crates (part 2)
by pushing them first to a
temporary "holding array" and then to their final destinations.
The hardest part was reading the oddly-formatted input.


<h3>
<a href="https://adventofcode.com/2022/day/6" style="color:#F1FA9C">
Day 6: Tuning Trouble
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day06.jl" style="color:#777777">
0.020 s
</a>
</span>
</h3>

This was the first puzzle where I predicted what the second part
might be and planned accordingly.
Both parts involved finding the first position in a string where
the preceding $n$ characters were all distinct,
with $n=4$ in the first part and $n=14$ in the second.
As such I made sure the complexity of
my solution did not depend much on the size of $n$.
Using a simple loop through the string checking at each point if the
preceding $n$ characters are distinct was enough to solve this.


<h3>
<a href="https://adventofcode.com/2022/day/7" style="color:#F1FA9C">
Day 7: No Space Left On Device
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day07.jl" style="color:#777777">
0.548 s
</a>
</span>
</h3>

This was the first day I found difficult,
and also the first for which I used custom composite types.
The goal was to imitate a simple file system which could run
`cd` and `ls`.
After some unsuccessful attempts at recursive types
(directories in directories etc.),
I settled on the following simple data structure,
with structs
`File`{:.language-julia .highlight}
and `Directory`{:.language-julia .highlight}
each containing
`name`, `size` and `parent` fields:

{% highlight julia %}
mutable struct Filesystem
    structure::Dict{String, Union{File, Directory}}
    cwd::String
end
{% endhighlight %}

Firstly I made a pass through the problem input to get the structure
of the file system and the sizes of the files,
setting each directory size to
`NaN`{:.language-julia .highlight},
Julia's "not a number" value.
The main challenge was to then recursively
propagate the file sizes up to the
directories which contain them.
I did this by looping over every directory
in the file system
and checking that

* Its current `size` was
`NaN`{:.language-julia .highlight}

* All of its children had a `size` which was not
`NaN`{:.language-julia .highlight}

If so then the size of this directory was the sum of the sizes of
its children.
I repeated this process $d$ times where $d$ is the depth
of the file system to ensure propagation had terminated.
I'm sure there are better ways to do this, but it worked for me.


<h3>
<a href="https://adventofcode.com/2022/day/8" style="color:#F1FA9C">
Day 8: Treetop Tree House
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day08.jl" style="color:#777777">
0.266 s
</a>
</span>
</h3>

For this problem I wrote a running maximum function to keep track
of the largest tree in a particular direction,
and then used some simple logic to establish whether
there was a line of sight from a tree to the edge of the grid.
I handled the four different directions by permuting the input first
using Julia's
`reverse`{:.language-julia .highlight}
and
`permutedims`{:.language-julia .highlight}
functions.

Getting the scenic score for each tree was easily implemented
by moving in each direction until finding a higher tree.

<h3>
<a href="https://adventofcode.com/2022/day/9" style="color:#F1FA9C">
Day 9: Rope Bridge
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day09.jl" style="color:#777777">
0.186 s
</a>
</span>
</h3>

For this question I needed only two functions,
one to move the head of the rope according to the instructions
and another to adjust the tail to keep up with the head.
To do this one needed only to check
that the tail segment is two squares away (in $L^\infty$ norm)
from the head and then adjust it with
`tail += sign(head - tail)`{:.language-julia .highlight}.

The extension to longer ropes was easy,
making sure to adjust the rope from head to tail
in order to propagate the motion correctly.
Finally the
`unique`{:.language-julia .highlight}
function made counting the visited squares trivial.


<h3>
<a href="https://adventofcode.com/2022/day/10" style="color:#F1FA9C">
Day 10: Cathode-Ray Tube
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day10.jl" style="color:#777777">
0.157 s
</a>
</span>
</h3>

The following two simple functions carried out the bulk of
the work for this question,
with part 2 requiring some modular arithmetic
to get the location of the cursor on the CRT.

{% highlight julia %}
function noop!(register::Vector{Int})
    push!(register, register[end])
    return nothing
end

function addx!(v::Int, register::Vector{Int})
    noop!(register)
    push!(register, register[end] + v)
    return nothing
end
{% endhighlight %}


<h3>
<a href="https://adventofcode.com/2022/day/11" style="color:#F1FA9C">
Day 11: Monkey in the Middle
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day11.jl" style="color:#777777">
0.923 s
</a>
</span>
</h3>

I found this problem quite difficult,
and eventually settled on the following composite type
for each monkey.
In light of part 2, which required modular arithmetic
to prevent numbers growing too large,
each item was stored as a dictionary of
divisor -> remainder pairs.
The `operation`{:.language-julia .highlight}
field contained each monkey's operation as an anonymous function
while `test`{:.language-julia .highlight}
stored the divisor used for its divisibility test.
The potential destination monkeys for the items were given in
`dest`{:.language-julia .highlight},
and I kept track of the number of times the monkey inspected an item in
`inspections`{:.language-julia .highlight}.
Once the input had been parsed, performing the rounds of
throwing was quite straightforward.


{% highlight julia %}
mutable struct Monkey
    id::Int
    items::Vector{Dict{Int, Int}}
    operation::Function
    test::Int
    dest::Dict{Bool, Int}
    inspections::Int
end
{% endhighlight %}


<h3>
<a href="https://adventofcode.com/2022/day/12" style="color:#F1FA9C">
Day 12: Hill Climbing Algorithm
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day12.jl" style="color:#777777">
1.151 s
</a>
</span>
</h3>

This was a classic shortest path problem,
with the network edges determined by the heights of neighbouring squares.
For reading the data, Julia's
`'a':'z'`{:.language-julia .highlight}
syntax was a neat way to get the alphabet.
I solved the main problem using
[Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm),
keeping track of visited squares and their distances in
auxiliary arrays.
By running the algorithm to completion,
not stopping after reaching the target square but
rather finding the shortest path to all reachable squares,
part 2 followed immediately without having to run
the algorithm again.

{% highlight julia %}
struct Hill
    heights::Matrix{Int}
    distances::Matrix{Union{Int, Float64}}
    visited::Matrix{Bool}
    S::Tuple{Int, Int}
    E::Tuple{Int, Int}
end
{% endhighlight %}

Note that each distance was of type
`Union{Int, Float64}`{:.language-julia .highlight}
to allow for the value
`Inf::Float64`{:.language-julia .highlight}.


<h3>
<a href="https://adventofcode.com/2022/day/13" style="color:#F1FA9C">
Day 13: Distress Signal
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day13.jl" style="color:#777777">
0.271 s
</a>
</span>
</h3>

This problem involved parsing some possibly deeply-nested
vectors of vectors of... of integers and comparing them
to each other with some specific rules.
My data structure probably wasn't the best for this day:
I don't think Julia supports arbitrarily nested arrays as types,
so I represented them with
a `Vector{String}`{:.language-julia .highlight},
that is, I only treated the outer-most array as a vector
and just kept its elements as strings such as
`"[[2],5]"`{:.language-julia .highlight}.
Comparing using the rules was then fairly straightforward,
recursing and unwrapping the strings into arrays until
the comparison was determined.
The unwrapping was done by counting opening and closing
brackets to understand the depth of each element.

Part 2 was easy once I could compare the objects,
as I could pass the entire list into Julia's flexible
`sort`{:.language-julia .highlight} function
with a custom comparison function,
using [quicksort](https://en.wikipedia.org/wiki/Quicksort)
without having to implement it myself.


<h3>
<a href="https://adventofcode.com/2022/day/14" style="color:#F1FA9C">
Day 14: Regolith Reservoir
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day14.jl" style="color:#777777">
0.694 s
</a>
</span>
</h3>

This problem was fun to solve as it was easy to visualise and check everything
was working properly.
The first challenge was to parse the layout of the cave from the input,
which amounted to modifying entries in a matrix along a line
given the start and end points of that line.
I then represented the cave using

{% highlight julia %}
mutable struct Cave
    layout::Matrix{Char}
    current::Tuple{Int, Int}
    start::Tuple{Int, Int}
    terminated::Bool
end
{% endhighlight %}

where `layout`{:.language-julia .highlight}
showed the cave structure as in the problem statement,
`current`{:.language-julia .highlight}
gave the current location of the falling unit of sand,
`start`{:.language-julia .highlight}
was the starting point of the sand and
`terminated`{:.language-julia .highlight}
determined whether to stop the simulation.
Implementing the falling sand logic was not too hard,
and for part 2 I simply added an extra path of solid rock
to represent the floor,
making it at least as wide as twice the height of the
starting point.


<h3>
<a href="https://adventofcode.com/2022/day/15" style="color:#F1FA9C">
Day 15: Beacon Exclusion Zone
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day15.jl" style="color:#777777">
0.264 s
</a>
</span>
</h3>

This day was quite tricky.
The obvious thing to do was to represent the positions of everything in a
`Matrix{Char}`{:.language-julia .highlight},
as suggested by the example maps given in the problem.
However when looking at the problem input it quickly became apparent
that this wouldn't work as the numbers involved
(and hence the size of the matrix needed)
were very large.
Hence I looked for a solution which avoided allocating large amounts of memory,
storing only the key properties of each sensor and
using Julia's inbuilt
`UnitRange{Int}`{:.language-julia .highlight}
type to represent intervals of numbers.

For part 1, I calculated the interval of points precluded by a given sensor
at a given $y$ value,
then wrote a function to simplify a collection of such intervals
into disjoint intervals.
Counting the number of points in disjoint intervals was then easy.

It took me a long time to figure out Part 2.
My final solution relied on the logic that if there is only one point
which is not in any of the sensed regions,
then it must be near a "corner" of two sensed regions.
Thus I first calculated the intersection points of the boundaries
of the sensed regions for each pair of sensors.
I then searched the neighbours of these points to find a point
which was in none of the sensed regions.



<h3>
<a href="https://adventofcode.com/2022/day/16" style="color:#F1FA9C">
Day 16: Proboscidea Volcanium
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day16.jl" style="color:#777777">
0.923 s
</a>
</span>
</h3>

This was one of the hardest problems, involving a network search which
was large enough to require some thought to get it to finish quickly.
Firstly I did some pre-processing of the input,
using Dijkstra's algorithm to get the shortest path length between any two
valves, thus yielding a complete network.
I then dropped all the valves (nodes) with a
zero flow rate as there was no point
going to them except en route to another valve.

For part 1, I used a
[depth-first search](https://en.wikipedia.org/wiki/Depth-first_search)
(DFS), storing the state of each valve (open or closed),
the amount of time used up,
the total pressure relieved
and the current position
to describe each state.
I found that using
`UInt8`{:.language-julia .highlight}
and `UInt16`{:.language-julia .highlight}
where possible gave a noticeable speed-up over the more typical
`Int64`{:.language-julia .highlight}.

{% highlight julia %}
struct State
    opens::Vector{Bool}
    time::UInt16
    pressure::UInt16
    position::UInt8
end
{% endhighlight %}

For part 2, I first reasoned that there was no need
for both you and the elephant
to ever visit the same valve (in the processed complete network).
Therefore I used a heuristic to find all of the "good"
paths within the time limit,
meaning those with a sufficiently high total pressure release,
again using DFS.
I then searched among these paths to find the best pair which visit
disjoint sets of valves.
The cutoff value for the good paths was chosen by trial and error,
but could be found using a binary search.



<h3>
<a href="https://adventofcode.com/2022/day/17" style="color:#F1FA9C">
Day 17: Pyroclastic Flow
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day17.jl" style="color:#777777">
0.645 s
</a>
</span>
</h3>

This problem was fun to solve, especially the insights required for part 2.
Part 1 involved implementing
[Tetris](https://en.wikipedia.org/wiki/Tetris)
but without rotating the blocks.

I represented the tower of blocks using a
`Vector{Vector{Char}}`{:.language-julia .highlight}
rather than a
`Matrix{Char}`{:.language-julia .highlight}
so I could easily push new rows onto the top to make the whole assembly taller.
Replicating the behaviour was straightforward,
checking which action needed to be applied at each time step.

Part 2 was initially very challenging, asking to predict the height of the tower
after 1000000000000
(yes, a trillion) blocks had fallen.
Obviously it was not possible to simulate this fully,
but I realised that the pattern of jets and the block shapes were periodic.
After checking that the top part of the tower of blocks was also periodic,
the problem became much easier.
The answer could be calculated by running the simulation
for a few thousand iterations
to observe the repeating section
and then counting the number of repeats needed to reach
1000000000000 blocks.


<h3>
<a href="https://adventofcode.com/2022/day/18" style="color:#F1FA9C">
Day 18: Boiling Boulders
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day18.jl" style="color:#777777">
1.176 s
</a>
</span>
</h3>

This was also a fun problem.
Part 1 was easy, calculating the total area of all the cubes
and then subtracting non-exposed faces
which made contact with another cube.

For part 2 I wrote a function to "complete" a set of cubes
by filling in any internal cavities.
This let me reuse my surface area function
from part 1 to get the exterior surface area.
The completion function worked by drawing a box around the lava droplet
and marking cubes on the boundary of this box as "outside" the droplet.
I then marked any non-droplet neighbours of an
"outside" cube as also being "outside",
iterating with a DFS until termination.
The completed droplet was then simply the union of the original droplet
and the cubes which were not outside.


<h3>
<a href="https://adventofcode.com/2022/day/19" style="color:#F1FA9C">
Day 19: Not Enough Minerals
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day19.jl" style="color:#777777">
1.062 s
</a>
</span>
</h3>

I thought this was the hardest problem on the calendar,
and definitely took me the longest to solve.
This was another network search-type problem,
so I again went for a DFS approach.
However this instance was significantly larger than that from Day 16,
and I had to use the following pruning strategies to avoid
searching too large a space.

* If you can buy a geode bot, you must do so.

* If in the previous state you could have bought bot X
  but instead did nothing, then you should not buy bot X now.

* Suppose in the current state you could spend the rest of the time
  only building geode bots. If this doesn't get more geodes
  than the current best strategy, then drop the current state.

* If no object requires more than X of resource Y,
  then don't buy more than X of bot Y.

Thankfully this approach was good enough to solve both parts 1 and 2,
but it took a lot of trial and error to work out which optimisations
were worth using.


<h3>
<a href="https://adventofcode.com/2022/day/20" style="color:#F1FA9C">
Day 20: Grove Positioning System
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day20.jl" style="color:#777777">
0.274 s
</a>
</span>
</h3>

This problem was a welcome break, and was quite easy.
The main challenge here was using the right indices
and applying the correct modulo functions.
I kept track of both the mixed list and the original
index of each element in that list,
making it easy to work out which element to move next.
I was worried that part 2 might ask me to mix the list
a huge number of times, but thankfully it didn't and
I was able to use the same code for both parts.



<h3>
<a href="https://adventofcode.com/2022/day/21" style="color:#F1FA9C">
Day 21: Monkey Math
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day21.jl" style="color:#777777">
0.366 s
</a>
</span>
</h3>

Part 1 of this problem was easy but
after seeing part 2 I rewrote all my code,
keeping track of expressions for each monkey rather than values.
I then wrote a function to check for a given monkey whether
both of its "child" monkeys (the monkey that will provide its inputs)
had had their expressions parsed.
If so, I could parse the current monkey by substituting the children's
expressions into its own expression.
Repeating this for all the monkeys until termination propagated
the expressions right up to the `root` monkey.
For part 1, this could then be directly evaluated using Julia's
[metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming/)
facilities:
`Meta.parse`{:.language-julia .highlight}
converts a
`String`{:.language-julia .highlight}
to an
`Expr`{:.language-julia .highlight},
and this is evaluated to a number with
`eval`{:.language-julia .highlight}.

For part 2 I retrieved the expressions of the two children of `root`.
One of these evaluated to a number directly,
and the other retained the variable `humn`.
To find the value of `humn` which solves these equal to each other,
I implemented a
[binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm).
This was probably not guaranteed to work in all situations,
but was fine for my instance.


<h3>
<a href="https://adventofcode.com/2022/day/22" style="color:#F1FA9C">
Day 22: Monkey Map
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day22.jl" style="color:#777777">
0.863 s
</a>
</span>
</h3>

This was a challenging but fun problem,
requiring the most lines of code out of all of the problems.
Part 1 was quite easy, especially since we had already solved
a few of these "follow the rules on a grid"-type problems
(day 9, day 14, day 17),
with the only tricky task being to write down the rules for wrapping around
to the other side of the map.

Part 2 was much harder but also quite interesting.
The central data structure I used was to represent each face of
the cube by the following.

{% highlight julia %}
mutable struct Face
    id::Int
    board::Matrix{Char}
    face_coords::Matrix{Int}
    corner_loc::Tuple{Int, Int}
end
{% endhighlight %}

Here, `id` identified each face uniquely,
`board` provided the layout of open tiles and walls on the face,
`face_coords` gave the coordinates in 3D space of the
top-left, top-right and bottom-left corners of the face,
and `corner_loc` recorded where the face was located on the original
input net.
To parse the faces, I set the first face to have coordinates
`[-1 1 -1 1; 1 1 -1 -1; 1 1 1 1]` and then
traced over the net, applying the appropriate
[matrix operation](https://en.wikipedia.org/wiki/Rotation_matrix)
every time I went over an edge to keep track of the
coordinates of each face.
The main part of the problem was then to handle the logic
for going over an edge on the resulting cube.
I did this in stages, first identifying the coordinates of the
edge to cross, then matching this to determine which face we ended up on.
Again matching coordinates identified which side of this face we emerged on,
and I then had to work out where on this edge we would appear,
and which way we would then be facing.
It took me a long time to realise that I had forgotten the last step:
we had to check we wouldn't emerge into a wall,
as then we would not make the transition at all.
My code ended up being pretty long, but I think it should work
in generality as I never "hard-coded" my cube's net.


<h3>
<a href="https://adventofcode.com/2022/day/23" style="color:#F1FA9C">
Day 23: Unstable Diffusion
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day23.jl" style="color:#777777">
1.670 s
</a>
</span>
</h3>

This problem was conceptually not too hard but seemed to need
many lines of code.
I initially tried using a dictionary,
but it turned out that iterating through this was too slow
due to the number of elves,
and in fact just keeping an array of all the possible locations
was faster, since the operations are all local.
I therefore used

{% highlight julia %}
mutable struct Elf
    id::Int
    prop_loc::Union{Tuple{Int, Int}, Nothing}
end
{% endhighlight %}

and
`Elves = Matrix{Union{Elf, Nothing}}`{:.language-julia .highlight}.
Each round consisted of a few tasks:
firstly I checked if any elves were near the edge of the array,
extending the array in all directions by ten units if so.
Then I found the proposed location for each elf according to the rules.
Next I updated the locations, checking that
no elves tried to go to the same location.
Finally I reset all the proposed locations to
`nothing`{:.language-julia .highlight}.

For part 2 I was concerned that I might need a huge number of rounds
before termination, but it ended up not being too bad
and I could just reuse the code,
checking at each step if any elf still had neighbours.


<h3>
<a href="https://adventofcode.com/2022/day/24" style="color:#F1FA9C">
Day 24: Blizzard Basin
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day24.jl" style="color:#777777">
1.711 s
</a>
</span>
</h3>

One final network search problem, this time with
a time-varying network.
I stored the blizzard locations as
`Blizzard = Matrix{Vector{Int}}`{:.language-julia .highlight},
recording the number of blizzards in each direction at every location.

For part 1 I first calculated all of the blizzard locations at each
time step following the rules,
up to some time limit chosen by trial and error.
I then used DFS again for the main search problem, with

{% highlight julia %}
struct State
    loc::Tuple{Int, Int}
    time::Int
end
{% endhighlight %}

I used the following pruning strategy to reduce run-time.
I noted that the blizzards were periodic with period given
by the least common multiple of the dimensions of the valley.
Thus if we were in the same location at the same time modulo this period,
then the state had already been seen and could be discarded.

For part 2 I used the same approach,
swapping the start and end points and resuming the
blizzards after each trip to get the total round trip time.



<h3>
<a href="https://adventofcode.com/2022/day/25" style="color:#F1FA9C">
Day 25: Full of Hot Air
</a>
<span style="float: right; color: #777777; font-size: 24px;">
<a href="https://github.com/WGUNDERWOOD/
advent-of-code-2022/blob/main/src/day25.jl" style="color:#777777">
0.105 s
</a>
</span>
</h3>

This final problem turned out to be more tricky than I expected,
though didn't need many lines in the end.
Manipulating numbers in a different
[base](https://en.wikipedia.org/wiki/Radix)
didn't seem too bad,
but the inclusion of negative coefficients made this very confusing.
Writing a
`snafu_to_decimal`{:.language-julia .highlight}
function was straightforward,
looking up the coefficients in a dictionary and
calculating in base five.
The `decimal_to_snafu`{:.language-julia .highlight}
function was much harder,
and my final solution was recursive,
first finding a large enough power of five for the leading digit
and calculating the coefficient, then
calling the function again with the power reduced by one
on the remainder to get the next digit.
I finally trimmed any leading zeros.



## Concluding remarks


Julia was overall a good language to use,
offering a compromise between ease of use
(for those familiar with Python, R and MATLAB, at least),
and performance.
One downside is that Julia is not a scripting language and has a poor
startup time. This means that most of the time is spent
compiling rather than running the program, and it is impossible
to separate these two steps.
I aimed for each solution to execute in around one second,
and managed to get them all under two seconds,
which I'm fairly happy with.
Next time I might try to learn
[Rust](https://www.rust-lang.org/).
