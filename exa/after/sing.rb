require_relative '../../lib/nicefn.rb'

module Sing
  include Nicefn::Sing
  attr_writer :person

  fn(:test_priv) {|greet| priv greet}
  fp(:priv)      {|greet| puts "#{greet} #{@person}"}
end
