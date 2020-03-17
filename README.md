# Euler - Mathematics functions for Haskell.

[![Build Status](https://travis-ci.org/luisonthekeyboard/euler.svg?branch=master)](https://travis-ci.org/luisonthekeyboard/euler)

## What is this?

This repo contains functions to help in mathematics calculations or puzzles using Haskell. Currently there is only one module, `Numeric.Euler.Primes`, which contains implementations of three prime number sieves:

- [Sieve of Erastothenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
- [Sieve of Sundaram](https://en.wikipedia.org/wiki/Sieve_of_Sundaram)
- [Sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin)

The current major version (0) is stable enough to be used for Project Euler problems but keep in mind that the sieves are still not optimized at all. I've been mostly busy trying to make a stable build.

You can also find this package [in Hackage](http://hackage.haskell.org/package/euler).

## Dependencies and building

To install the library you just need the latest `base`, so `GHX 7.8` should be more than enough. Just `cabal install euler` from you project or add `euler` as a dependency to your `.cabal` file and you should be good to go.

If you want to build the library locally, you'll need a few more things:

### Building with `cabal`

You'll need:

- `GHC >= 7.8`
- `cabal-install == 1.22.*`
- `happy == 1.19.*` to run `HLint`

`cabal-install` will take care of installing all the other dependencies. `Happy` is an executable so you need to get either to you user space or through you OS package manager. You then build it like this:

    git clone https://github.com/decomputed/euler.git
    cd euler
    cabal sandbox init
    cabal install --only-dependencies --enable-tests --enable-benchmarks --enable-library-coverage
    cabal build
    cabal test
    cabal bench

### Building with `runhaskell`

You'll need:

- `happy == 1.19.*` and `hlint == 1.9.*` to run `HLint`;
- `hspec == 2.1.*` to run the unit tests;
- `xml == 1.3.*` to run the unit test coverage;
- `regex-posix == 0.95.*` to run the documentation coverage;
- `criterion == 1.0.2.*` to run the benchmarks.

You need to get these yourself since building it with `runhaskell` will not get these dependencies for you. As far as I know. You then build it like this:

    runhaskell Setup.hs configure --enable-tests --enable-library-coverage --user
    runhaskell Setup.hs build
    runhaskell Setup.hs test
    runhaskell Setup.hs bench

Happy hacking!
:-)
