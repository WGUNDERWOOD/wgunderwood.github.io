default:
    just serve &
    sleep 3
    just view

all: todo spell build

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

update:
    @bundle update

spell:
    @spell-check *.markdown _posts/**/*.markdown

todo:
    @todo-finder *.markdown _posts/**/*.markdown
