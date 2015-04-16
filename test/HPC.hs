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

paramsForCabal :: String -> [String]
paramsForCabal tixFile = ["report", tixFile, "--include=Numeric.Euler.Primes"]

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

hpc :: [String] -> IO String
hpc tixFile = readProcess "hpc" (tixFile ++ ["--xml-output"]) ""

readCoverageFrom :: [String] -> IO ()
readCoverageFrom tixFile = do
  stdout <- hpc tixFile
  case parseXMLDoc stdout of 
   Nothing -> error "Failed to parse xml. Try running HPC manually..."
   Just doc -> let elements = filterChildrenName usefulMetrics (head $ elChildren doc)
                   values = map extractValues elements
                   percents = map calculatePercentages values
               in if coverageOk percents
                  then exitSuccess
                  else
                    do
                      humanReadableOutput <- readProcess "hpc" tixFile ""
                      putStrLn ""
                      putStrLn humanReadableOutput
                      exitFailure

main :: IO ()
main = readCoverageFrom (paramsForCabal "./spec.tix")
