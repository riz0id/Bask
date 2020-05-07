module API.UniProt.Parse where

import Control.Applicative   (liftA2, (<|>))
import Data.Attoparsec.Text  as AT
import Data.Text

-- | Friend Modules
import API.UniProt.Parse.UniAccession
import API.UniProt.Parse.UniDate
import API.UniProt.Parse.UniDescription
import API.UniProt.Parse.UniGeneName
import API.UniProt.Parse.UniID
import API.UniProt.Parse.UniOrganismClass
import API.UniProt.Parse.UniOrganismCross
import API.UniProt.Parse.UniOrganismSpecies
import API.UniProt.Parse.UniOrganismHost

import API.UniProt.UniProtKB

parseUniProtKB :: Parser UniProtein
parseUniProtKB = UniProtein
  <$> (parseID <* endOfLine)
  <*> parseAC
  <*> (parseDT <* endOfLine)
  <*> parseDE
  <*> parseGN
  <*> parseOS
  <*> parseOC
  <*> (parseOX <* endOfLine)
  <*> (option Nothing $ parseOH <* endOfLine)
