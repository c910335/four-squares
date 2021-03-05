# Four Squares

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

## Contributing

1. Fork it (<https://github.com/c910335/four-squares/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tatsujin Chin](https://github.com/c910335) - creator and maintainer
