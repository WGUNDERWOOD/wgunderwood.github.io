.PHONY: site stop view linkcheck spell longlines

default:
	@make site
	@sleep 3
	@make view

all: default
	@make spell
	@make longlines
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
	@linkchecker --ignore-url=researchgate.*William.*Underwood \
    --check-extern "https://wgunderwood.github.io/" --no-warnings

spell:
	@for f in *.markdown; do spell_check $$f; done
	@for f in _posts/**/*.markdown; do spell_check $$f; done

longlines:
	@for f in *.markdown; do longest_lines $$f; done
	@for f in _posts/**/*.markdown; do longest_lines $$f; done

todo:
	@echo -e "\e[0;35m\033[1mChecking for todos...\e[0;30m\033[0m"
	@for f in *.markdown; do todo_finder $$f; done
	@for f in _posts/**/*.markdown; do todo_finder $$f; done
