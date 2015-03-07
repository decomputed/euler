module Main (main) where

import Data.List
import System.Exit
import System.Process
import Text.Regex.Posix

expected :: Fractional a => a
expected = 100

readMatchAsInt :: [String] -> Float
readMatchAsInt list = read (list !! 1) :: Float

coverageOk :: [Float] -> Bool
coverageOk values = (realToFrac (sum values) / genericLength values) >= (expected :: Double)
--coverageOk = all (> expected)

main :: IO ()
main = do
  output <- readProcess "cabal" ["haddock"] ""
  let percents = map readMatchAsInt (output =~ "^ *([0-9]*)% " :: [[String]]) in
   if coverageOk percents
   then exitSuccess
   else putStr output >> exitFailure

