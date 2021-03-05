require "./spec_helper"

describe FourSquares do
  it "represents a prime as the sum of four squares" do
    65536.times do |i|
      if is_prime[i]
        FourSquares::Roots.new(i).@roots.should be_truthy
      end
    end
  end
end
