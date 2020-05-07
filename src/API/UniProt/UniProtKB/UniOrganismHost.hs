
module API.UniProt.UniProtKB.UniOrganismHost where

import Data.Text

data UniOrganismHost = UniOrganismHost
  { ohTaxID    :: Int
  , ohHostName :: Maybe Text
  } deriving Show
