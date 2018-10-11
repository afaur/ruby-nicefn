## Ruby Nicefn
Elixir and javascript have the capability of making good looking one liners, but
what about Ruby? We can definitely make an awful looking one by adding a ';'. If
you want to start defining some better looking one-liners then add the 'nicefn'
gem to your project. Since the implementation files are small and this project
has no required deps. You should also feel free to copy and paste the
implementation directly into your project in an effort to avoid extra gems.

## Project Structure
Running `make` will default to running the tests inside `tst` folder against the
examples inside the `exa` folder.

## How To Use
Add 'extend NiceFn::Inst' to the top of classes. You can also use 'include
NiceFn::Sing' in a `module` to make it a singleton class with `nicefn` methods.

### Example (Regular Classes)
Provided below is an example class with `public`, `private`, and `protected` methods:
```rb
class Inst
  attr_writer :person

  def test_priv(greet)
    priv "#{greet}"
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
If we use `nicefn` on this class we can eliminate 10 lines of code inside of the
class definition. This is because `private` and `protected` are handled by
different functions (like `defp` in `elixir`).

### After Adding InstFn
```rb
require 'nicefn'

class Inst
  extend NiceFn::Inst
  attr_writer :person

  fn(:test_priv)  {|greet| priv "#{greet}"}
  fn(:test_share) {|greet, inst| inst.share greet}

  fp(:priv)  {|greet| puts "#{greet} #{@person}"}

  fs(:share) {|greet| puts "#{greet} #{@person}"}
end
```
Calling `fn` with a function `name` and a block will give you a public method.
If you call 'fp' you will get a private method, and 'fs' will set a protected
(shared) method.

### Example (Singleton Classes)
Provided below is an example of a singleton class that is made a singleton class
by using extend self. 
```rb
module Sing
  extend self
  attr_writer :person

  def test_priv(greet)
    priv "#{greet}"
  end

private
  def priv(greet)
    puts "#{greet} #{@person}"
  end
end
```
After we add 'include NiceFn::Sing' to the module we can eliminate the need to
extend self as 'Sing' will do it for us.

### After Adding SingFn
```rb
require 'nicefn'

module Sing
  include NiceFn::Sing
  attr_writer :person

  fn(:test_priv) {|greet| priv greet}
  fp(:priv)      {|greet| puts "#{greet} #{@person}"}
end
```
Calling `fn` with a function `name` and a block will give you a public method.
If you call 'fp' you will get a private method. Since singletons classes can
only act as one instance 'fs' is not a provided option.
