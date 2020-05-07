{-# LANGUAGE RecordWildCards #-}

module API.UniProt.Parse.UniDescription where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Functor
import Data.Text

-- | Friend modules
import API.UniProt.UniProtKB

parseDE :: Parser UniDescription
parseDE = do
  string $ pack "DE"
  skipSpace
  deRecName  <- option Nothing (Just <$> parseRecName)
  string $ pack "DE"
  skipSpace
  deAltNames  <- many1 $ parseAltName
  deAllergens <- pure []
  deBiotech   <- pure []
  deAntigens  <- pure []
  deINNs      <- pure []
  deSubNames  <- pure []

  pure $ UniDescription {..}

parseRecName :: Parser UniDescRecName
parseRecName = do
  string (pack "RecName:")
  skipSpace
  deRecFull  <- parseFullName'
  deRecShort <- parseShortName
  deRecEC    <- parseECNum
  pure $ UniDescRecName {..}

parseAltName :: Parser UniDescAltName
parseAltName = do
  string $ pack "AltName:"
  skipSpace
  deAltFull  <- parseFullName
  deAltShort <- parseShortName
  deAltEC    <- parseECNum
  pure $ UniDescAltName {..}

parseFullName :: Parser (Maybe Text)
parseFullName = option Nothing $ Just <$> parseFullName'

parseFullName' :: Parser Text
parseFullName' = string (pack "Full=") *> parseName <* endOfLine

parseShortName :: Parser (Maybe Text)
parseShortName = option Nothing $ do
  string $ pack "DE"
  skipSpace
  string $ pack "Short="
  (Just <$> parseName) <* endOfLine

parseName :: Parser Text
parseName = pack <$> manyTill anyChar (char ';')

parseECNum :: Parser (Maybe UniECNum)
parseECNum = option Nothing $ do
  string $ pack "DE"
  skipSpace
  string $ pack "EC="
  n1 <- read . unpack <$> AT.takeWhile1 (\c -> isDigit c)
  char '.'
  n2 <- read . unpack <$> AT.takeWhile1 (\c -> isDigit c)
  char '.'
  n3 <- read . unpack <$> AT.takeWhile1 (\c -> isDigit c)
  char '.'
  n4 <- read . unpack <$> AT.takeWhile1 (\c -> isDigit c)
  skipSpace
  pf <- pack          <$> AT.manyTill anyChar (char ';')
  ec <- pure . Just $ UniECNum n1 n2 n3 n4 pf
  pure ec <* endOfLine
