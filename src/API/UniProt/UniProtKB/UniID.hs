
module API.UniProt.UniProtKB.UniID where

-- | UniProt Protein Identifiers
data UniID = UniID
  { idEntry     :: String
  , idStatus    :: IDStatus
  , idSeqLength :: Int
  }

instance Show UniID where
  show uid
     = "ID\n"
    ++ "    { EntryName:\t" ++ show (idEntry     uid) ++ "\n"
    ++ "    , Status:\t\t"  ++ show (idStatus    uid) ++ "\n"
    ++ "    , Length:\t\t"  ++ show (idSeqLength uid) ++ "\n"
    ++ "    }"

data IDStatus = Reviewed | Unreviewed
  deriving Show
