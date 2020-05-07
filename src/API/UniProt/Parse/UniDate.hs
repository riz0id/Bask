{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniDate where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Functor
import Data.Text

-- | Friend modules
import API.UniProt.UniProtKB

parseDT :: Parser UniDate
parseDT = do
  string $ pack "DT"
  dtIntegration  <- skipSpace *> parseDateStamp <* char ','
  dtDatabaseName <- skipSpace *> parseDBName    <* char '.' <* endOfLine

  string $ pack "DT"
  dtSeqVerDate   <- skipSpace *> parseDateStamp <* char ','
  dtSeqVer       <- skipSpace *> parseDBSeqVer  <* char '.' <* endOfLine

  string $ pack "DT"
  dtEntryVerDate <- skipSpace *> parseDateStamp <* char ','
  dtEntryVer     <- skipSpace *> parseDBEntVer  <* char '.'
  pure $ UniDate {..}

parseDBName :: Parser UniDatabases
parseDBName = do
  string $ pack "integrated into UniProtKB/"
  let swissprot = string $ pack "Swiss-Prot"
      trembl    = string $ pack "TrEMBL"
  (swissprot $> SwissProt) <|> (trembl $> TrEMBL)

parseDBSeqVer :: Parser Int
parseDBSeqVer = do
  string $ pack "sequence version"
  skipSpace
  read . unpack <$> AT.takeWhile isDigit

parseDBEntVer :: Parser Int
parseDBEntVer = do
  string $ pack "entry version"
  skipSpace
  read . unpack <$> AT.takeWhile isDigit

parseDateStamp :: Parser UniDateStamp
parseDateStamp = do
  day   <- read <$> AT.count 2 (satisfy isDigit)
  char '-'
  month <- pack <$> AT.count 3 (satisfy isAlpha)
  char '-'
  year  <- read <$> AT.count 4 (satisfy isDigit)
  pure $ UniDateStamp (day, month, year)
