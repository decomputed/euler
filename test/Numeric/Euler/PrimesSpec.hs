module Numeric.Euler.PrimesSpec (main, spec) where

import Test.Hspec
import Numeric.Euler.Primes

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "isPrime" $ do
    it "works" $ do
      isPrime2 (7 :: Integer) `shouldBe` True
