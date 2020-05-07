
module API.UniProt.UniProtKB.UniOrganismSpecies where

import Data.Text

newtype UniOrganismSpecies = UniOrganismSpecies [ Text ]
  deriving Show
