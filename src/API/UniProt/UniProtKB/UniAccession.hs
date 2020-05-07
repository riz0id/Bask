
module API.UniProt.UniProtKB.UniAccession where

import Data.Text

-- | UniProt Accession Numbers
data UniAccession = UniAccession
  { acPrimary   :: Text
  , acSecondary :: [ Text ]
  }

instance Show UniAccession where
  show uacc
     = "AC\n"
    ++ "    { Primary:\t\t" ++ show (acPrimary   uacc) ++ "\n"
    ++ "    , Secondary:\t" ++ show (acSecondary uacc) ++ "\n"
    ++ "    }"
