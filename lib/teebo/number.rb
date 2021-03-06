module Teebo
  #
  # Helper for generating  numbers according to various distributions.
  #
  class Number
    #
    # Generates a number using a normal distribution.
    #
    # A basic implementation of the Box-Muller transform. Adapted from an answer by antonakos on
    # Stack Overflow here: http://stackoverflow.com/questions/5825680
    #
    def self.normal_dist(mean, std_deviation, rand = lambda { Kernel.rand })
      theta = 2 * Math::PI * rand.call
      rho = Math.sqrt(-2 * Math.log(1 - rand.call))
      scale = std_deviation * rho
      mean + scale * Math.cos(theta)
    end

    #
    # Generates a number according to Benford's law, meaning that it is more indicative of numbers
    # encountered in real life.
    #
    def self.benford_dist(upper_bound, decimals=0)
      multiplier = Math.log(upper_bound)
      Math.exp(Random.rand * multiplier).round(decimals)
    end

  end
end