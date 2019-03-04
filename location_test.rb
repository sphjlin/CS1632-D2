require 'minitest/autorun'
require_relative 'location'

class LocationTest < Minitest::Test
  #Test
  def test_generator
    location = Location.new(1000)
    location.set_prng(1000)
    assert Random.new(1000) == location.prng
  end

#UNIT TESTS FOR METHOD move(pos)
  #Enumerable Canyon ==> returns 1 or 2
  def test_move_0 
    location = Location.new(1000)
    #assert [1,2].include? location.move(0)
    assert_equal 2, location.move(0)
  end

  # Duck Type Beach ==> returns 0 or 4
  def test_move_1
    location = Location.new(1000)
    #assert [0,4].include? location.move(1)
    assert_equal 4, location.move(1)
  end

  # Monkey Patch City ==> return 0 or 3 or 4
  def test_move_2
    location = Location.new(1000)
    #assert [0,3,4].include? location.move(2)
    assert_equal 0, location.move(2)
  end

  # Nil Town ==> return 2 or 5
  def test_move_3
    location = Location.new(1000)
    #assert [2,5].include? location.move(3)
    assert_equal 5, location.move(3)
  end

 # Matzburg ==> return 1 or 2 or 5 or 6
  def test_move_4
    location = Location.new(1000)
    #assert [1,2,5,6].include? location.move(4)
    assert_equal 6, location.move(4)
  end

  # Hash Crossing ==> return 3 or 4 or 6
  def test_move_5
    location = Location.new(1000)
    #assert [1,2,5,6].include? location.move(5)
    assert_equal 3, location.move(5)
  end

  #Dynamic Palisades ==> return 4 or 5
  def test_move_6
    location = Location.new(1000)
    #assert [5,6].include? location.move(6)
    assert_equal 5, location.move(6)
  end


#UNIT TESTS FOR METHOD rubies_found(pos)
  #Enumerable Canyon ==> returns max [1, 1]
  def test_rubies_found_0 
    location = Location.new(1000)
    assert_equal [0, 0], location.rubies_found(0)
  end

  # Duck Type Beach ==> returns max [2, 2]
  def test_rubies_found_1
    location = Location.new(1000)
    assert_equal [1, 1], location.rubies_found(1)
  end

  # Monkey Patch City ==> rreturns max [1, 1]
  def test_rubies_found_2
    location = Location.new(1000)
    assert_equal [0, 0], location.rubies_found(2)
  end

  # Nil Town ==> returns max [0, 3]
  def test_rubies_found_3
    location = Location.new(1000)
    assert_equal [0, 0], location.rubies_found(3)
  end

 # Matzburg ==> returns max [3, 0]
  def test_rubies_found_4
    location = Location.new(1000)
    assert_equal [0, 0], location.rubies_found(4)
  end

  # Hash Crossing ==> returns max [2, 2]
  def test_rubies_found_5
    location = Location.new(1000)
    assert_equal [1, 1], location.rubies_found(5)
  end

  #Dynamic Palisades ==> returns max [2, 2]
  def test_rubies_found_6
    location = Location.new(1000)
    assert_equal [1, 1], location.rubies_found(6)
  end

 end
