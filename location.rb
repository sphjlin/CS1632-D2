# Location class used to store all information about an associated location
class Location
  # Initializes the location class to the passed in parameters
  def initialize(name, max_real, max_fake)
    raise 'Error: name input argument in Location' unless name.is_a? String
    raise 'Error: max_real input argument in Location' unless max_real.is_a? Numeric
    raise 'Error: max_fake input argment in Location' unless max_fake.is_a? Numeric

    @name = name # The name of the location
    @max_real = max_real # The maximum real that can be obtained per iteration
    @max_fake = max_fake # The maximum fake that can be obtained per iteration
    @neighbors = [] # A list of locations that can be gone to with next_location
  end

  # Adds a neighbor to the object's connection list
  def add_connection(location)
    raise 'Error: input arguement to method add_connection' unless location.is_a? Location
    @neighbors << location
  end

  # This method uses that object to select a random connection (which has been set to the entered seed) and return it
  def next_location(random)
    raise 'Error: No location connections to current location' unless @neighbors.count != 0
    rand_position = random.rand(@neighbors.count)
    move_location = @neighbors[rand_position]
    move_location
  end

  # This method returns the name
  def name_reader
    @name
  end

  # This method returns the max_real
  def max_real_reader
    @max_real
  end

  # This method returns the max_fake
  def max_fake_reader
    @max_fake
  end

  # This method returns the neighbors array
  def neighbors_reader
    @neighbors
  end

  # This method will return real ruby mined in a location during one iteration
  def mine_real(random)
    if @max_real.zero?
      0
    else
      real = random.rand(@max_real + 1)
      real
    end
  end

  # This method will return fake ruby mined in a location during one iteration
  def mine_fake(random)
    if @max_fake.zero?
      0
    else
      fake = random.rand(@max_fake + 1)
      fake
    end
  end
end
