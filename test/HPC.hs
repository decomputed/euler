module Main (main) where

import Data.List
import System.Exit
import Text.XML.Light
import Data.Maybe
import System.Process
import System.Directory

expected :: Fractional a => a
expected = 85

simpleQName :: String -> QName
simpleQName name = QName{qName=name, qURI=Nothing, qPrefix=Nothing}

paramsForCabal :: String -> [String]
paramsForCabal tixFile = ["report", tixFile, "--include=Numeric.Euler.Primes"]

paramsForRunAH :: String -> [String]
paramsForRunAH tixFile = ["report", tixFile, "--hpcdir=dist/hpc/mix/spec", "--exclude=Main"]

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

hpc :: [String] -> Bool -> IO (ExitCode, String, String)
hpc tixFile True  = readProcessWithExitCode "hpc" (tixFile ++ ["--xml-output"]) ""
hpc tixFile False = readProcessWithExitCode "hpc" tixFile ""

printProcessOutput :: (ExitCode,String,String) -> IO ()
printProcessOutput (exitCode,stdout,stderr) = do
  putStrLn (show exitCode)
  putStrLn "......................................."
  putStrLn stdout
  putStrLn "......................................."
  putStrLn stderr

readCoverageFrom :: [String] -> IO ()
readCoverageFrom tixFile = do
  (exitCode,stdout,stderr) <- hpc tixFile True
  putStrLn ""
  putStrLn "2 ====== Output from hpc command ======"
  printProcessOutput (exitCode,stdout,stderr)
  putStrLn "======================================="
  putStrLn ""
  case parseXMLDoc stdout of 
   Nothing -> error "Failed to parse xml. Try running HPC manually..."
   Just doc -> let elements = filterChildrenName usefulMetrics (head $ elChildren doc)
                   values = map extractValues elements
                   percents = map calculatePercentages values
               in if coverageOk percents
                  then do
                    putStrLn "3 ====== Coverage was OK. Exiting with success."
                    putStrLn ""
                    exitSuccess
                  else do
                    putStrLn ("3 ====== Coverage was NOT ok:" ++ show ((realToFrac (sum percents) / genericLength percents)::Double))
                    (exitCode2,stdout2,stderr2) <- hpc tixFile False
                    putStrLn "3 ====== Output from hpc command ======"
                    printProcessOutput (exitCode2,stdout2,stderr2)
                    putStrLn "======================================="
                    putStrLn ""
                    exitFailure

fileExists :: String -> IO Bool
fileExists fileName =
  do
    specExists <- doesFileExist fileName
    if specExists
      then
      do
        putStrLn ("1 ====== '" ++ fileName ++ "' EXISTS.")
        return True
      else
      do
        putStrLn ("1 ====== '" ++ fileName ++ "' does NOT exist.")
        return False

main :: IO ()
main =
  do
    putStrLn ""
    exists <- fileExists "./spec.tix"
    if exists
    then readCoverageFrom (paramsForCabal "./spec.tix")
    else 
      do
        exists2 <- fileExists "./dist/hpc/tix/spec/spec.tix"
        if exists2
        then readCoverageFrom (paramsForRunAH "./dist/hpc/tix/spec/spec.tix")
        else putStrLn "1 ====== No file exists." >> exitFailure

