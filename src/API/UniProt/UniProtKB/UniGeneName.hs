module API.UniProt.UniProtKB.UniGeneName where

import Data.Text

data UniGeneName = UniGeneName
  { gnName         :: Text
  , gnSynonyms     :: [ Text ]
  , gnOrderedLocus :: [ Text ]
  } deriving Show
