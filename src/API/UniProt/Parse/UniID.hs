{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniID where

import Control.Applicative
import Data.Attoparsec.Text
import Data.Functor
import Data.Text

-- | Friend modules
import API.UniProt.UniProtKB

parseID :: Parser UniID
parseID = do
  idEntry     <- string "ID" *> skipSpace *> parseEntryName
  idStatus    <-                skipSpace *> parseStatus
  idSeqLength <- char ';'    *> skipSpace *> decimal
  skipSpace
    >> string "AA."
    $> UniID {..}

parseEntryName :: Parser String
parseEntryName = many1 (satisfy $ inClass "A-Z0-9_")

parseStatus :: Parser IDStatus
parseStatus = (string "Reviewed" $> Reviewed)
           <|> (string "Unreviewd" $> Unreviewed)
