{-|
Module      : Primes
Description : Module with functions to calculate Primme Numbers. Implements 3
              sieves.
Copyright   : (c) Luis Rodrigues Soares, 2015
License     : MIT
Maintainer  : luis@decomputed.com
Stability   : experimental
-}

module Numeric.Euler.Primes (
  isPrime,
  trialAndDivision,
  erastothenes,
  sundaram,
  atkin
  ) where

import Data.List (sort)


{-------------------------------------------------
-------------------------------------------------}

{-|
The `isPrime` function checks whether a number `a` is prime by successively
checking the remainder of the integer division with all numbers up to @a-1@.hs
-}
isPrime :: Integral a => a -> Bool
isPrime n
  | n <  2    = False
  | n == 2    = True
  | otherwise = not (any (\i -> n `mod` i == 0) [2..n-1])

{-|
The `trialAndDivision` function calculates prime numbers up to a certain limit
by using the traditional (and very inneficient) trial and division method.
-}
trialAndDivision :: Int -> [Int]
trialAndDivision limit = 2:3:5:[n | n <- [7,9..limit], isPrime n]


{-------------------------------------------------
-------------------------------------------------}

{-|
This is a naïve implementation of the Sieve of Erastothenes.
-}
erastothenes :: Int -> [Int]
erastothenes limit = eSieve [3,5..limit] [2]

eSieve :: [Int] -> [Int] -> [Int]
eSieve [] primes     = primes
eSieve (x:xs) primes = eSieve [y | y <- xs, y `mod` x /= 0] (x:primes)


{-------------------------------------------------
-------------------------------------------------}

initialSundaramSieve :: Int -> [Int]
initialSundaramSieve limit =
  let topi = floor (sqrt (fromIntegral limit / 2) :: Double) in
  [i + j + 2 * i * j | i <- [1..topi],
   j <- [i..floor ((fromIntegral(limit-i) / fromIntegral(2*i+1)) :: Double)]]

{-|
An implementation of the Sieve of Sundaram.
-}
sundaram :: Int -> [Int]
sundaram limit =
  let halfLimit = floor( ((fromIntegral limit / 2)-1) :: Double) in
  2:removeComposites [1..halfLimit] (sort $ initialSundaramSieve halfLimit)

removeComposites :: [Int] -> [Int] -> [Int]
removeComposites [] _ = []
removeComposites (n:ns) [] = (2*n+1) : removeComposites ns []
removeComposites (n:ns) (c:cs)
  | n == c    = removeComposites ns cs
  | n > c     = removeComposites (n:ns) cs
  | otherwise = (2*n+1) : removeComposites ns (c:cs)

{---------------------------------------------------
---------------------------------------------------}


initialAtkinSieve :: Int -> [(Int,Int)]
initialAtkinSieve limit =
  sort $ zip [n
             | n <- [60 * w + x
                    | w <- [0..limit `div` 60],
                      x <- [1,7,11,13,17,19,23,29,31,37,41,43,47,49,53,59]
                    ],
               n <= limit]
  (take limit [0,0..])


aFlip :: (Int,Int) -> (Int,Int)
aFlip (x,y)
  | y == 0        = (x,1)
  | y == 1        = (x,0)
  | otherwise     = error "Needs zero or one"


flipAll :: [Int] -> [(Int, Int)] -> [(Int, Int)]
flipAll _      [] = []
flipAll []     ss = ss
flipAll (f:fs) ((s,b):ss)
  | s < f      = (s,b): flipAll (f:fs) ss
  | s == f     = flipAll fs (aFlip (s,b):ss)
  | otherwise  = flipAll fs ((s,b):ss)


firstStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
firstStep size sieve =
  let topx = floor( sqrt(fromIntegral (size `div` 4)) :: Double)
      topy = floor( sqrt(fromIntegral size) :: Double) in
  flipAll (sort [n | n <- [4*x^(2::Integer) + y^(2::Integer)| x <- [1..topx],
                           y <- [1,3..topy]],
                 n `mod` 60 `elem` [1,13,17,29,37,41,49,53]])
  sieve


secondStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
secondStep size sieve =
  let topx = floor( sqrt(fromIntegral (size `div` 3)) :: Double)
      topy = floor( sqrt(fromIntegral size) :: Double) in
  flipAll (sort [n | n <- [3*x^(2::Integer) + y^(2::Integer) | x <- [1,3..topx],
                           y <- [2,4..topy]],
                 n `mod` 60 `elem` [7,19,31,43]])
  sieve


thirdStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
thirdStep size sieve =
  let topx = floor( sqrt(fromIntegral size) :: Double) in
  flipAll (sort [n | n <- [3*x^(2::Integer) - y^(2 :: Integer) | x <- [1..topx],
                           y <- [(x-1),(x-3)..1]],
                 n `mod` 60 `elem` [11,23,47,59]])
  sieve

unmarkMultiples :: Int -> Int -> [(Int,Int)] -> [(Int,Int)]
unmarkMultiples limit n sieve =
  let nonPrimes = [n,n+n..limit] in
  unmarkAll nonPrimes sieve


unmarkAll :: [Int] -> [(Int,Int)] -> [(Int, Int)]
unmarkAll _        []    = []
unmarkAll []       sieve = sieve
unmarkAll (np:nps) ((s,b):ss)
  | np == s   = unmarkAll nps ss
  | np < s    = unmarkAll nps ((s,b):ss)
  | otherwise = (s,b) : unmarkAll (np:nps) ss


{-|
An implementation of the sieve of Atkin.
-}
atkin :: Int ->  [(Int,Int)]
atkin limit =
  aSieve limit (thirdStep limit .
                secondStep limit .
                firstStep limit $
                initialAtkinSieve limit) [(5,1),(3,1),(2,1)]


aSieve :: Int -> [(Int,Int)] ->[(Int,Int)] -> [(Int,Int)]
aSieve _     []         primes = primes
aSieve limit ((x,b):xs) primes
  | b == 1 = aSieve limit (unmarkMultiples limit (x^(2::Integer)) xs) ((x,b): primes)
  | otherwise = aSieve limit xs primes
