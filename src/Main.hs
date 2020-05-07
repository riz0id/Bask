{-# LANGUAGE BlockArguments #-}

module Main where

import Data.Attoparsec.Text
import Data.Text
import Network.Curl
import System.Environment

import API.UniProt.HTTP
import API.UniProt.Parse

main :: IO ()
main = do
  contents <- fetchUniProtKB "B5ZC00"
  protein  <- parseTest parseUniProtKB (pack $ snd contents)

  print protein
