require_relative 'location'
# location connect class that holds all locations and their relationships#
class LocationRelation
  # This method initializes all of the locations with their appropriate constants
  def initialize
    @locations = {}
  end

  # This method sets the connections for enumerable_canyon according to requirements
  def set_enumerable_canyon
    @enumerable_canyon.add_connection(@duck_type_beach)
    @enumerable_canyon.add_connection(@monkey_patch_city)
  end

  # This method sets the connections for duck_type_beach according to requirements
  def set_duck_type_beach
    @duck_type_beach.add_connection(@enumerable_canyon)
    @duck_type_beach.add_connection(@matzburg)
  end

  # This method sets the connections for monkey_patch_city according to requirements
  def set_monkey_patch_city
    @monkey_patch_city.add_connection(@enumerable_canyon)
    @monkey_patch_city.add_connection(@matzburg)
    @monkey_patch_city.add_connection(@nil_town)
  end

  # This method sets the connections for nil_town according to requirements
  def set_nil_town
    @nil_town.add_connection(@monkey_patch_city)
    @nil_town.add_connection(@hash_crossing)
  end

  # This method sets the connections for matzburg according to requirements
  def set_matzburg
    @matzburg.add_connection(@duck_type_beach)
    @matzburg.add_connection(@monkey_patch_city)
    @matzburg.add_connection(@hash_crossing)
    @matzburg.add_connection(@dynamic_palisades)
  end

  # This method sets the connections for hash_crossing according to requirements
  def set_hash_crossing
    @hash_crossing.add_connection(@matzburg)
    @hash_crossing.add_connection(@nil_town)
    @hash_crossing.add_connection(@dynamic_palisades)
  end

  # This method sets the connections for dynamic_palisades according to requirements
  def set_dynamic_palisades
    @dynamic_palisades.add_connection(@matzburg)
    @dynamic_palisades.add_connection(@hash_crossing)
  end

  # This method hashes a location into the locations hash map
  def add_location(location)
    raise 'Improper typing of location input in method add_location' unless location.is_a? Location

    @locations[location.name_reader] = location
  end

  # This method adds all of the locations to the hash map for easy access
  def hash
    add_location(@enumerable_canyon)
    add_location(@duck_type_beach)
    add_location(@monkey_patch_city)
    add_location(@nil_town)
    add_location(@matzburg)
    add_location(@hash_crossing)
    add_location(@dynamic_palisades)
  end

  # This set the location connections and then calls hash
  def set_connections
    set_enumerable_canyon
    set_duck_type_beach
    set_monkey_patch_city
    set_nil_town
    set_matzburg
    set_hash_crossing
    set_dynamic_palisades
    hash
  end

  # This method creates the new locations and then calls set_connections
  def set_map
    @enumerable_canyon = Location.new('Enumerable Canyon', 1, 1)
    @duck_type_beach = Location.new('Duck Type Beach', 2, 2)
    @monkey_patch_city = Location.new('Monkey Patch City', 1, 1)
    @nil_town = Location.new('Nil Town', 0, 3)
    @matzburg = Location.new('Matzburg', 3, 0)
    @hash_crossing = Location.new('Hash Crossing', 2, 2)
    @dynamic_palisades = Location.new('Dynamic Palisades', 2, 2)
    set_connections
  end

  # This method retreives a location from the hash map
  def get_location(location)
    raise 'Improper typing of location input argument in method get_location' unless location.is_a? String

    if !@locations[location].nil?
      @locations[location]
    else
      0
    end
  end

  def locations_reader
    @locations
  end
end
