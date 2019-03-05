require_relative 'rubyist'
require 'minitest/autorun'

# This is the class for unit test that test Rubyist class
class RubyistTest < Minitest::Test
#----------------------------------------------------------------------------
  # Test for initialization
  # If all arguments are of the correct typed
  # check whether the initialization works properly

  # check the fakeMined set properly
  def test_fake_mined
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.fake_mined_reader
  end

  # check the realMined set properly
  def test_real_mined
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.real_mined_reader
  end

  # check the days set properly
  def test_days
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.days_reader
  end

  # check the currentLocation set properly
  def test_location
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert p.current_location_reader.is_a? Location
    assert_equal 'Enumerable Canyon', p.current_location_reader.name_reader
  end

  # check if the agument has wrong type will it raises a exception
  def test_init_arg
    assert_raises RuntimeError do
      Rubyist.new 123
    end
  end

#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD leave?(iteration, real, fake)
  # Equivalence classes:
  # any of (iteration, real, fake) is negative
    # -> FAIL, raise an exception
 
  #   if real == 0 and fake == 0 return true
  #   else return false

  # This unit test checks what happens set x,y,z not a integer
  # It should raise an exception
  # EDGE CASE
  def test_leave_edge
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.leave?('haha', 'haha', 'haha')
    end
  end

  # If one of (iteration, real, fake) is negative then a exception raises
  def test_leave_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.leave?(-5, 3, 2)
    end
  end

  # both real and fake is 0
  def test_leave_zero
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal true, p.leave?(10, 0, 0)
  end

#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD set_rubies(x,y)
  # Equivalence classes:
  # x and y = -INFINITY..-1 -> raise an exception
  # x and yis non-negative ingeter -> add fake and real to Rubyist's

  # This unit test checks what happens when setting x,y a non-integer
  # It should raise an exception if x, y is not an integer
  # EDGE CASE
  def test_set_rubies_noninteger
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.set_rubies('haha', 2)
    end
  end

  # This unit test checks what happens set x,y negative integer
  def test_set_rubies_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises do
      p.set_rubies(-1, -2)
    end
  end

  # This unit test checks does the method set the x and y to the p correctly
  def test_set_rubies_positive
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    p.set_rubies(1, 1)
    assert_equal 1, p.fake_mined_reader
    assert_equal 1, p.real_mined_reader
  end

  # This unit test checks does the method set the x and y test whether it handle 0
  def test_set_rubies_zero
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    p.set_rubies(0, 0)
    assert_equal 0, p.fake_mined_reader
    assert_equal 0, p.real_mined_reader
  end

#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD mining_message(x,y,z)
  # Equivalence classes:
  # x and y are not correct type
    # -> raise an exception
  # x = 0 and y = 0
    # -> Found no rubies or fake rubies in Enumerable Canyon.
  # x = 1 and y = 1
    # -> Found 1 ruby and 1 fake ruby in Enumerable Canyon.
  # x = 2 and y = 2
    # -> Found 2 rubies and 2 fake rubies in Enumerable Canyon.
  # This unit test checks does the method rasie the exception while x and y is not integer
  def test_mining_message_noninteger
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.mining_message('haha', 2, p.current_location_reader)
    end
  end

  # This unit test checks does the method rasie the exception while z is not location type
  def test_mining_message_not_location
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.mining_message(1, 1, 2)
    end
  end

  # This unit test checks does the method rasie the exception while x/y is negative integer
  def test_mining_message_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.mining_message(-1, 2, p.current_location_reader)
    end
  end

  # x stands for real ruby, and y stands for fake ruby
  # This unit test checks doest the method print the correct message when x = 0 and y = 0
  # EDGE CASE
  def test_mining_message_00
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound no rubies or fake rubies in Enumerable Canyon.\n") { p.mining_message(0, 0, p.current_location_reader) }
  end

    # This unit test checks doest the method print the correct message when x = 0 and y = 1
    # EDGE CASE
  def test_mining_message_01
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 1 fake ruby in Enumerable Canyon.\n") { p.mining_message(0, 1, p.current_location_reader) }
  end

    # This unit test checks doest the method print the correct message when x = 1 and y = 0
    # EDGE CASE
  def test_mining_message_10
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 1 ruby in Enumerable Canyon.\n") { p.mining_message(1, 0, p.current_location_reader) }
  end

    # This unit test checks doest the method print the correct message when x = 1 and y = 1
    # EDGE CASE
  def test_mining_message_11
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 1 ruby and 1 fake ruby in Enumerable Canyon.\n") { p.mining_message(1, 1, p.current_location_reader) }
  end

    # This unit test checks doest the method print the correct message when x = 0 and y > 1
    # EDGE CASE
  def test_mining_message_0n
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 2 fake rubies in Enumerable Canyon.\n") { p.mining_message(0, 2, p.current_location_reader) }
  end

  # This unit test checks doest the method print the correct message when x = 1 and y > 1
  # EDGE CASE
  def test_mining_message_1n
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 1 ruby and 2 fake rubies in Enumerable Canyon.\n") { p.mining_message(1, 2, p.current_location_reader) }
  end

  # This unit test checks doest the method print the correct message when x > 1 and y = 0
  # EDGE CASE
  def test_mining_message_n0
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 2 rubies in Enumerable Canyon.\n") { p.mining_message(2, 0, p.current_location_reader) }
  end

    # This unit test checks doest the method print the correct message when x > 1 and y = 1
    # EDGE CASE
  def test_mining_message_n1
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 2 rubies and 1 fake ruby in Enumerable Canyon.\n") { p.mining_message(2, 1, p.current_location_reader) }
  end

  # This unit test checks doest the method print the correct message when x > 1 and y > 1
  # EDGE CASE
  def test_mining_message_nm
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("\tFound 2 rubies and 2 fake rubies in Enumerable Canyon.\n") { p.mining_message(2, 2, p.current_location_reader) }
  end

  #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD start_message(x,y)
  # Equivalence classes:
  # x and y are not correct type
  # x < 1 -> raise a exception
  # x > 1 -> print "Rubyist #x starting in y"

  # This unit test checks does the method rasie the exception while x  is not integer
  def test_start_message_noninteger
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.start_message('haha', p.current_location_reader)
    end
  end

  # This unit test checks does the method rasie the exception while y is not location type
  def test_start_message_not_location
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.start_message(1, 2)
    end
  end

  # This unit test checks does the method rasie the exception while x < 1
  def test_start_message_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.start_message(0, p.current_location_reader)
    end
  end

  # This unit test checks does the method print correct method when x > 1
  def test_start_message_positive
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("Rubyist #1 starting in Enumerable Canyon.\n") { p.start_message(1, p.current_location_reader) }
  end


#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD leaving_location_message(x, y, m, n)
  # Equivalence classes:
  # x and y should be a string type and m and n should be an integer
  # x, y, m, n are not correct type  
    # -> raise exception
  # m < 0 or n < 0 
    # -> raise exception
  # x >= 0 and y >= 0 -> print the correct output

  # This unit test checks does the method rasie the exception while x,y,m,n does not have correct type
  def test_leaving_location_input_type
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.leaving_location_message(1, 1, 1, 1)
    end
  end

  # This unit test checks does the method rasie the exception while x,y,m,n does not have correct type
  def test_leaving_location_input_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.leaving_location_message('location1', 'location2', -1, 1)
    end
  end

  # This unit test checks does the method print the correct output when the input is correct
  # This unit have is too long when runing rubocop
  def test_leaving_location_output
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("Heading from location1 to location2.\n") { p.leaving_location_message('location1', 'location2', 1, 1) } # line is too long
    assert_output("Heading from location2 to location3.\n") { p.leaving_location_message('location2', 'location3', 2, 3) } # line is too long
  end

  #----------------------------------------------------------------------------
  # UNIT TESTS FOR SET OF ACCESSOR
  # It simply return the variable for Rubyist class

  # Check whether the method return the correct value for fake_mined
  def test_fake_mined_accessor
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.fake_mined_reader
    p.set_rubies(1, 1)
    assert_equal 1, p.fake_mined_reader
  end

  # Check whether the method return the correct value for real_mined
  def test_real_mined_accessor
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.real_mined_reader
    p.set_rubies(1, 1)
    assert_equal 1, p.real_mined_reader
  end

  # Check whether the method return the correct value for days
  def test_days_accessor
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_equal 0, p.days_reader
  end

  # Check whether the method return the correct value for days
  def test_current_location_accessor
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert p.current_location_reader.is_a?(Location)
    assert_equal 'Enumerable Canyon', p.current_location_reader.name_reader
  end

#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD leaving_location_message(x, y, z, m,)
  # Equivalence classes:
  # x/y/z/m should be an integer and m should be float:
  # x, y, z, m are not correct type  -> FAIL, raise exception
  # any of x/y/z/m are negative -> FAIL, raise exception
  # x/y/z/m are all positive and corect type -> PASS, print out information

  # This unit test checks does the method rasie the exception while x,y,z,m does not have correct type
  def test_end_message_wrong_type
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.end_message('string', 1, 1, 1)
    end
  end

  # This unit test checks does the method rasie the exception while x,y,z,m are negative
  def test_end_message_negative
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_raises RuntimeError do
      p.end_message(-1, -1, -1, -1)
    end
  end

  # This unit test checks does the method print the correct output when the input is correct
  # This unit have is too long when runing rubocop
  def test_end_message
    locations = LocationRelation.new
    locations.set_map
    p = Rubyist.new locations
    assert_output("After 2 days, Rubyist #1 found:\n\t3 rubies.\n\t4 fake rubies.\nGoing home sad.\n") { p.end_message(1, 2, 3, 4) } # line is too long
  end
end
