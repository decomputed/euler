module Numeric.Euler.IntegersSpec (
  main,
  spec
  ) where

import Test.Hspec
import Numeric.Euler.Integers
import Test.Hspec.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec =  do
  describe "multiple, " $
    it "is true if a number is a multiple of another" $
      do multiple 14 7 `shouldBe` True
