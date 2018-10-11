require_relative '../../lib/nicefn.rb'

class Inst
  extend Nicefn::Inst
  attr_writer :person

  fn(:test_priv)  {|greet| priv "#{greet}"}
  fn(:test_share) {|greet, inst| inst.share greet}

  fp(:priv)       {|greet| puts "#{greet} #{@person}"}

  fs(:share)      {|greet| puts "#{greet} #{@person}"}
end
