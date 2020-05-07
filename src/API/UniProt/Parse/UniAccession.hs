{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module API.UniProt.Parse.UniAccession where

import Control.Applicative
import Data.Attoparsec.Text as AT
import Data.Char
import Data.Text
import Prelude as P

-- | Friend Modules
import API.UniProt.UniProtKB

parseAC :: Parser UniAccession
parseAC = do
  accNums <- P.concat <$> many1 (parseAccLine <* endOfLine)
  let accPrimary   = P.head accNums
      accSecondary = P.tail accNums
  pure $ UniAccession accPrimary accSecondary

parseAccLine :: Parser [ Text ]
parseAccLine
   = string "AC"
  *> skipSpace
  *> many1 (parseAccNum <* char ';')

-- | Accession Numbers formatting comes in three flavors:
-- |
-- |    1    |   2 |    3    |  4 - 5  |  6  |  7  |   8-9   | 10  |
-- | --------+-----+---------+---------+-----+-----+---------+-----|
-- | A-N,R-Z | 0-9 |   A-Z   | A-Z,0-9 | 0-9 |  -  |    -    |  -  |
-- |  O,P,Q  | 0-9 | A-Z,0-9 | A-Z,0-9 | 0-9 |  -  |    -    |  -  |
-- | A-N,R-Z | 0-9 |   A-Z   | A-Z,0-9 | 0-9 | 0-9 | A-Z,0-9 | 0-9 |
-- |
parseAccNum :: Parser Text
parseAccNum = parseOPQ <|> parsePreANRZ

parseOPQ :: Parser Text
parseOPQ = do
  n1  <- singleton <$> (satisfy $ inClass "OPQ")
  n2  <- singleton <$> (satisfy isDigit)
  n35 <- pack      <$> AT.count 3 (satisfy $ isAlphaNum)
  n6  <- singleton <$> (satisfy isDigit)
  pure $ n1 <> n2 <> n35 <> n6

parseANRZ :: Parser Text
parseANRZ = do
  prefix <- parsePreANRZ
  peek   <- peekChar'
  case peek of
    ';' -> pure prefix
    _   -> do
      postfix <- parsePostANRZ
      pure $ prefix <> postfix

-- FIXME: this sucks
parsePreANRZ :: Parser Text
parsePreANRZ = do
  n1  <- singleton <$> (satisfy $ inClass "A-NR-Z")
  n2  <- singleton <$> satisfy isDigit
  n3  <- singleton <$> satisfy isAlphaNum
  n45 <- pack      <$> AT.count 2 (satisfy isAlphaNum)
  n6  <- singleton <$> satisfy isDigit
  pure $ n1 <> n2 <> n3 <> n45 <> n6

parsePostANRZ :: Parser Text
parsePostANRZ = do
  n7 <- singleton <$> satisfy isDigit
  n8 <- singleton <$> satisfy isAlphaNum
  n9 <- singleton <$> satisfy isDigit
  pure $ n7 <> n8 <> n9
