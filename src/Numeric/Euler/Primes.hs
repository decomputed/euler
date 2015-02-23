module Numeric.Euler.Primes (
  isPrime2,
  trialAndDivision2
  ) where

import Data.List (sort)


{-------------------------------------------------
-------------------------------------------------}


isPrime2 :: Integral a => a -> Bool
isPrime2 n
  | n == 2    = True
  | otherwise = not (any (\i -> n `mod` i == 0) [3..n-1])

trialAndDivision2 limit = 2:3:5:[n | n <- [7,9..limit], isPrime2 n]


{-------------------------------------------------
-------------------------------------------------}


erastothenes3 limit = eSieve3 [3,5..limit] [2]

eSieve3 [] primes     = primes
eSieve3 (x:xs) primes = eSieve3 ([y | y <- xs, y `mod` x /= 0]) (x:primes)


{-------------------------------------------------
-------------------------------------------------}

initialSundaramSieve :: Int -> [Int]
initialSundaramSieve limit =
  let topi = floor (sqrt ((fromIntegral limit) / 2)) in
  [i + j + 2 * i * j | i <- [1..topi],
   j <- [i..floor((fromIntegral(limit-i)) / fromIntegral(2*i+1))]]

sundaram5 limit =
  let halfLimit = floor((limit / 2)-1) in
  2:removeComposites ([1..halfLimit]) (sort $ initialSundaramSieve halfLimit) 

removeComposites [] _ = []
removeComposites (n:ns) [] = (2*n+1) : (removeComposites ns [])
removeComposites (n:ns) (c:cs)
  | n == c    = removeComposites ns cs
  | n > c     = removeComposites (n:ns) cs
  | otherwise = (2*n+1) : (removeComposites ns (c:cs))

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
aFlip (x,1) = (x,0)
aFlip (x,0) = (x,1)


flipAll :: [Int] -> [(Int, Int)] -> [(Int, Int)]
flipAll _      [] = []
flipAll []     ss = ss
flipAll (f:fs) ((s,b):ss)
  | s < f      = (s,b): (flipAll (f:fs) ss)
  | s == f     = flipAll fs ((aFlip (s,b)):ss)
  | otherwise  = flipAll fs ((s,b):ss)


firstStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
firstStep size sieve =
  let topx = floor(sqrt(fromIntegral (size `div` 4)))
      topy = floor(sqrt(fromIntegral size)) in
  flipAll (sort [n | n <- [4*x^2 + y^2| x <- [1..topx],
                           y <- [1,3..topy]],
                 n `mod` 60 `elem` [1,13,17,29,37,41,49,53]])
  sieve


secondStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
secondStep size sieve =
  let topx = floor(sqrt(fromIntegral (size `div` 3)))
      topy = floor(sqrt(fromIntegral size)) in
  flipAll (sort [n | n <- [3*x^2 + y^2 | x <- [1,3..topx],
                           y <- [2,4..topy]],
                 n `mod` 60 `elem` [7,19,31,43]])
  sieve


thirdStep :: Int ->  [(Int,Int)] ->  [(Int,Int)]
thirdStep size sieve =
  let topx = floor(sqrt(fromIntegral size)) in
  flipAll (sort [n | n <- [3*x^2 - y^2 | x <- [1..topx],
                           y <- [(x-1),(x-3)..1],
                           x > y],
                 n `mod` 60 `elem` [11,23,47,59]])
  sieve


unmarkMultiples limit n sieve =
  let nonPrimes = [y | y <-[n,n+n..limit]] in
  unmarkAll nonPrimes sieve


unmarkAll _        []    = []
unmarkAll []       sieve = sieve
unmarkAll (np:nps) ((s,b):ss) 
  | np == s   = unmarkAll nps ss
  | np < s    = unmarkAll nps ((s,b):ss)
  | otherwise = (s,b) : (unmarkAll (np:nps) ss)


atkin1 :: Int ->  [(Int,Int)]
atkin1 limit =
  aSieve1 limit ((thirdStep limit) . (secondStep limit) . (firstStep limit) $ initialAtkinSieve limit) [(5,1),(3,1),(2,1)]


aSieve1 _     []         primes = primes
aSieve1 limit ((x,b):xs) primes
  | b == 1 = aSieve1 limit (unmarkMultiples limit (x^2) xs) ((x,b): primes)
  | otherwise = aSieve1 limit xs primes
