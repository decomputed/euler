module EulerSpec (main, spec) where

import Test.Hspec
import Euler

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  
  describe "isPrime" $ do
    it "works" $ do
      isPrime2 7 `shouldBe` True
--      head [23 ..] `shouldBe` (23 :: Int)

--    it "returns the first element of an *arbitrary* list" $
--    property $ \x xs -> head (x:xs) == (x :: Int)

--    it "throws an exception if used with an empty list" $ do
--    evaluate (head []) `shouldThrow` anyException
