require "big"
require "./four_squares/**"

module FourSquares
  VERSION = "0.1.0"

  def self.roots(num : String)
    Roots.new(num).to_s?
  end

  def self.run
    while num = gets
      if rs = roots(num)
        puts "#{rs} = #{num}"
      else
        puts "#{num} is not a prime."
      end
    end
  end
end

FourSquares.run
