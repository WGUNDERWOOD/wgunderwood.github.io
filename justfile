#default:
#just site
#sleep 4
#just view

#all: todo spell longlines linkcheck site

#site:
#JEKYLL_ENV=development bundle exec jekyll serve &

stop:
    @pkill -f "jekyll"

view:
    @firefox --new-window "localhost:4000" &

linkcheck:
    @linkchecker --ignore-url=researchgate.*William.*Underwood \
        --check-extern "https://wgunderwood.github.io/" --no-warnings

spell:
    @spell-check *.markdown _posts/**/*.markdown

longlines:
    @long-lines *.markdown _posts/**/*.markdown

todo:
    @todo-finder *.markdown _posts/**/*.markdown
