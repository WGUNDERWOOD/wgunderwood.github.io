---
layout: post
title:  "motifcluster"
date:   2020-05-18
---


A software package
for motif-based spectral clustering
of weighted directed networks.


<img style="float: right; padding-left: 30px; padding-top: 0px;"
src="/assets/graphics/posts/images_motifcluster/hex_sticker_small.png">


First written for my master's thesis under
[Mihai Cucuringu][mcucuringu]
at the
[Department of Statistics](https://www.stats.ox.ac.uk/),
[University of Oxford](http://www.ox.ac.uk/),
**motifcluster** was further developed alongside a preprint
([arXiv:2004.01293](https://arxiv.org/abs/2004.01293))
authored by
[W. G. Underwood][wgunderwood],
[A. Elliott][aelliott],
and [M. Cucuringu][mcucuringu].
It is available on
[GitHub](https://github.com/WGUNDERWOOD/motifcluster)
for
[R](https://cran.r-project.org/web/packages/motifcluster/index.html)
and
[Python](https://pypi.org/project/motifcluster/).

The **motifcluster** packages for R and Python provide the capability for:

- Building motif adjacency matrices
- Sampling random weighted directed networks
- Spectral embedding with motif adjacency matrices
- Motif-based spectral clustering

The methods are all designed to run quickly on large sparse networks,
and are easy to install and use.

## R package

The **motifcluster** package
was originally written in R.

### Installation

The R package can be installed from CRAN with:

{% highlight R %}
install.packages("motifcluster")
{% endhighlight %}

### Documentation

The package's manual is in the
[R/doc](https://github.com/WGUNDERWOOD/motifcluster/tree/main/R/doc)
directory on GitHub.
An instructional vignette is in the
[R/vignettes](https://github.com/WGUNDERWOOD/motifcluster/tree/main/R/vignettes)
directory on GitHub.



## Python

The **motifcluster** package
is now also available in Python.
This offers some improved performance
over the R package,
though the functionality is the same.

### Installation

The Python package can be installed from PyPI with:

{% highlight shell %}
pip install motifcluster
{% endhighlight %}

### Documentation

Full documentation is available at
[motifcluster.readthedocs.io](https://motifcluster.readthedocs.io/).


[wgunderwood]: /
[mcucuringu]: https://scholar.google.com/citations?user=GFvVRzwAAAAJ&hl=en
[aelliott]: https://www.turing.ac.uk/people/researchers/andrew-elliott
