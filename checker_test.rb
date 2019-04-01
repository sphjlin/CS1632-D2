require_relative 'checker'
require 'minitest/autorun'

# This is the class for unit test that test Checker class
class CheckerTest < Minitest::Test
#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD check_args(args)
  # Equivalence classes:
  # args.count == 3, args[0] is a non-negative integer, args[1] and args[2] are non-negative integers -> PASS, return true
  # args.count == 3, args[0] is a positive integer, args[1] and args[2] are negative integers(greater than 0) -> FAIL, return false
  # args.count == 3, args[0] is a nagative integer, args[1] and args[2] are non-negative integers -> PASS, return true
  def test_check_args_true
    c = Checker.new
    # EDGE CASE
    assert_equal true, c.check_args([0, 1, 1])
    # normal case
    assert_equal true, c.check_args([10, 10_0, 100])
    assert_equal true, c.check_args([-50, 10, 10])
  end

  # args.count != 3
  # or args[0] is not an integer 
  # or args[1] is not a non-negative integer
  # or args[2] is not a non-negative integer
  def test_check_args_false
    c = Checker.new
    assert_equal false, c.check_args([1, 1, 1, 1])
    assert_equal false, c.check_args([1,1])
    assert_equal false, c.check_args(['something', 111])
    assert_equal false, c.check_args([1, -1, 1])
    assert_equal false, c.check_args([1, 1, -1])
  end
end
