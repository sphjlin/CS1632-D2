require_relative 'location'
require_relative 'location_relation'

# This is the class for Rubyist
class Rubyist
  # Initialization of Rubyist
  # Create a Rubyist with 0 real and 0 fake, start at Enumerable Canyon
  def initialize(location_relation)
    raise 'Improper typing of input' unless location_relation.is_a? LocationRelation

    @real_mined = 0 # number of real rubies the Rubyist mined already
    @fake_mined = 0 # number of fake rubies the Rubyist mined already
    @current_location = location_relation.get_location('Enumerable Canyon') # the location is the Rubyist currently at
    @days = 0 # number of days this Rubyist totally spend.
  end

  # Actual moviment for the Rubyist
  # In each location, it will check whether the Rubyist leaves location.
  # If the Rubyist leave the location, head him to the next location.
  # The method end when the Rubyist visit number-of-turns cities (include repeated location)
  def mine(number, ran, number_of_turns)
    start_message(number, @current_location) # Display the staring message
    (1..number_of_turns).each do |i| # repeat number of turns
      loop do # Mining until leaving cities
        temp_real = @current_location.mine_real(ran) # Get real rubies mined in current location
        temp_fake = @current_location.mine_fake(ran) # Get fake rubies mined in current location
        set_rubies(temp_real, temp_fake) # Add mined rubies in hand
        mining_message(temp_real, temp_fake, @current_location) # Display message for how many rubies are found
        @days += 1 # Spend a day, so increase the time he spending
        break if leave?(i, temp_real, temp_fake) # He is in the condition to leave the location.
      end
      if i != number_of_turns
        prev_location = @current_location
        @current_location = @current_location.next_location(ran) # Head him to the next location
        leaving_location_message(prev_location.name_reader, @current_location.name_reader, @real_mined, @fake_mined)
      end
    end
    end_message(number, @days, @real_mined, @fake_mined) # Display the ending message
  end

  def leaving_location_message(prev_location, move_location, real, fake)
    raise 'Improper typing of input' unless prev_location.is_a? String
    raise 'Improper typing of input' unless move_location.is_a? String
    raise 'Improper typing of input' unless real.is_a? Integer
    raise 'Improper typing of input' unless fake.is_a? Integer
    raise 'Negative integer' unless real >= 0 && fake >= 0

    puts "Heading from #{prev_location} to #{move_location}.\n"
    1
  end

  # Method that checks whether the Rubyists leave the cities
  def leave?(iteration, real, fake)
    raise 'Not an integer' unless iteration.is_a? Integer
    raise 'Not an integer' unless real.is_a? Integer
    raise 'Not an integer' unless fake.is_a? Integer
    raise 'Negative integer' unless iteration >= 0 && real >= 0 && fake >= 0

    return true if real.zero? && fake.zero? 
    false
  end

  # Simply add real and fake to the Rubyist's hand
  def set_rubies(real, fake)
    raise 'Not an integer' unless real.is_a? Integer
    raise 'Not an integer' unless fake.is_a? Integer
    raise 'Negative integer' unless real >= 0 && fake >= 0

    @real_mined += real
    @fake_mined += fake
  end

  # Simply display the message for mining
  def mining_message(real, fake, current_location)
    raise 'Not an integer' unless real.is_a? Integer
    raise 'Not an integer' unless fake.is_a? Integer
    raise 'Not an location' unless current_location.is_a? Location
    raise 'Negative integer' unless real >= 0 && fake >= 0

    # Message display [real, fake] is [0, 0]
    if real.zero? && fake.zero? 
      puts "\tFound no rubies or fake rubies in #{current_location.name_reader}."
    # Message display [real, fake] is [0, 1]
    elsif real.zero? && fake == 1
      puts "\tFound 1 fake ruby in #{current_location.name_reader}."
    # Message display [real, fake] is [1, 0]
    elsif real == 1 && fake.zero?
      puts "\tFound 1 ruby in #{current_location.name_reader}."
    # Message display [real, fake] is [1, 1]
    elsif real == 1 && fake == 1
      puts "\tFound 1 ruby and 1 fake ruby in #{current_location.name_reader}."
    # Message display [real, fake] is [0, n](n is a integer bigger than one)
    elsif real.zero? && fake > 1
      puts "\tFound #{fake} fake rubies in #{current_location.name_reader}."
    # Message display [real, fake] is [1, n](n is a integer bigger than one)
    elsif real == 1 && fake > 1
      puts "\tFound 1 ruby and #{fake} fake rubies in #{current_location.name_reader}."
    # Message display [real, fake] is [n, 0] (n is a integer bigger than one)
    elsif real > 1 && fake.zero?
      puts "\tFound #{real} rubies in #{current_location.name_reader}."
    # Message display [real, fake] is [n, 1] (n is a integer bigger than one)
    elsif real > 1 && fake == 1
      puts "\tFound #{real} rubies and 1 fake ruby in #{current_location.name_reader}."
    # Message display [real, fake] is [n, m](n and m are integers bigger than one)
    elsif real > 0 && fake > 0
      puts "\tFound #{real} rubies and #{fake} fake rubies in #{current_location.name_reader}."
    end
  end

  # Simply display the message when starting mining
  # Message for the Rubyist start at certain cities
  def start_message(number, current_location)
    raise 'Not an integer' unless number.is_a? Integer
    raise 'Not an location' unless current_location.is_a? Location
    raise 'Not a valid integer' unless number > 0

    puts "Rubyist ##{number} starting in #{current_location.name_reader}."
  end

  # Simply display the message when finish mining
  def end_message(number, days, real, fake)
    raise 'Not an integer' unless real.is_a? Integer
    raise 'Not an integer' unless fake.is_a? Integer
    raise 'Not an integer' unless days.is_a? Integer
    raise 'Not an integer' unless number.is_a? Integer
    raise 'Not an integer' unless real >= 0 && fake >= 0 && number >= 0 && days >= 0

    # Ending message to display which Rubyist return with how many real/fake
    puts "After #{days} days, Rubyist ##{number} found:"
    puts "\t#{real} rubies." # How many real rubies the Rubyist got
    puts "\t#{fake} fake rubies." # How many fake rubies the Rubyist got
    if real >= 10
      puts "Going home victorious!\n" 
    elsif real >= 1 && real <= 9
      puts "Going home sad.\n" 
    else
      puts "Going home empty-handed.\n"
    end
  end


  # These three class is use for outside class call the variables
  # Return real_mined
  def real_mined_reader
    @real_mined
  end

  # Return days
  def days_reader
    @days
  end

  # Return fake_mined
  def fake_mined_reader
    @fake_mined
  end

  # Return current_location
  def current_location_reader
    @current_location
  end
end
