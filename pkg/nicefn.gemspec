dir = File.dirname(File.realpath(__FILE__))
lib = File.join(dir, 'lib')

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "#{lib}/nicefn.rb"

Gem::Specification.new do |spec|
  spec.name          = 'nicefn'
  spec.version       = "0.1.0"
  spec.authors       = ['afaur']
  spec.email         = ['zazu-app@googlegroups.com']

  spec.summary       = %q{This gem adds an alternative way of specifying one-liners in your project.}
  spec.description   = %q{Elixir and javascript have the capability of making
good looking one liners, but what about Ruby? We can definitely make an awful
looking one by adding a ';'. If you want to start defining some better looking
one-liners then add the 'nicefn' gem to your project. Since the implementation
files are small and this project has no required deps. You should also feel free
to copy and paste the implementation directly into your project in an effort to
avoid extra gems.}

  spec.homepage      = 'https://github.com/afaur/ruby-nicefn.git'
  spec.license       = 'Unlicense'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(dir) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(tst)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end
