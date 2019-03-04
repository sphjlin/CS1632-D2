# ruby_rush.rb Sophia Lin
require_relative 'simulator.rb'

sim = Simulator.new
sim.parseargs(ARGV) ? sim.run : exit(1)
