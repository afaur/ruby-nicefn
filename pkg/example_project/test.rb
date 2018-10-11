require 'nicefn'

class Inst
  extend Nicefn::Inst
  fn(:test) {puts "hello from class instance"}
end

i = Inst.new
i.test

module Sing
  include Nicefn::Sing
  fn(:test) {puts "hello from singleton class"}
end

Sing.test
