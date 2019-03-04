# Location class
# determines movement and number of rubies found as a specific place
class Location
  attr_reader :prng
  def initialize(seed)
    set_prng(seed)
    @move_to = [[1, 2], # Enumerable Canyon
                [0, 4], # Duck Type Beach
                [0, 3, 4], # Monkey Patch City
                [2, 5], # Nil Town
                [1, 2, 5, 6], # Matzburg
                [3, 4, 6], # Hash Crossing
                [4, 5]]# Dynamic Palisades

    @rubies = [[1, 1], 
               [2, 2], 
               [1, 1], 
               [0, 3], 
               [3, 0], 
               [2, 2], 
               [2, 2]]
  end

  def set_prng(seed)
    @prng = Random.new(seed)
  end

  def move(pos)
    @move_to.at(pos).at(@prng.rand(@move_to.at(pos).size))
  end

  # Returns number of rubies found, and real rubies = 0, fake rubies = 1
  def rubies_found(pos)
    rubies = @rubies.at(pos)
    [rubies.at(0).zero? ? 0 : @prng.rand(rubies.at(0)),
     rubies.at(1).zero? ? 0 : @prng.rand(rubies.at(1))]
  end
end
