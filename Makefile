.PHONY: site stop view linkcheck

default:
	@make site
	@sleep 3
	@make view

all: default
	@make linkcheck

site:
	@echo -e "\e[0;35m\033[1mBuilding website...\e[0;30m\033[0m"
	@JEKYLL_ENV=development bundle exec jekyll serve &

stop:
	@echo -e "\e[0;35m\033[1mKilling Jekyll...\e[0;30m\033[0m"
	@pkill -f "jekyll" > /dev/null 2>&1

view:
	@echo -e "\e[0;35m\033[1mLaunching browser...\e[0;30m\033[0m"
	@firefox --new-window "localhost:4000" &

linkcheck:
	@echo -e "\e[0;35m\033[1mChecking links...\e[0;30m\033[0m"
	@linkchecker --check-extern "https://wgunderwood.github.io/"
