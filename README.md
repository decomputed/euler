# Euler - Mathematics functions for Haskell.

[![Build Status](https://travis-ci.org/luisonthekeyboard/euler.svg?branch=master)](https://travis-ci.org/luisonthekeyboard/euler)

## What is this?

This repo contains functions to help in mathematics calculations or puzzles using Haskell. Currently there is only one module, `Numeric.Euler.Primes`, which contains implementations of three prime number sieves:

- [Sieve of Erastothenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
- [Sieve of Sundaram](https://en.wikipedia.org/wiki/Sieve_of_Sundaram)
- [Sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin)

The current major version (0) is stable enough to be used for _some_ Project Euler problems but keep in mind that the sieves are not optimized at all.

You can also find this package [in Hackage](http://hackage.haskell.org/package/euler).


## Dependencies and building

To install the library you just need the latest `base`. Just `cabal install euler` from you project or add `euler` as a dependency to your `.cabal` file and you should be good to go.

If you want to build the library locally, you'll need a few more things:


### Building with `cabal`

You'll need:

- `GHC >= 8.6`
- `cabal-install >= 3.*`

`cabal` will take care of installing all the other dependencies.

    git clone https://github.com/luisonthekeyboard/euler.git
    cd euler
    cabal build
    cabal test


Happy hacking!
:-)
