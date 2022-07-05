.PHONY: site stop view

all: site view

site:
	@echo -e "\e[0;35m\033[1mBuilding website...\e[0;30m\033[0m"
	@JEKYLL_ENV=development bundle exec jekyll serve &

stop:
	@echo -e "\e[0;35m\033[1mKilling Jekyll...\e[0;30m\033[0m"
	@pkill -f jekyll > /dev/null 2>&1

view:
	@firefox --new-window "localhost:4000"

linkcheck:
	@linkchecker "https://wgunderwood.github.io/"
