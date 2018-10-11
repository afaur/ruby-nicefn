class TestInstance < Test::Unit::TestCase
  def setup
    @person_one = "John"
    @person_two = "Jack"
    @expected_stdout = "hello #{@person_one}\nhello #{@person_two}\n"
  end

  # Make sure all instance methods work and output correctly
  def test_inst_valid
    assert_block("Error testing instance public methods") do
      # Create two new instances of Inst class
      inst_one, inst_two = [Inst.new, Inst.new]

      # Assignable since person is marked as attr_writer
      inst_one.person = @person_one
      inst_two.person = @person_two

      # Will work since method is public
      inst_one.test_priv "hello"

      # Will work since method is public
      inst_one.test_share "hello", inst_two

      # If no exceptions were raised then tests pass
      true
    end

    # Ensure program printed correct output to stdout
    assert($stdout.string === @expected_stdout, "Incorrect program output")
  end

  # Make sure private and protected methods throw when accessed incorrectly
  def test_inst_invalid
    # Will not work since priv was marked as private
    assert_raise { inst_one.priv "hello" }

    # Will not work since share was marked as protected
    assert_raise { inst_one.share "hello" }
  end
end
