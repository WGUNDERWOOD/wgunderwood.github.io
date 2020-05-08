---
layout: post
title:  "Goodstein Sequences"
date:   2020-01-08
---

Goodstein sequences grow fast and appear to diverge to infinity.
But a neat application of ordinal arithmetic gives a surprising result.

{% include mathjax.html %}

<div style="display:none">
  $\newcommand \om \omega}$
</div>


## Cantor normal form

Before we define Goodstein sequences,
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

- Then write the result in Cantor normal form, base $3$. <br>
  Replace every $3$ with a $4$, and subtract $1$. <br>
$\cdots$

- Then write the result in Cantor normal form, base $k$. <br>
  Replace every $k$ with a $k+1$, and subtract $1$. <br>
$\cdots$

We repeat this and stop if and when the sequence hits $0$.

### Example

Take $N=5$.

$$
\begin{align*}

  5 &= 2^2 + 1 \\
  &\mapsto 3^3 + 1 - 1 \\
  &= 27 \\ \\

  27 &= 3^3 \\
  &\mapsto 4^4 - 1 \\
  &= 255 \\ \\

  255 &= 3 \cdot 4^3 + 3 \cdot 4^2 + 3 \cdot 4 + 3 \\
  &\mapsto 3 \cdot 5^3 + 3 \cdot 5^2 + 3 \cdot 5 + 3 - 1 \\
  &= 467 \\ \\

  467 &= 3 \cdot 5^3 + 3 \cdot 5^2 + 3 \cdot 5 + 2 \\
  &\mapsto 3 \cdot 6^3 + 3 \cdot 6^2 + 3 \cdot 6 + 2 - 1 \\
  &= 775 \\ \\

  775 &= \cdots \\ \\

\end{align*}
$$

We see that this sequence grows at each step.
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
  2454,
  \ldots
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
  1937434592,
  \ldots
)$$

### Goodstein's theorem

It is tempting to conjecture that all the Goodstein sequences started from
some $N \geq 4$ diverge to infinity. However, this is not at all true, due to
a remarkable theorem of [Goodstein](https://en.wikipedia.org/wiki/Goodstein%27s_theorem).

#### Theorem (Goodstein, 1944)

Every Goodstein sequence eventually hits zero!

## Ordinal numbers

Before we attempt to prove Goodstein's theorem,
it is helpful to introduce ordinal numbers.

An ordinal number is a certain type of set which is very
important in set theory.
Rather than define ordinals in detail, we instead just introduce the
few ordinal numbers which we will actually need for Goodstein's theorem.

The intuition we require is that:
- The empty set $\\{\\}$ is an ordinal, and we write it as $0$.
- Every ordinal is the set of ordinals smaller than it.

### Construction

Let's build some ordinals.
$0$ is an ordinal, and we can put it in a set.
This new set is $\\{0\\}$, and is called $1$.
Likewise, the following are all ordinals:

$$
\begin{align*}
\{\} &= 0 \\
\{0\} &= 1 \\
\{0,1\} &= 2 \\
\{0,1,2\} &= 3 \\
&\cdots
\end{align*}
$$

But why stop there? We can put all of these ordinals
in a set, and call it $\om$. Then the following are ordinals, too:

$$
\begin{align*}
\{0,1,2,3,\ldots\} &= \om \\
\{0,1,2,3,\ldots, \om\} &= \om + 1 \\
\{0,1,2,3,\ldots, \om, \om+1\} &= \om + 2 \\
&\cdots
\end{align*}
$$

Putting all of these in a set gives $\om + \om$, or $\om \cdot 2$.
Then we can form $\om \cdot 3$, and so on.
But these are all ordinals too, so everything so far
can again be put in a set, called $\om \cdot \om$ or $\om^2$.

$$
\om , \om+1, \ldots, \om \cdot 2, \ldots, \om \cdot 3, \ldots \ldots, \om^2
$$

Now we can just keep going up to
$\om^2 + \om^2$, written $\om^2 \cdot 2$.
Then we can reach $\om^2 \cdot 3$ and so on.
Now I'm sure you can see how to reach $\om^3$, and eventually $\om^\om$.
We still need more ordinals, so we continue to $\om^{\om^\om}$ and
finally to $\om^{\om^{\om^{\cdot^{\cdot^\cdot}}}}$, which is called $\epsilon_0$.
This is enough ordinals for now.

### Notes on ordinals

It may appear initially that $\om$ and $\om+1$ are the same number.
While it is true that the two sets are of the same size,
(which is never the case for two distinct finite ordinals),
the ordinals $\om$ and $\om+1$ are genuinely different.
For example, $\omega+1$ has an ordinal "just before it",
namely $\om$.
This is of course not true for $\om$,
since there is no largest finite ordinal.

It is also interesting to note that despite the huge size of $\epsilon_0$,
it is still a countably infinite set
(since we can obtain it with countably many unions of countable sets),
so has the same cardinality as $\om$.

However, [Hartogs' theorem](https://en.wikipedia.org/wiki/Hartogs_number)
guarantees the existence of uncountable
ordinals in [ZF set theory](https://en.wikipedia.org/wiki/Zermelo%E2%80%93Fraenkel_set_theory).
The smallest of these is called $\om_1$.

### Foundation

The [axiom of foundation](https://en.wikipedia.org/wiki/Axiom_of_regularity)
is part of ZF set theory, and gives
the following useful proposition about ordinals.
This is what we will use to prove Goodstein's theorem.

#### Proposition

There is no infinite strictly decreasing sequence of sets,
$A_0 \ni A_1 \ni A_2 \ni \cdots$

Hence, as each ordinal contains all the previous ordinals,
there is no strictly decreasing sequence of ordinals,
$\alpha_0 > \alpha_1 > \alpha_2 > \cdots$


## A proof of Goodstein's theorem

We will illustrate our proof with an example, started from $N=100$.
Firstly we write $N$ in Cantor normal form with base $2$,
and find an ordinal upper bound by replacing every $2$ by an $\om$.
Note that this ordinal is one which we constructed earlier,
as it is less than $\epsilon_0$.

$$
\begin{align*}
100 &= 2^{2^2+2} + 2^{2^2+1}+ 2^2 \\
&\leq \om^{\om^\om+\om} + \om^{\om^\om+1}+ \om^\om \\
\end{align*}
$$

Next we replace every $2$ by a $3$,
and the inequality still holds:

$$
3^{3^3+3} + 3^{3^3+1}+ 3^3 \leq \om^{\om^\om+\om} + \om^{\om^\om+1}+ \om^\om \\
$$

Then we subtract $1$ and find the Cantor expansion in base $3$.
At this point we find a new ordinal upper bound, by replacing each $3$ with
an $\om$.

$$
\begin{align*}
3^{3^3+3} + 3^{3^3+1}+ 3^3 - 1 &= 3^{3^3+3} + 3^{3^3+1}+ 2 \cdot 3^2 + 2 \cdot 3 + 2 \\
&\leq \om^{\om^\om+\om} + \om^{\om^\om+1}+ 2 \cdot \om^2 + 2 \cdot \om + 2
\end{align*}
$$

Now importantly, the ordinal upper bound has *decreased*.
In fact it will decrease at every step,
giving a strictly decreasing sequence of ordinal upper bounds $(\alpha_0, \alpha_1,\ldots)$
with

$$
\begin{align*}
N = G_N(0) &\leq \alpha_0 \\
G_N(1) &\leq \alpha_1 \\
G_N(2) &\leq \alpha_2 \\
&\cdots
\end{align*}
$$

But there is no strictly decreasing sequence of ordinals,
so in fact the Goodstein sequence $G_N$ must hit $0$
after some finite number of steps.

## Conclusion

Although we have proven that every Goodstein sequence eventually hits $0$,
it may take a [*very*](https://googology.wikia.org/wiki/Goodstein_sequence)
long time to do so.
While $G_3$ hits $0$ after 5 steps,
$G_4$ takes an enormous $3 \cdot 2^{402653211} − 3$ steps to do so.
After that, exact lengths of the sequences are unknown,
although some bounds are available.

## References

- The [Wikipedia](https://en.wikipedia.org/wiki/Goodstein%27s_theorem)
  page gives a good introduction to Goodstein's theorem.
- [Googology](https://googology.wikia.org/wiki/Goodstein_sequence)
  is a online encyclopedia about large numbers, and contains bounds on the lengths
  of Goodstein sequences.
- Goodstein's
  [original paper](https://www.jstor.org/stable/2268019?seq=1#metadata_info_tab_contents)
  from 1944.
