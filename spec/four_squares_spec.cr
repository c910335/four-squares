require "./spec_helper"

describe FourSquares do
  it "represents a prime as the sum of four squares" do
    primes.each do |p|
      FourSquares::Roots.new(p).to_s?.should be_truthy
    end
  end
end
