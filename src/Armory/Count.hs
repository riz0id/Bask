{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RebindableSyntax    #-}

module Armory.Count where

import           Data.Array.Accelerate
import qualified Data.Array.Accelerate.LLVM.Native as CPU
import           DNA
import qualified Prelude               as P

count :: [ DNA ] -> (Int, Int, Int, Int)
count xs =
  let vec = use $ fromList (Z :. P.length xs) xs
      as = asnd $ filter (\x -> lift (DNA 0) == x) vec
      cs = asnd $ filter (\x -> lift (DNA 1) == x) vec
      gs = asnd $ filter (\x -> lift (DNA 2) == x) vec
      ts = asnd $ filter (\x -> lift (DNA 3) == x) vec
  in P.head . toList $ CPU.run $ zip4 as cs gs ts
