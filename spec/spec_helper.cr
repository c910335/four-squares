require "spec"
require "big"
require "../src/four_squares/**"

module Primes
  @@primes : Array(Int32)?
  @@is_prime : Array(Bool)?

  def self.primes
    sieve unless @@primes
    @@primes.not_nil!
  end

  def self.is_prime
    sieve unless @@is_prime
    @@is_prime.not_nil!
  end

  def self.sieve
    @@primes = [2]
    r = 65536
    @@is_prime = [false, false, true] + [true, false] * (r // 2)
    (3..r).each do |i|
      primes << i if is_prime[i]
      primes.each do |p|
        break if p * i > r
        is_prime[p * i] = false
        break if i % p == 0
      end
    end
  end
end

delegate primes, is_prime, to: Primes
