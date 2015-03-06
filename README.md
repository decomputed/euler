# Euler - Mathematics functions for Haskell.

[![Build Status](https://travis-ci.org/decomputed/euler.svg?branch=master)](https://travis-ci.org/decomputed/euler)

This repo contains functions to help in mathematics calculations or puzzles using Haskell. Currently there is only one module, Primes, which contains implementations of three sieves:

- [Sieve of Erastothenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
- [Sieve of Sundaram](https://en.wikipedia.org/wiki/Sieve_of_Sundaram)
- [Sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin)

The current major version (0) is stable enough to be used for Project Euler problems. You can check usage of it in my [project Euler repository](https://github.com/decomputed/projectEuler).

You can also find this package [in Hackage](http://hackage.haskell.org/package/euler). If you want to build it locally, you'll need GHC, cabal and you should have happy and alex already available in your system. Checkout the code and then:

    cabal sandbox init
    cabal configure --only-dependencies --enable-tests
    cabal build
    cabal test

You can also run the code benchmarks with `cabal bench`.

Happy hacking!
:-)
