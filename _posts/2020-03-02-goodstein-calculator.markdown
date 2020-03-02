---
layout: post
title:  "Goodstein Sequence Calculator"
date:   2020-03-02
---

To complement my earlier [post](/2020/01/08/goodstein-sequences.html)
on Goodstein sequences, I wrote a Python script to calculate them.

The source code is available on
[GitHub](https://github.com/WGUNDERWOOD/goodstein-calculator).

{% include mathjax.html %}

<div style="display:none">
  $\newcommand \om \omega}$
</div>

## Usage

The python script takes two arguments:
- `INITIAL_VALUE`, the initial value of the Goodstein sequence
- `SEQUENCE_LENGTH`, the number of terms in the sequence to print

The optional flag `--colorize` adds colour to the terminal output, making it easier to read.


## Examples

### A quickly terminating sequence

```python3 goodstein_calculator.py 3 10 --colorize```

The Goodstein calculator started from 3 returns just
6 values before the sequence hits zero.

### An fast-growing sequence

```python3 goodstein_calculator.py 4 1000 --colorize```

The Goodstein sequence started from 4 reaches
a million in the first one thousand terms.

### An *very* fast-growing sequence

```python3 goodstein_calculator.py 10 1000 --colorize```

The Goodstein sequence started from 10 quickly reaches
numbers which are so large they are difficult to read.
