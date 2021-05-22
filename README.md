# Four Squares

[![Crystal CI](https://github.com/c910335/four-squares/actions/workflows/crystal.yml/badge.svg)](https://github.com/c910335/four-squares/actions/workflows/crystal.yml)

A deterministic polynomial-time algorithm for finding a representation of a prime as a sum of four squares

## Installation

1. Clone this repository.

```
$ git clone https://github.com/c910335/four-squares
$ cd four-squares
```

2. Compile it.

```
$ shards build --release --no-debug
```

## Usage

Run and enter some primes.

```
$ bin/four_squares
1
1 is not a prime.
2
1^2 + 1^2 + 0^2 + 0^2 = 2
65539
233^2 + 75^2 + 75^2 + 0^2 = 65539
2147483647
33135^2 + 31941^2 + 4310^2 + 3279^2 = 2147483647
170141183460469231731687303715884105727
9485443033339641291^2 + 7911815779561688934^2 + 4104118515834236449^2 + 852605535991260783^2 = 170141183460469231731687303715884105727
```

## Algorithm

The algorithm is from [Sums of Four Squares](https://sites.math.rutgers.edu/~bumby/squares1.pdf).

1. Given a prime P, define P - 1 = Q2<sup>S</sup> with Q odd; define the level of a number n to be the smallest k that satisfies n<sup>2<sup>k</sup>Q</sup> ≡ 1 (mod P).
2. Find the first element whose level is not 1 in the following sequence.
    - c<sub>0</sub> = P - 1
    - c<sub>i</sub> = c<sub>i-1</sub> / 2 if c<sub>i-1</sub> is even.
    - c<sub>i</sub> = c<sub>i-1</sub> - 1 if c<sub>i-1</sub> is odd.
3. Let c<sub>j</sub> be the first element whose level is not 1:
    - If the level of c<sub>j</sub> is greater than 1, then P - 1 is a [quadratic residue](https://en.wikipedia.org/wiki/Quadratic_residue) modulo P, and its square root x satisfies x<sup>2</sup> + 1 = kP for some k.
    - If the level of c<sub>j</sub> is 0, then both c<sub>j</sub> and P - c<sub>j-1</sub> are [quadratic residues](https://en.wikipedia.org/wiki/Quadratic_residue) modulo P, and their square roots x and y satisfy x<sup>2</sup> + y<sup>2</sup> + x<sup>2</sup>(or 1 if c<sub>j-1</sub> is odd) = kP for some k.
4. Find the square roots x, y, z that satisfy the equation x<sup>2</sup> + y<sup>2</sup> + z<sup>2</sup> = kP in the previous step by the [Tonelli–Shanks algorithm](https://en.wikipedia.org/wiki/Tonelli%E2%80%93Shanks_algorithm).
5. Find the gcd (a + bi + cj + dk) of the two [Hurwitz integers](https://en.wikipedia.org/wiki/Hurwitz_quaternion) (x + yi + zj) and P by the [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm).
    - If their gcd is not a [Lipschitz integer](https://en.wikipedia.org/wiki/Hurwitz_quaternion), left multiply it by (e<sub>1</sub> - e<sub>2</sub>i - e<sub>3</sub>j - e<sub>4</sub>k) / 2, where e<sub>1</sub> ≡ a * 2, e<sub>2</sub> ≡ b * 2, e<sub>3</sub> ≡ c * 2, e<sub>4</sub> ≡ d * 2 (mod 4), and e<sub>1</sub>, e<sub>2</sub>, e<sub>3</sub>, e<sub>4</sub> ∈ {±1}.
6. Output a<sup>2</sup> + b<sup>2</sup> + c<sup>2</sup> + d<sup>2</sup> = P.

## Primality Test

If the input number is not a prime, the algorithm fails with high probability and thus we can know that it is a composite number.  
However, it is known that a lot of composite numbers pass this test.  
Here are some examples.

```
51^2 + 26^2 + 0^2 + 0^2 = 3277   # 29 * 113
63^2 + 8^2 + 0^2 + 0^2 = 4033    # 37 * 109
49^2 + 40^2 + 28^2 + 26^2 = 5461 # 43 * 127
65^2 + 64^2 + 0^2 + 0^2 = 8321   # 53 * 157
171^2 + 10^2 + 0^2 + 0^2 = 29341 # 13 * 37 * 61
210^2 + 71^2 + 0^2 + 0^2 = 49141 # 157 * 313
255^2 + 16^2 + 0^2 + 0^2 = 65281 # 97 * 673
```

## Contributing

1. Fork it (<https://github.com/c910335/four-squares/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tatsujin Chin](https://github.com/c910335) - creator and maintainer
