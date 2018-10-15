[![Gem Version](https://badge.fury.io/rb/nicefn.svg)](https://rubygems.org/gems/nicefn)
[![Gem Downloads](https://ruby-gem-downloads-badge.herokuapp.com/nicefn?color=brightgreen&type=total)](https://rubygems.org/gems/nicefn)
[![Build Status](https://travis-ci.org/afaur/ruby-nicefn.svg?branch=master)](https://travis-ci.org/afaur/ruby-nicefn)
[![Maintainability](https://api.codeclimate.com/v1/badges/6e10f0a9ac5b168e8821/maintainability)](https://codeclimate.com/github/afaur/ruby-nicefn/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6e10f0a9ac5b168e8821/test_coverage)](https://codeclimate.com/github/afaur/ruby-nicefn/test_coverage)

### Overview
Here's a way to write functions (with visibility modification) in a single line of ruby.
```rb
  ...
  fp(:priv)  { |greet| puts greet }
  ...
```
This will automatically declare a function with private visibility. Which will
make it like you had actually wrote:
```rb
  ...
  private

  def priv(greet)
    puts greet
  end
  ...
```

### Example (Main Scope)
If you want to write short one-liners in the main scope you need not add this gem
to your project. It is much quicker and simpler to do:
```rb
alias fn define_singleton_method

fn(:test) { puts “hello” }

test # <= prints "hello" to stdout
```

### Example (Regular Classes)
Provided below is an example class with `public`, `private`, and `protected` methods:
```rb
class Inst
  attr_writer :person

  def self.set_klass_property(value)
    @@klass_property = value
  end

  def self.print_klass_property()
    puts @@klass_property
  end

  def test_priv(greet)
    priv greet
  end

  def test_share(greet, inst)
    inst.share greet
  end

  private

  def priv(greet)
    puts "#{greet} #{@person}"
  end

  protected

  def share(greet)
    puts "#{greet} #{@person}"
  end
end
```
If we use `nicefn` on this class we can eliminate more than 12 lines of code (if
we add spaces around private and protected like rubocop suggests) inside of the
class definition. This is because `private` and `protected` are handled by
different functions (like `defp` in `elixir`).

### After Adding Nicefn::Inst
```rb
require 'nicefn'

class Inst
  extend Nicefn::Inst
  attr_writer :person

  cm(:set_klass_property)   { |value| @@klass_property = value }
  cm(:print_klass_property) { puts @@klass_property }

  fn(:test_priv)  { |greet| priv greet }
  fn(:test_share) { |greet, inst| inst.share greet }

  fp(:priv)  { |greet| puts "#{greet} #{@person}" }

  fs(:share) { |greet| puts "#{greet} #{@person}" }
end
```
Calling `fn` with a function `name` and a block will give you a public method.
(**Since version 0.1.1**) Class methods are created using the `cm` function.
If you call `fp` you will get a `private` method, and `fs` will set a
`protected` (shared) method.

### Example (Singleton Classes)
Provided below is an example of a `module` that is made a `singleton class` by using
`extend self`.
```rb
module Sing
  extend self
  attr_writer :person

  def test_priv(greet)
    priv greet
  end

private
  def priv(greet)
    puts "#{greet} #{@person}"
  end
end
```
After we add `include Nicefn::Sing` to the module we can eliminate the need to
extend self as `Nicefn::Sing` will do it for us.

### After Adding Nicefn::Sing
```rb
require 'nicefn'

module Sing
  include Nicefn::Sing
  attr_writer :person

  fn(:test_priv) { |greet| priv greet }
  fp(:priv)      { |greet| puts "#{greet} #{@person}" }
end
```
Calling `fn` with a function `name` and a block will give you a public method.
If you call `fp` you will get a `private` method. Since singletons classes can
only act as one instance 'fs' is not a provided option.

## Install Gem
You can run `bundle add nicefn --version '~> 0.1.0'`, or manually add a line
indicating how you would like to fetch the `gem` to your `Gemfile`:
```rb
...
# Download latest nicefn from default source
gem 'nicefn'

# Download nicefn from default source with version constraints
gem 'nicefn', '~> 0.1.1'

# Download nicefn from git with a specific version
gem 'nicefn', git: 'https://github.com/afaur/ruby-nicefn', tag: 'v0.1.1'
...
```

## Project Structure
Running `make` will default to running the tests inside `tst` folder against the
examples inside the `exa` folder.

## How To Use
Add `extend Nicefn::Inst` to the top of classes. You can also use `include
Nicefn::Sing` in a `module` to make it a singleton class with `nicefn` methods.
