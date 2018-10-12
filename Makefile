GEM ?= nicefn
TAG ?= 0.1.0

default: test_all

test_example_before_instance:
	@bundle exec ruby ./bin/test before inst

test_example_after_instance:
	@bundle exec ruby ./bin/test after inst

test_example_before_singleton:
	@bundle exec ruby ./bin/test before sing

test_example_after_singleton:
	@bundle exec ruby ./bin/test after sing

add_gemfile:
	@cp ./pkg/Gemfile ./

rem_gemfile:
	@rm -f Gemfile || true

rem_gemfile_lock:
	@rm -f Gemfile.lock || true

ver_gemspec:
	@echo "ver = '$(TAG)'" | cat - ./$(GEM).gemspec > ./__TMP
	@mv ./__TMP ./$(GEM).gemspec

add_gemspec:
	@cp ./pkg/$(GEM).gemspec ./$(GEM).gemspec
	@mv ./pkg/$(GEM).gemspec ./pkg/$(GEM).gemspec.bak
	@make ver_gemspec

rem_gemspec:
	@rm -f nicefn.gemspec || true
	@mv ./pkg/$(GEM).gemspec.bak ./pkg/$(GEM).gemspec

test_setup:
	@make add_gemfile
	@make add_gemspec

test_teardown:
	@make rem_gemfile
	@make rem_gemspec

test_example_project:
	@make test_teardown
	@make test_setup
	@cd ./pkg/example_project && bundle install && bundle exec ruby test.rb
	@rm -f ./pkg/example_project/Gemfile.lock || true
	@make test_teardown

test_all:
	@make test_setup
	@bundle install
	@make test_example_before_instance
	@make test_example_after_instance
	@make test_example_before_singleton
	@make test_example_after_singleton
	@make test_teardown
	@make rem_gemfile_lock

update_gem_tag:
	@git branch -D gem || true
	@git checkout -b gem
	@make add_gemfile
	@make add_gemspec
	@git add -A
	@git commit --amend --no-edit
	@git tag -a 'v$(TAG)' -f -m 'v$(TAG)'
	@git push origin 'v$(TAG)' -f
	@make rem_gemfile
	@make rem_gemspec
	@git clean -df
	@git checkout .
	@git checkout master
	@git branch -D gem
	@git push --delete origin gem
