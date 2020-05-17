Change Log
==========

0.10.1 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2020, May 17th
* Update project to Cabal 3
* Remove performance testing, test coverage, benchmarks, runhaskel support and -Wall

---

0.9.2 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 205, Apr 16th
* Removes logging information.
* Builds with GHC 7.10.

---

0.8.1 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 19th
* Logs more information while running.
* Documentation update.

---

0.8.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 15th
* Adds examples of build scripts that use both `cabal` and `runhaskell`;
* Makes the HPC script more resilient to a build done with `cabal` vs a build done with `runhaskell`;
* Removes dependency on `cabal` for the haddock phase.

---

0.7.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 13th
* Fixes for HPC test-suite.

---

0.6.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 7th
* Makes happy a required build tool;
* Fixes GHC warnings.

---

0.5.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 7th
* Adds `changelog.md`;
* Adds Criterion benchmarks;
* Adds support for travis build.

---

0.4.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 6th
* Adds full documentation to the Primes module;
* Made the default haddock threshold become 100%;
* Brought down the limit for prime number generation during spec test phase;
* Removed temporary files;
* Updated dependencies;
* Changed formatting;
* Made script to run documentation;
* Makes quick check tests run more cases;
* Updated build phases;
* Full test coverage;
* Adds quickcheck tests as well as HPC coverage.

---

0.3.3 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Mar 3rd
* Fixed upper bounds and lower bounds in dependencies;
* Fixed all HLint suggestions;
* Added HLint to the build;
* Fixed all -Wall errors on test phase;
* Fixed all -Wall errors on compilation.

---

0.3.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Feb 24th
* Made -Wall default compilation option
* Added source-repository field to cabal file.

---

0.2.2 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Feb 23rd
* Added a unit test;
* Removed warnings from cabal file; Updated references to dependencies;
* Fixed errors all over the place;
* Removed unused functions; cleaned up indentation.

---

0.1.0 Luis Rodrigues Soares <luis@luisonthekeyboard.com> 2015, Feb 21st
* Added description to package;
* Fixed module references;
* Cabalized the project;
* Initial copy of Problem07.hs, from https://github.com/luisonthekeyboard/projectEuler
