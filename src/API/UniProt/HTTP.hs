
module API.UniProt.HTTP where

import Network.Curl

fetchUniProtKB :: String -> IO (CurlCode, String)
fetchUniProtKB proteinID = do
  let url = "https://www.uniprot.org/uniprot/" ++ proteinID ++ ".txt"
  curlGetString url []
