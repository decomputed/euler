module Main (main) where

import Data.List
import System.Exit
import Text.XML.Light
import Data.Maybe
import System.Process

expected :: Fractional a => a
expected = 85

simpleQName :: String -> QName
simpleQName name = QName{qName=name, qURI=Nothing, qPrefix=Nothing}

usefulMetrics :: QName -> Bool
usefulMetrics name = name `elem` [
  simpleQName "exprs",
  simpleQName "booleans",
  simpleQName "alts",
  simpleQName "local",
  simpleQName "toplevel"]

extractValues :: Element -> (String,String)
extractValues element = (
  fromMaybe ("no string"::String) (findAttrBy (\name -> name == simpleQName "boxes") element),
  fromMaybe ("no string"::String) (findAttrBy (\name -> name == simpleQName "count") element))

calculatePercentages :: (String,String) -> Float
calculatePercentages tuple =
  100 *
  (read (snd tuple) :: Float) /
  (read (fst tuple) :: Float)

coverageOk :: [Float] -> Bool
coverageOk values = (realToFrac (sum values) / genericLength values) > (expected :: Double)
--coverageOk = all (> expected)

main :: IO ()
main = do
  s <- readProcess "hpc" ["report", "./spec.tix", "--exclude=Numeric.Euler.PrimesSpec", "--exclude=Main", "--xml-output"] ""
  case parseXMLDoc s of
   Nothing -> error "Failed to parse xml. Try running HPC manually..."
   Just doc -> let elements = filterChildrenName usefulMetrics (head $ elChildren doc)
                   values = map extractValues elements
                   percents = map calculatePercentages values
               in if coverageOk percents
                  then exitSuccess
                  else do
                    output <- readProcess "hpc" ["report", "./spec.tix", "--exclude=Numeric.Euler.PrimesSpec", "--exclude=Main"] ""
                    putStr output >> exitFailure
