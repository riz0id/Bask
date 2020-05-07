

module API.UniProt.UniProtKB.UniDate where

import Data.Text

-- | UniProt Dates
data UniDate = UniDate
  { dtIntegration  :: UniDateStamp
  , dtDatabaseName :: UniDatabases
  , dtSeqVerDate   :: UniDateStamp
  , dtSeqVer       :: Int
  , dtEntryVerDate :: UniDateStamp
  , dtEntryVer     :: Int
  }

instance Show UniDate where
  show udt
     = "DT\n"
    ++ "    { " ++ show (dtIntegration udt)
                ++ ", integrated into UniProtKB/"
                ++ show (dtDatabaseName udt) ++ ".\n"
    ++ "    { " ++ show (dtSeqVerDate udt)
                ++ ", sequence version: "
                ++ show (dtSeqVer udt) ++ ".\n"
    ++ "    { " ++ show (dtEntryVerDate udt)
                ++ ", entry version: "
                ++ show (dtEntryVer udt) ++ ".\n"
    ++ "    }"


-- | A date corresponding to the UniProt format
-- TODO: check in on if this can be made more canoncial through maybe
--       something like the date/time library.
newtype UniDateStamp = UniDateStamp (Int, Text, Int)

instance Show UniDateStamp where
  show (UniDateStamp (d, m, y)) =
    show d ++ "-" ++ unpack m ++ "-" ++ show y


-- | The datebases that entries are avaliable under in UniProt
data UniDatabases
  = SwissProt
  | TrEMBL
  deriving Show
