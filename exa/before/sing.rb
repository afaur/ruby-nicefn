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
