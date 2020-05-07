
module API.UniProt.UniProtKB.UniOrganismClass where

import Data.Text

newtype UniOrganismClass = UniOrganismClass [ Text ]
  deriving Show
