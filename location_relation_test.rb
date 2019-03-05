require_relative 'location'
require_relative 'location_relation'
require 'minitest/autorun'


# This class is set up to test location generation as well as their methods
class LocationRelationTest < Minitest::Test
  # This method initializes a new location relation to be tested
  def setup
    @locations = LocationRelation.new
  end

  # This method is used to set the map to the specifications
  # set out in requirements.md
  def initialize_map
    @locations.set_map
  end

  #----------------------------------------------------------------------------
  # This block does not count for total number of unit tests, only makes sure the map is initialized correctly
  # UNIT TESTS FOR METHOD set_enumerable_canyon, set_duck_type_beach......
  # Equivalence classes:
  # These methods set the connections for their own location according to requirements

  # This test tests the initialization of the "Enumerable Canyon" location object
  def test_enumerable_canyon
    initialize_map
    enumerable_canyon = @locations.get_location 'Enumerable Canyon'
    assert_equal 'Enumerable Canyon', enumerable_canyon.name_reader

    assert_equal 1, enumerable_canyon.max_real_reader
    assert_equal 1, enumerable_canyon.max_fake_reader

    assert_equal 'Duck Type Beach', enumerable_canyon.neighbors_reader[0].name_reader
    assert_equal 'Monkey Patch City', enumerable_canyon.neighbors_reader[1].name_reader
  end

  # This test tests the initialization of the "Duck Type Beach" location object
  def test_duck_type_beach
    initialize_map
    duck_type_beach = @locations.get_location 'Duck Type Beach'
    assert_equal 'Duck Type Beach', duck_type_beach.name_reader

    assert_equal 2, duck_type_beach.max_real_reader
    assert_equal 2, duck_type_beach.max_fake_reader

    assert_equal 'Enumerable Canyon', duck_type_beach.neighbors_reader[0].name_reader
    assert_equal 'Matzburg', duck_type_beach.neighbors_reader[1].name_reader
  end

  # This method tests the initialization of the "Monkey Patch City" location object
  def test_monkey_patch_city
    initialize_map
    monkey_patch_city = @locations.get_location 'Monkey Patch City'
    assert_equal 'Monkey Patch City', monkey_patch_city.name_reader

    assert_equal 1, monkey_patch_city.max_real_reader
    assert_equal 1, monkey_patch_city.max_fake_reader

    assert_equal 'Enumerable Canyon', monkey_patch_city.neighbors_reader[0].name_reader
    assert_equal 'Matzburg', monkey_patch_city.neighbors_reader[1].name_reader
    assert_equal 'Nil Town', monkey_patch_city.neighbors_reader[2].name_reader
  end

  # This method tests the initialization of the "Nil Town" location object
  def test_nil_town
    initialize_map
    nil_town = @locations.get_location 'Nil Town'
    assert_equal 'Nil Town', nil_town.name_reader

    assert_equal 0, nil_town.max_real_reader
    assert_equal 3, nil_town.max_fake_reader

    assert_equal 'Monkey Patch City', nil_town.neighbors_reader[0].name_reader
    assert_equal 'Hash Crossing', nil_town.neighbors_reader[1].name_reader
  end

  # This method test the initialization of the "Matzburg" location object
  def test_matzburg
    initialize_map
    matzburg = @locations.get_location 'Matzburg'
    assert_equal 'Matzburg', matzburg.name_reader

    assert_equal 3, matzburg.max_real_reader
    assert_equal 0, matzburg.max_fake_reader
    
    assert_equal 'Duck Type Beach', matzburg.neighbors_reader[0].name_reader
    assert_equal 'Monkey Patch City', matzburg.neighbors_reader[1].name_reader
    assert_equal 'Hash Crossing', matzburg.neighbors_reader[2].name_reader
    assert_equal 'Dynamic Palisades', matzburg.neighbors_reader[3].name_reader
  end

  # This method tests the initialization of the "Hash Crossing" location object
  def test_hash_crossing
    initialize_map
    hash_crossing = @locations.get_location 'Hash Crossing'
    assert_equal 'Hash Crossing', hash_crossing.name_reader

    assert_equal 2, hash_crossing.max_real_reader
    assert_equal 2, hash_crossing.max_fake_reader

    assert_equal 'Matzburg', hash_crossing.neighbors_reader[0].name_reader
    assert_equal 'Nil Town', hash_crossing.neighbors_reader[1].name_reader
    assert_equal 'Dynamic Palisades', hash_crossing.neighbors_reader[2].name_reader
  end

  # This method tests the initialization of the "Dynamic Palisades" location object
  def test_dynamic_palisades
    initialize_map
    dynamic_palisades = @locations.get_location 'Dynamic Palisades'
    assert_equal 'Dynamic Palisades', dynamic_palisades.name_reader

    assert_equal 2, dynamic_palisades.max_real_reader
    assert_equal 2, dynamic_palisades.max_fake_reader

    assert_equal 'Matzburg', dynamic_palisades.neighbors_reader[0].name_reader
    assert_equal 'Hash Crossing', dynamic_palisades.neighbors_reader[1].name_reader
  end


  #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD add_location(location)
  # Equivalence classes:
  # @locations starts empty
    # -> returns 1
  # @locations starts with at least one location in the hash map
    # -> returns intial @locations.locations.count value +1
  # Bad input entered to the add_location method
    # -> raise error message

  # If @locations starts empty, then adding a location by the add_location() method will
  # make the assertion @locations.locations.count return 1
  def test_add_location_to_empty
    locations = LocationRelation.new
    locations.add_location Location.new('add_location', 0, 0)
    assert_equal 1, locations.locations_reader.count
  end

  # If @locations starts with at least one location object in its hash map,
  # then adding a location by the add_location method will cause the assertion @locations.locations.count
  # to return one more than the value it previously returned
  def test_add_location_to_populated
    locations = LocationRelation.new
    locations.add_location Location.new('mocked location 1', 0, 0)
    inital_val = locations.locations_reader.count
    locations.add_location Location.new('mocked location 2', 0, 0)
    assert_equal (inital_val + 1), locations.locations_reader.count
  end

  # If bad input is passed into the add_location method, then raise an error message
  # EDGE CASE
  def test_add_location_bad_input
    assert_raises 'Improper typing of location input in method add_location' do
      locations = LocationRelation.new
      locations.add_location Location.new('test_location_1')
    end
  end

 
  #----------------------------------------------------------------------------
  # UNIT TESTS FOR METHOD get_location(location)
  # Equivalence classes:
  # @locations contains requested location -> returns requested location object
  # @locations does not contain requested location -> returns 0
  # nonstring input entered as argument -> raises error

  # If @locations contains the requested location, then return requested location
  def test_get_location_contains
    locations = LocationRelation.new
    locations.add_location Location.new('test_location_2', 0, 0)
    assert_equal 'test_location_2', locations.get_location('test_location_2').name_reader
  end

  # If @locations codes not contain the requested location, then return 0
  def test_get_location_doesnt_contain
    locations = LocationRelation.new
    assert_equal 0, locations.get_location('test_location_3')
  end

  # If the input to the get_location method is a non string, then throw an error
  # EDGE CASE
  def test_get_location_bad_input
    assert_raises 'Improper typing of location input argument in method get_location' do
      locations = LocationRelation.new
      locations.get_location 55
    end
  end
end
