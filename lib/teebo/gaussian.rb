module Teebo
  #
  # A basic implementation of the Box-Muller transform. Adapted from an answer by antonakos on
  # Stack Overflow here: http://stackoverflow.com/questions/5825680
  #
  class Gaussian
    def initialize(mean, stddev, rand_helper = lambda { Kernel.rand })
      @rand_helper = rand_helper
      @mean = mean
      @stddev = stddev
      @valid = false
      @next = 0
    end

    def rand
      if @valid
        @valid = false
        @next
      else
        @valid = true
        x, y = self.class.gaussian(@mean, @stddev, @rand_helper)
        @next = y
        x
      end
    end

    private
    def self.gaussian(mean, stddev, rand)
      theta = 2 * Math::PI * rand.call
      rho = Math.sqrt(-2 * Math.log(1 - rand.call))
      scale = stddev * rho
      x = mean + scale * Math.cos(theta)
      y = mean + scale * Math.sin(theta)
      return x, y
    end
  end
end