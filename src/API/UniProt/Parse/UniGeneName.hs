{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniGeneName where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Text
import Prelude as P hiding (String)

-- | Friend Modules
import API.UniProt.UniProtKB

parseGN :: Parser UniGeneName
parseGN = do
  string "GN"
  skipSpace
  gnName         <- parseName
  gnSynonyms     <- option [] parseSynonyms
  skipSpace
  gnOrderedLocus <- option [] parseOrderedLocus
  endOfLine
  pure $ UniGeneName {..}

parseName :: Parser Text
parseName = do
  string "Name="
  pack <$> manyTill anyChar (char ';')

parseSynonyms :: Parser [ Text ]
parseSynonyms = do
  string "Synonyms="
  parseListOfNames

parseOrderedLocus :: Parser [ Text ]
parseOrderedLocus = do
  string "OrderedLocusNames="
  parseListOfNames

parseListOfNames :: Parser [ Text ]
parseListOfNames = parseSingleName `sepBy1` char ','

parseSingleName :: Parser Text
parseSingleName = pack <$> manyTill anyChar (char ';' <|> char ',')
