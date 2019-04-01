require_relative 'rubyist.rb'
require_relative 'checker.rb'

# Verify that the arguments are valid
c = Checker.new
valid_args = c.check_args ARGV

# if the argument valid
# call each Rubyist mine with a pseudo random
if valid_args
  #c.set_args ARGV
  ran = Random.new(Integer(ARGV[0]))
  locations = LocationRelation.new
  locations.set_map
  (1..Integer(ARGV[1])).each do |i|
    p = Rubyist.new(locations)
    p.mine(i, ran, Integer(ARGV[2]))
  end
else
  c.show_usage_and_exit
end
