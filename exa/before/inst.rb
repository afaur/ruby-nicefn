# Example class with normal fn definitions
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
