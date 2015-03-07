# Euler - Mathematics functions for Haskell.

[![Build Status](https://travis-ci.org/decomputed/euler.svg?branch=master)](https://travis-ci.org/decomputed/euler)

## What is this?

This repo contains functions to help in mathematics calculations or puzzles using Haskell. Currently there is only one module, Primes, which contains implementations of three sieves:

- [Sieve of Erastothenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
- [Sieve of Sundaram](https://en.wikipedia.org/wiki/Sieve_of_Sundaram)
- [Sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin)

The current major version (0) is stable enough to be used for Project Euler problems.

You can also find this package [in Hackage](http://hackage.haskell.org/package/euler).

## How to build?

If you want to build it locally, you'll need GHC and cabal. You'll also need `happy` though you don't need to have it globally. Here's how you can do it:

    git clone https://github.com/decomputed/euler.git
    cd euler
    cabal sandbox init
    cabal install happy
    cabal install --only-dependencies --enable-tests --enable-benchmarks
    cabal build
    cabal test
    cabal bench

Happy hacking!
:-)
