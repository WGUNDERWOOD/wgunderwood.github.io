all:
	@echo -e "\e[0;35m\033[1mBuilding website...\e[0;30m\033[0m"
	@ JEKYLL_ENV=development bundle exec jekyll serve
