{-# LANGUAGE AllowAmbiguousTypes #-}

module API.UniProt.Parse.UniProtLine where

import Data.Attoparsec.Text
import Data.Text

class UniProtLine a where
  upLinePrelude :: Text
  upParseLine   :: Parser a
