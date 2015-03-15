module Main ( main ) where

import Distribution.Simple
--import Distribution.Simple.Program

main = defaultMain

{-
main = defaultMainWithHooks simpleUserHooks { hookedPrograms = [cabal] }

cabal :: Program
cabal = (simpleProgram "cabal") {
  programFindVersion = findProgramVersion "--numeric-version" id
}
-}
