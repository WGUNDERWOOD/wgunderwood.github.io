---
layout: post
title:  "Advent of Code 2022"
date:   2023-01-03
---

In 2022 I tackled
[Advent of Code](https://adventofcode.com/)
for the first time,
using the Julia language. Here are some of my thoughts.
My solutions are available on
[GitHub](https://github.com/WGUNDERWOOD/advent-of-code-2022).

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
Julia is a high-level yet high-performance language which is
as easy to write as Python and
[almost as fast as C](https://julialang.org/benchmarks/).
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

While I had seen dynamic programming methods such as
[Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
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
My solutions are available on
[GitHub](https://github.com/WGUNDERWOOD/advent-of-code-2022).

<h3>
<a href="https://adventofcode.com/2022/day/1" style="color:#F1FA9C">
Day 1: Calorie Counting
</a>
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



<h3>
<a href="https://adventofcode.com/2022/day/2" style="color:#F1FA9C">
Day 2: Rock Paper Scissors
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/3" style="color:#F1FA9C">
Day 3: Rucksack Reorganization
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/4" style="color:#F1FA9C">
Day 4: Camp Cleanup
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/5" style="color:#F1FA9C">
Day 5: Supply Stacks
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/6" style="color:#F1FA9C">
Day 6: Tuning Trouble
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/7" style="color:#F1FA9C">
Day 7: No Space Left On Device
</a>
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


<h3>
<a href="https://adventofcode.com/2022/day/8" style="color:#F1FA9C">
Day 8: Treetop Tree House
</a>
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

For this problem I wrote a running maximum function to keep track
of the largest tree in a particular direction,
and then used some simple logic to establish whether
there is a line of sight from a tree to the edge of the grid.
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
TODO
</span>
</h3>

For this question I needed only two functions,
one to move the head of the rope according to the instructions
and another to adjust the tail to keep up with the head.
To do this one needs only to check
that the tail segment is two squares away (in $L^\infty$ norm)
from the head and then adjust it with
`tail += sign(head - tail)`{:.language-julia .highlight}.

The extension to longer ropes was easy,
making sure to adjust the rope from head to tail
in order to propagate the motion correctly.
Finally the
`unique`{:.language-julia .highlight}
function makes counting the visited squares trivial.


<h3>
<a href="https://adventofcode.com/2022/day/10" style="color:#F1FA9C">
Day 10: Cathode-Ray Tube
</a>
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

The following two simple functions carry out the bulk of
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
TODO
</span>
</h3>

I found this problem quite difficult,
and eventually settled on the following composite type
for each monkey.
In light of part 2, which requires modular arithmetic
to prevent numbers growing too large,
each item is stored as a dictionary of
divisor -> remainder pairs.
The `operation`{:.language-julia .highlight}
field contains each monkey's operation as an anonymous function
while `test`{:.language-julia .highlight}
stores the divisor used for its divisibility test.
The potential destination monkeys for the items are given in
`dest`{:.language-julia .highlight},
and we keep track of the number of times the monkey inspects an item in
`inspections`{:.language-julia .highlight}.
Once the input has been parsed, performing the rounds of
throwing is quite straightforward.


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
TODO
</span>
</h3>

This is a classic shortest path problem,
with the network edges determined by the heights of neighbouring squares.
I solved this using Dijkstra's algorithm,
keeping track of visited squares and their distances in
auxiliary arrays.
By running the algorithm to completion,
not stopping after reaching the target square but
rather finding the shortest path to all reachable squares,
part 2 follows immediately without having to run
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

Note that each distance
is of type
`Union{Int, Float64}`{:.language-julia .highlight}
to allow for the value
`Inf::Float64`{:.language-julia .highlight}.


<h3>
<a href="https://adventofcode.com/2022/day/13" style="color:#F1FA9C">
Day 13: Distress Signal
</a>
<span style="float: right; color: #777777; font-size: 24px;">
TODO
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
using quick sort without having to implement it myself.


<h3>
<a href="https://adventofcode.com/2022/day/14" style="color:#F1FA9C">
Day 14: Regolith Reservoir
</a>
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

This problem was fun to solve as it was easy to visualize and check everything
is working properly.
The first challenge was to parse the layout of the cave from the input,
which amounted to modifying entries in a matrix along a line
given the start and end points of that line.
I then represented the cave using

{% highlight julia %}
mutable struct Cave
    layout::Matrix{Char}
    current::Tuple{Int, Int}
    const start::Tuple{Int, Int}
    terminated::Bool
end
{% endhighlight %}

where `layout`{:.language-julia .highlight} function
shows the cave structure as in the problem statement,
`current`{:.language-julia .highlight}
gives the current location of the falling unit of sand,
`start`{:.language-julia .highlight}
is the starting point of the sand and
`terminated`{:.language-julia .highlight}
determines whether to stop the simulation.
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
TODO
</span>
</h3>

This day was quite tricky.
The obvious thing to do is to represent the positions of everything in a
`Matrix{Char}`{:.language-julia .highlight},
as suggested by the example maps given in the problem.
However when looking at the problem input it quickly becomes apparent
that this won't work as the numbers involved
(and hence the size of the matrix needed)
are very large.
Hence I looked for a solution which avoids allocating large amounts of memory,
storing only the key properties of each sensor and
using Julia's inbuilt
`UnitRange{Int}`{:.language-julia .highlight}
type to represent intervals of numbers.

For part 1, I calculated the interval of points precluded by a given sensor
at a given $y$ value,
then wrote a function to simplify a collection of such intervals
into disjoint intervals.
Counting the number of points in disjoint intervals is then easy.

It took me a long time to figure out Part 2.
My final solution relies on the logic that if there is only one point
which is not in any of the sensed regions,
then it must be near a "corner" of two sensed regions.
Thus it first calculates the intersection points of the boundaries
of the sensed regions for each pair of sensors.
It then searches the neighbours of these points to find a point
which is in none of the sensed regions.



<h3>
<a href="https://adventofcode.com/2022/day/16" style="color:#F1FA9C">
Day 16: Proboscidea Volcanium
</a>
<span style="float: right; color: #777777; font-size: 24px;">
TODO
</span>
</h3>

This was one of the hardest problems.

TODO write






'a':'z' is neat
Dynamic allocation with growing arrays (day 17, 23)
Day 23 was worried part 2 would take a huge amount of time but no
Day 20 just tricky indexing

TODO check all code looks good

TODO check mutable / const

TODO check tenses

TODO check US/UK

TODO check links


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
