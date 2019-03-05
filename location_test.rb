require 'minitest/autorun'
require_relative 'location'

class LocationTest < Minitest::Test
#----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD initialize(name, max_real, max_fake)
  # Equivalence classes:
  # all arguments are of the correct type
    # -> PASS, new location should be initialized with the passed in data
  # non-string value is passed in as a name argument
    # -> FAIL, raise its corresponding error message
  # non-number value is passed in as a max_real arguement
    # -> FAIL, raise its corresponding error message
  # non-number value is passed in as a max_fake argument
    # -> FAIL, raise its corresponding error message

  # If all arguments are of the correct type, then a new location should be
  # initialized with the passed in data
  def test_init
    location = Location.new('init_testing_location_1', 1, 2)
    assert_equal 'init_testing_location_1', location.name_reader
    assert_equal 1, location.max_real_reader
    assert_equal 2, location.max_fake_reader
  end

  # If a non-string value is passed in as a name argument, 
  # then the constructor should raise its corresponding error message
  # EDGE CASE
  def test_init_bad_name_input
    assert_raises 'Error: name input argument in Location' do
      location =  Location.new(2, 1, 2)
    end
  end

  # If a non-number value is passed in as a max_real arguement,
  # then the constructor should raise its corresponding error message
  # EDGE CASE
  def test_init_bad_max_real_input
    assert_raises 'Error: max_real input argument in Location' do
      location =  Location.new('init_location_3', 'one', 2)
    end
  end

  # If a non-number value is passed in as a max_fake argument,
  # then the constructor should raise its corresponding error message
  # EDGE CASE
  def test_init_bad_max_fake_input
    assert_raises 'Error: max_fake input argment in Location' do
      location =  Location.new('init_location_4', 1, 'two')
    end
  end

 #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD add_connection(location)
  # Equivalence classes:
  # add_connection is passsed a valid location object 
    # -> PASS, adds the location to the to the calling location's neighbor list
  # add_connection is passed an invalid location 
    # -> FAIL, method raises an error

  # If a valid location input is passed to add_connection,
  # then the location being input is added to the location
  # where the method was called in it @neighbors
  def test_add_connection
    location = Location.new('connection_location_1', 0, 0)
    location.add_connection Location.new('other_locationA', 1, 1)
    assert_equal 1, location.neighbors_reader.count
  end

  # If an non-Location value is passed in as an input to add_connection,
  # then the method should raise an error message
  # EDGE CASE
  def test_add_connection_bad_input
    assert_raises 'Error: input arguement to method add_connection' do
      location = Location.new('connection_location_2', 0, 0)
      location.add_connection('bad input')
    end
  end

 #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD next_location(random)
  # Equivalence classes:
  # location is a valid location object with an entry in @neighbors 
    # -> PASS, return location to be moved to
  # location is a valid location object with no entries in @neighbors
    # -> FAIL, method raises an error
  # location is a vaild location object but is passed an invalid random arguement
    # -> FAIL, method raises an error

  # If a valid location that has a valid connection,
  # then the method will return a random connected location
  # stubbing of methods
  def test_next_location
    location = Location.new('start_location_1', 0, 0)
    location.add_connection Location.new('next_location_1', 0, 0)
    test_random = Minitest::Mock.new('Random')
    def test_random.rand(max); (max - 1); end
    assert_equal 'next_location_1', location.next_location(test_random).name_reader
  end

  # If a non-random object is passed as an argument,
  # then the method will raise an error message
  def test_next_location_bad_input
    assert_raises 'Error: random input argument.' do
      location = Location.new('start_location_2', 0, 0)
      location.next_location(5)
    end
  end

  # If a valid location calls the next_location method but has no connections,
  # then the method will raise error message
  def test_next_location_no_connections
    assert_raises 'Error: No location connections to current location' do
      location = Location.new('start_location_3', 0, 0)
      test_random = Minitest::Mock.new('Random')
      def test_random.rand; 0; end
      location.next_location(test_random)
    end
  end

 #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD mine_real(random)
  # Equivalence classes:
  # There is a non-zero ammount of fake rubies at a location
    # -> PASS, the method should return an amount of real rubies that is calculated by the Ranom object and the max_real parameter
  # There zero real rubies available at the location
    # -> PASS, return 0

  # If the location has a non-zero ammount of real rubies,
  # then the method should return a random ammount of real rubies between the bounds of 0 and max_real
  # stubbing of methods
  def test_mine_real
    location = Location.new('real_mine_location', 5, 5)
    test_random = Minitest::Mock.new('Random')
    def test_random.rand(max); max - 1; end
    mine = location.mine_real(test_random)
    assert_equal mine, location.max_real_reader
  end

  # If the location has 0 real rubies available, then the method should return 0 real rubies
  # stubbing of methods
  def test_mine_zero_real
    location = Location.new('real_mine_location', 0, 0)
    test_random = Minitest::Mock.new('Random')
    def test_random.rand(max); max - 1; end
    mine = location.mine_real(test_random)
    assert_equal mine, 0
  end

#----------------------------------------------------------------------------
# This one should be easy, if the mine_real(random) passes the tests, this one should have the same result.
  # UNIT TESTS FOR METHOD mine_fake(random)
  # Equivalence classes:
  # There is a non-zero ammount of real rubies at a location
    # -> PASS, the method should return an amount of fake rubies that is calculated by the Ranom object and the max_real parameter
  # There zero fake rubies available at the location
    # -> PASS, return 0

  # If the location has a non-zero ammount of fake rubies,
  # then the method should return a random ammount of fake rubies between the bounds of 0 and max_fake
  # stubbing of methods
  def test_mine_fake
    location = Location.new('fake_mine_location', 5, 5)
    test_random = Minitest::Mock.new('Random')
    def test_random.rand(max); max - 1; end
    mine = location.mine_fake(test_random)
    assert_equal mine, location.max_fake_reader
  end

  # If the location has 0 fake available,
  # then the method should return 0 fake rubies.
  # stubbing of methods
  def test_mine_zero_fake
    location = Location.new('fake_mine_location', 0, 0)
    test_random = Minitest::Mock.new('Random')
    def test_random.rand(max); max - 1; end
    mine = location.mine_fake(test_random)
    assert_equal mine, 0
  end

  #----------------------------------------------------------------------------

  # UNIT TESTS FOR location variable retrievers
  # Equivalence classes:
  # The name, max_real and max_fake of a new location matches the reader methods
  def test_name_reader
    location = Location.new('name_read_testing', 0, 0)
    assert_equal 'name_read_testing', location.name_reader
  end

  def test_max_real_reader
    location = Location.new('max_real_testing', 1, 0)
    assert_equal 1, location.max_real_reader
  end

  def test_max_fake_reader
    location = Location.new('max_fake_testing', 0, 2)
    assert_equal 2, location.max_fake_reader
  end

  def test_neighbors_reader
    location1 = Location.new('neighbors_location', 0, 0)
    location2 = Location.new('other_location', 0, 0)
    location1.add_connection location2
    assert_equal 1, location1.neighbors_reader.count
    assert_equal location2, location1.neighbors_reader[0]
  end
end
