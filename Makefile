.PHONY: test

default: test_all

test_example_before_instance:
	@./bin/test before inst

test_example_after_instance:
	@./bin/test after inst

test_example_before_singleton:
	@./bin/test before sing

test_example_after_singleton:
	@./bin/test after sing

add_gem:
	@cp pkg/Gemfile ./
	@cp pkg/*.gemspec ./

rem_gem:
	@rm Gemfile && rm nicefn.gemspec

test_example_project:
	@make add_gem
	@cd pkg/example_project && bundle install && bundle exec ruby test.rb
	@rm pkg/example_project/Gemfile.lock
	@make rem_gem

test_all:
	@make test_example_before_instance
	@make test_example_after_instance
	@make test_example_before_singleton
	@make test_example_after_singleton
	@make test_example_project
