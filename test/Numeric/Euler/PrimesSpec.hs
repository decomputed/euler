module Numeric.Euler.PrimesSpec (main, spec) where

import Test.Hspec
import Numeric.Euler.Primes

main :: IO ()
main = hspec spec

spec :: Spec
spec = 
  describe "isPrime" $ 
    it "works" $ do
      isPrime2 (7 :: Integer) `shouldBe` True
      isPrime2 (8 :: Integer) `shouldBe` False

