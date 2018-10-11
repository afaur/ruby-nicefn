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
