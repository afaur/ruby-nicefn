require_relative '../../lib/nicefn.rb'

# Example class with one-liner fn definitions
class Inst
  extend Nicefn::Inst
  attr_writer :person

  cm(:set_klass_property) { |value| @@klass_property = value }
  cm(:print_klass_property) { puts @@klass_property }

  fn(:test_priv)  { |greet| priv greet }
  fn(:test_share) { |greet, inst| inst.share greet }

  fp(:priv)  { |greet| puts "#{greet} #{@person}" }

  fs(:share) { |greet| puts "#{greet} #{@person}" }
end
