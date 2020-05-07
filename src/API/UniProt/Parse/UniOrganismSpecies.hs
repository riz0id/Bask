{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniOrganismSpecies where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Text
import Prelude as P

-- | Friend Modules
import API.UniProt.UniProtKB

parseOS :: Parser UniOrganismSpecies
parseOS = UniOrganismSpecies <$> many1 parseSingleOS

parseSingleOS :: Parser Text
parseSingleOS = do
  string $ pack "OS"
  skipSpace
  pack <$> manyTill anyChar endOfLine
