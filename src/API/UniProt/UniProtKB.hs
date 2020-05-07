
module API.UniProt.UniProtKB
  ( module API.UniProt.UniProtKB.UniAccession
  , module API.UniProt.UniProtKB.UniDate
  , module API.UniProt.UniProtKB.UniDescription
  , module API.UniProt.UniProtKB.UniGeneName
  , module API.UniProt.UniProtKB.UniID
  , module API.UniProt.UniProtKB.UniOrganismClass
  , module API.UniProt.UniProtKB.UniOrganismCross
  , module API.UniProt.UniProtKB.UniOrganismSpecies
  , module API.UniProt.UniProtKB.UniOrganismHost

  , UniProtein(..)
  ) where

-- | Friend Modules
import API.UniProt.UniProtKB.UniAccession
import API.UniProt.UniProtKB.UniDate
import API.UniProt.UniProtKB.UniDescription
import API.UniProt.UniProtKB.UniGeneName
import API.UniProt.UniProtKB.UniID
import API.UniProt.UniProtKB.UniOrganismClass
import API.UniProt.UniProtKB.UniOrganismCross
import API.UniProt.UniProtKB.UniOrganismSpecies
import API.UniProt.UniProtKB.UniOrganismHost

data UniProtein = UniProtein
  { uniID              :: UniID
  , uniAcc             :: UniAccession
  , uniDate            :: UniDate
  , uniDesc            :: UniDescription
  , uniGeneNames       :: UniGeneName
  , uniOrganismSpecies :: UniOrganismSpecies
  , uniOrganismClass   :: UniOrganismClass
  , uniOrganismCross   :: UniOrganismCross
  , uniOrganismHost    :: Maybe UniOrganismHost
  }

instance Show UniProtein where
  show protein
     = "UniProtein\n"
    ++ "  { " ++ show (uniID        protein) ++ "\n"
    ++ "  , " ++ show (uniAcc       protein) ++ "\n"
    ++ "  , " ++ show (uniDate      protein) ++ "\n"
    ++ "  , " ++ show (uniDesc      protein) ++ "\n"
    ++ "  , " ++ show (uniGeneNames protein) ++ "\n"
    ++ "  }\n"
    ++ "}"
