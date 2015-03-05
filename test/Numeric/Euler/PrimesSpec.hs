module Numeric.Euler.PrimesSpec (
  main,
  spec
  ) where

import Test.Hspec
import Numeric.Euler.Primes
import Test.Hspec.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec =  do
  describe "isPrime, " $
    it "distinguishes between a prime number and a non-prime number" $
      do isPrime (2 :: Integer) `shouldBe` True
         isPrime (7 :: Integer) `shouldBe` True
         isPrime (8 :: Integer) `shouldBe` False

  describe "trialAndDivision, " $
    it "generates 168 prime numbers below 1000" $
      length (trialAndDivision 1000) `shouldBe` 168

  describe "erastothenes sieve, " $
    it "generates 168 prime numbers below 1000" $
      length (erastothenes 1000) `shouldBe` 168

  describe "sundaram sieve, " $ do
    it "generates 168 prime numbers below 1000" $
      length (sundaram 1000) `shouldBe` 168
    it "generates 9592 prime numbers below 100000" $
      length (sundaram 100000) `shouldBe` 9592

  describe "atkin sieve, " $ do
    it "generates 168 prime numbers below 1000" $
      length (atkin 1000) `shouldBe` 168
    it "generates 9592 prime numbers below 100000" $
      length (atkin 100000) `shouldBe` 9592

  describe "All sieves generate prime numbers" $
    modifyMaxSize (const 100000) $
    do
      prop "erastothenes always generates prime numbers" $
        \x -> all isPrime (erastothenes x)
      prop "sundaram always generates prime numbers" $
        \x -> all isPrime (sundaram x)
      prop "atkin always generates prime numbers" $
        \x -> all isPrime (fst. unzip $ atkin x)

