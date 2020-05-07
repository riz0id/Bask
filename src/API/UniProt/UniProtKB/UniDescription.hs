
module API.UniProt.UniProtKB.UniDescription where

import Data.Text

-- | UniProt Descriptions
-- FIXME: this datastructure is vague in regards to what the
--        specification actually demands.
data UniDescription = UniDescription
  { deRecName   :: Maybe UniDescRecName
  , deAltNames  :: [ UniDescAltName     ]
  , deAllergens :: [ UniDescAltAllergen ]
  , deBiotech   :: [ UniDescAltBiotech  ]
  , deAntigens  :: [ UniDescAltAntigen  ]
  , deINNs      :: [ UniDescAltINN      ]
  , deSubNames  :: [ UniDescSubName     ]
  }

instance Show UniDescription where
  show udesc
     = "DE\n"
    ++ "    {" ++ show (deRecName   udesc)
    ++ "    ," ++ show (deAltNames  udesc)
    ++ show (deAllergens udesc)
    ++ show (deBiotech   udesc)
    ++ show (deAntigens  udesc)
    ++ show (deINNs      udesc)
    ++ show (deSubNames  udesc)
    ++ "}"


-- | Recommended names provided by UniProt.
-- | NOTE: Recommended names are conditionally provided by TrEMBL
data UniDescRecName = UniDescRecName
  { deRecFull  :: Text
  , deRecShort :: Maybe Text
  , deRecEC    :: Maybe UniECNum
  }

instance Show UniDescRecName where
  show (UniDescRecName full short ec)
     = "RecName: Full=" ++ show full  ++ "\n"
    ++ "          " ++ show short ++ "\n"
    ++ "          " ++ show ec    ++ "\n"


-- | Alternate names provided for the protein.
data UniDescAltName = UniDescAltName
  { deAltFull  :: Maybe Text
  , deAltShort :: Maybe Text
  , deAltEC    :: Maybe UniECNum
  }

instance Show UniDescAltName where
  show (UniDescAltName full short ec)
     = "AltName: " ++ show full  ++ "\n"
    ++ "         " ++ show short ++ "\n"
    ++ "         " ++ show ec    ++ "\n"


-- | Alternate nomenclature for Allergens.
newtype UniDescAltAllergen = UniDescAltAllergen Text

instance Show UniDescAltAllergen where
  show (UniDescAltAllergen name)
    = "AltName: Allergen:" ++ show name


-- | Alternate nomenclature for biotechnological context.
newtype UniDescAltBiotech = UniDescAltBiotech Text

instance Show UniDescAltBiotech where
  show (UniDescAltBiotech name)
    = "AltName: Biotech:" ++ show name


-- | Alternate nomenclature for human cell differentiation antigens.
newtype UniDescAltAntigen = UniDescAltAntigen Text

instance Show UniDescAltAntigen where
  show (UniDescAltAntigen name)
    = "AltName: CD_antigen:" ++ show name


-- | The international nonproprietary name: A generic name
-- | for a pharmaceutical substance or active pharmaceutical
-- | ingredient that is globally recognized and is a public
-- | property.
newtype UniDescAltINN = UniDescAltINN Text

instance Show UniDescAltINN where
  show (UniDescAltINN name)
    = "AltName: INN: " ++ show name


-- | Name provided by the submitter of the underlying
-- | nucleotide sequence.
data UniDescSubName = UniDescSubName
  { deSubFull :: Text
  , deSubEC   :: Maybe UniECNum
  }

instance Show UniDescSubName where
  show (UniDescSubName full ec)
     = "SubName: " ++ show full  ++ "\n"
    ++ "         " ++ show ec    ++ "\n"


-- | Enzyme Commission number
data UniECNum = UniECNum Int Int Int Int Text

instance Show UniECNum where
  show (UniECNum n1 n2 n3 n4 postfix)
    = "EC=" ++ show n1 ++ "." ++ show n2 ++ "."
            ++ show n3 ++ "." ++ show n4
            ++ " " ++ show postfix ++ "\n"
