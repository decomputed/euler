module Main (main) where

import Data.List (genericLength)
import System.Exit (exitFailure, exitSuccess)
import System.Process (readProcess)
import Text.Regex.Posix

expected :: Fractional a => a
expected = 85

readMatchAsInt :: [String] -> Float
readMatchAsInt list = read (list !! 1) :: Float

coverageOk :: [Float] -> Bool
coverageOk values = (realToFrac (sum values) / genericLength values) > expected
--coverageOk = all (> expected)

main :: IO ()
main = do
  output <- readProcess "cabal" ["haddock"] ""
  let percents = map readMatchAsInt (output =~ "^ *([0-9]*)% " :: [[String]]) in
   if coverageOk percents
       then exitSuccess
       else putStr output >> exitFailure

