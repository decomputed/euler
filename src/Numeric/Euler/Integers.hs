module Numeric.Euler.Integers
    ( multiple
    , multipleOf
    ) where


multiple :: Int -> Int -> Bool
multiple number factor = (number `mod` factor) == 0

multipleOf :: Int -> [Int] -> Bool
multipleOf number factors = any (multiple number) factors
