{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniOrganismHost where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Text
import Prelude as P hiding (String)

-- | Friend Modules
import API.UniProt.UniProtKB

parseOH :: Parser (Maybe UniOrganismHost)
parseOH = do
  string "OH"
  skipSpace
  ohTaxID    <- parseTaxID
  ohHostName <- parseHostName
  return . Just $ UniOrganismHost {..}

parseTaxID :: Parser Int
parseTaxID = do
  string "NCBI_TaxID="
  read <$> many digit <* char ';'

parseHostName :: Parser (Maybe Text)
parseHostName = option Nothing $ do
  skipSpace
  Just . pack <$> manyTill anyChar (char '.')
