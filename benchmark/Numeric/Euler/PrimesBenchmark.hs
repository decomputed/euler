module Numeric.Euler.PrimesBenchmark (
  benchmarks
  ) where

import Criterion
import Numeric.Euler.Primes

benchmarks :: [Benchmark]
benchmarks =
  [ bench "sundaram 10000" $ nf sundaram 10000,
    bench "sundaram 100000" $ nf sundaram 100000,
    bench "sundaram 1000000" $ nf sundaram 1000000,
    bench "atkin 10000" $ nf atkin 10000,
    bench "atkin 100000" $ nf atkin 100000,
    bench "atkin 1000000" $ nf atkin 1000000
  ]
