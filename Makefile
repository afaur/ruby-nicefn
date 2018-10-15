GEM ?= nicefn
TAG ?= 0.1.1

default: test_examples

# Run tests on all the files in the `exa` folder
all_test_examples:
	@bundle exec ruby ./bin/verify before inst
	@bundle exec ruby ./bin/verify after inst
	@bundle exec ruby ./bin/verify before sing
	@bundle exec ruby ./bin/verify after sing

# Add the ./pkg/ Gemfile to the project root
add_root_gemfile:
	@cp ./pkg/Gemfile ./

# Remove the Gemfile in the project root
rem_root_gemfile:
	@rm -f Gemfile || true

# Remove the Gemfile.lock in the project root
rem_root_gemfile_lock:
	@rm -f Gemfile.lock || true

rem_example_gemfile_lock:
	@rm -f ./pkg/example_project/Gemfile.lock || true

# Add version from env var to the .gemspec in project root
ver_root_gemspec:
	@echo "ver = '$(TAG)'" | cat - ./$(GEM).gemspec > ./__TMP
	@mv ./__TMP ./$(GEM).gemspec

# Add the .gemspec to the project root
add_root_gemspec:
	@cp ./pkg/$(GEM).gemspec.bak ./$(GEM).gemspec

# Remove the .gemspec from the project root
rem_root_gemspec:
	@rm -f nicefn.gemspec || true

test_setup:
	# Add the gemfile from ./pkg/ folder to project root
	@make add_root_gemfile
	# Add the .gemspec from ./pkg/ folder to project root
	@make add_root_gemspec
	# Uses TAG env for version info at top of .gemspec in project root
	@make ver_root_gemspec

# Remove Gemfile and .gemspec in project root and restore ./pkg/ .gemspec
test_teardown:
	@make rem_root_gemfile
	@make rem_root_gemspec

test_example_project:
	# Remove Gemfile and .gemspec in project root (if they exist)
	@make test_teardown
	# Add the gemfile and .gemspec from ./pkg/ folder to project root
	@make test_setup
	# Simulate install of gem inside an example project and run it
	@cd ./pkg/example_project && bundle install && bundle exec ruby test.rb
	# Remove Gemfile.lock created when installing example_project deps
	@make rem_example_gemfile_lock
	# Remove Gemfile and .gemspec in project root and restore ./pkg/ .gemspec
	@make test_teardown

test_examples:
	# Add the gemfile and .gemspec from ./pkg/ folder to project root
	@make test_setup
	# Install dev deps for simplecov to run correctly
	@bundle install
	# Run tests against all examples (before and after using gem)
	@make all_test_examples
	# Remove Gemfile and .gemspec in project root and restore ./pkg/ .gemspec
	@make test_teardown
	# Remove project root Gemfile.lock created when installing dev deps
	@make rem_root_gemfile_lock

# Add new tag defaults to using the version stored at top of Makefile
# Creates a tag named v$(TAG) and pushes it to the remote repository
update_gem_tag:
	@./bin/tag-gem $(TAG)

# Checks out a tagged gem release and publishes it to rubygems
publish_to_rubygems:
	@./bin/publish $(TAG)
