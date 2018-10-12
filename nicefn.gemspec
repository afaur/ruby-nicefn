ver = '0.1.0'
lib = File.join(__dir__, 'lib')

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nicefn'

Gem::Specification.new do |spec|
  spec.name          = 'nicefn'
  spec.version       = ver
  spec.authors       = ['afaur']
  spec.email         = ['zazu-app@googlegroups.com']

  spec.summary       = %(This gem adds an alternative way of specifying
one-liners in your project.)

  spec.description   = %(Elixir and javascript have the capability of making
good looking one liners, but what about Ruby? We can definitely make an awful
looking one by adding a ';'. If you want to start defining some better looking
one-liners then add the 'nicefn' gem to your project. Since the implementation
files are small and this project has no required deps. You should also feel free
to copy and paste the implementation directly into your project in an effort to
avoid extra gems.)

  spec.homepage      = 'https://github.com/afaur/ruby-nicefn.git'
  spec.license       = 'Unlicense'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git
  spec.files         = Dir.chdir(__dir__) do
    # Get all tracked files from git as an array
    git_files = `git ls-files -z`.split("\x0")
    # Remove directories & files that the gem does not use
    git_files
      .reject { |f| f.match(%r{^(tst|exa|bin|pkg)/}) }
      .reject { |f| ['Makefile', '.gitignore', '.travis.yml'].include? f }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov', '~> 0.16', '>= 0.16.1'
  spec.add_development_dependency 'test-unit', '~> 3.2', '>= 3.2.8'
end
