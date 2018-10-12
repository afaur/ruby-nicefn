require_relative '../../lib/nicefn.rb'

# Example class with one-liner fn definitions
# Example singleton class with one-liner fn definitions
module Sing
  include Nicefn::Sing
  attr_writer :person

  fn(:test_priv) { |greet| priv greet }
  fp(:priv)      { |greet| puts "#{greet} #{@person}" }
end
