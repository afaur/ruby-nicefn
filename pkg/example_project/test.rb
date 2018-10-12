require 'nicefn'

# Example class with one-liner fn definitions
class Inst
  extend Nicefn::Inst
  fn(:test) { puts 'hello from class instance' }
end

i = Inst.new
i.test

# Example singleton class with one-liner fn definitions
module Sing
  include Nicefn::Sing
  fn(:test) { puts 'hello from singleton class' }
end

Sing.test
