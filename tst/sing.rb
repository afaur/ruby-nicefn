# Tests check examples before `Nicefn::Sing` is added and after.
class TestSingleton < Test::Unit::TestCase
  def setup
    @person = 'John'
    @expected_stdout = "hello #{@person_one}\n"
  end

  # Make sure all instance methods work and output correctly
  def test_inst_valid
    assert_block('Error testing singleton public methods') do
      # Assignable since person is marked as attr_writer
      Sing.person = @person_one

      # Will work since method is public
      Sing.test_priv 'hello'

      # If no exceptions were raised then tests pass
      true
    end

    # Ensure program printed correct output to stdout
    assert($stdout.string == @expected_stdout, 'Incorrect program output')
  end

  # Make sure private and protected methods throw when accessed incorrectly
  def test_inst_invalid
    # Will not work since priv was marked as private
    assert_raise { Sing.priv 'hello' }
  end
end
