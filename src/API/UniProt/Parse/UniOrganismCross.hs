{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniOrganismCross where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Text
import Prelude as P hiding (String)

-- | Friend Modules
import API.UniProt.UniProtKB

parseOX :: Parser UniOrganismCross
parseOX = do
  string "OX" *> skipSpace
  oxTaxID <- parseTaxID
  pure $ UniOrganismCross {..}

parseTaxID :: Parser Int
parseTaxID = do
  string "NCBI_TaxID="
  read <$> many digit <* char ';'
