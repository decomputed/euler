module Main (main) where

import Criterion.Main (bgroup, defaultMain)
import Numeric.Euler.PrimesBenchmark

main :: IO ()
main = defaultMain
       [ bgroup "Primes" benchmarks
       ]
