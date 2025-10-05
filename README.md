# wgunderwood.github.io

My
[personal website](https://wgunderwood.github.io/),
built using
[Jekyll](https://jekyllrb.com/)
and hosted with [GitHub Pages](https://pages.github.com/).

## Nix environment

Enter the Nix environment with `nix develop`.

## Updating gems

To update gems, exit the Nix environment and run `just update`,
then reenter with `nix develop` and regenerate `gemset.nix` with `just gemset`.
Reload the Nix environment one more time.

## Posts

All of my posts can be found under
[_posts/](https://github.com/WGUNDERWOOD/wgunderwood.github.io/tree/main/_posts),
including any code which I wrote.
