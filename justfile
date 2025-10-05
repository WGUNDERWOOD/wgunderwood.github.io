default:
    just serve &
    sleep 3
    just view

all: todo spell longlines linkcheck build

stop:
    @pkill -f "jekyll"

build:
    @jekyll build

serve:
    @JEKYLL_ENV=development jekyll serve

gemset:
    @BUNDLE_FORCE_RUBY_PLATFORM=true bundix --magic

view:
    @firefox --new-window "localhost:4000" &

linkcheck:
    @linkchecker --ignore-url=researchgate.*William.*Underwood \
        --check-extern "https://wgunderwood.github.io/" --no-warnings

update:
    @bundle update

spell:
    @spell-check *.markdown _posts/**/*.markdown

longlines:
    @long-lines *.markdown _posts/**/*.markdown

todo:
    @todo-finder *.markdown _posts/**/*.markdown
