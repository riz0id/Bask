{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniOrganismClass where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Text
import Prelude as P

-- | Friend Modules
import API.UniProt.UniProtKB

parseOC :: Parser UniOrganismClass
parseOC = UniOrganismClass . P.concat <$> many1 parseOCLine

parseOCLine :: Parser [ Text ]
parseOCLine = do
  string $ pack "OC"
  (parseSingleClass `sepBy1` char ';') <* char '.' <* endOfLine

parseSingleClass :: Parser Text
parseSingleClass = do
  skipSpace
  pack <$> many1 letter
