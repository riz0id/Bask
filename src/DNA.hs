{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeApplications      #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE ViewPatterns          #-}
{-# LANGUAGE UndecidableInstances  #-}

module DNA where

import           Data.Array.Accelerate
import           Data.Array.Accelerate.Array.Sugar
import           Data.Array.Accelerate.Product
import           Data.Array.Accelerate.Smart
import           Data.Array.Accelerate.Type
import           Data.Char
import           Data.Function
import qualified Prelude as P

data DNA' a = DNA { getDNA :: a }
  deriving P.Show

type DNA = DNA' Word8

instance P.Num a => P.Bounded (DNA' a) where
  minBound = DNA 0
  maxBound = DNA 3

instance Elt a => Elt (DNA' a) where
  type instance EltRepr (DNA' a) = ((), EltRepr a)
  eltType         = TypeRpair TypeRunit (eltType @a)
  toElt   ((), x) = DNA (toElt x)
  fromElt (DNA a) = ((), fromElt a)

instance Elt a => IsProduct Elt (DNA' a) where
  type ProdRepr (DNA' a) = ((), a)
  toProd   ((), a) = DNA a
  fromProd (DNA a) = ((), a)
  prod             = ProdRsnoc ProdRunit

instance (Lift Exp a, Elt (Plain a)) => Lift Exp (DNA' a) where
  type Plain (DNA' a) = DNA' (Plain a)
  lift (DNA a)        = Exp $ Tuple $ NilTup `SnocTup` lift a

instance Elt a => Unlift Exp (DNA' (Exp a)) where
  unlift t = DNA . Exp $ ZeroTupIdx `Prj` t

instance Eq a => Eq (DNA' a) where
  (==) = lift2 ((==) `on` getDNA)

chr2DNA :: (P.Num a, Elt a) => Char -> P.Either Char (DNA' a)
chr2DNA (toUpper -> c)
  | c P.== 'A' = P.Right $ DNA 0
  | c P.== 'C' = P.Right $ DNA 1
  | c P.== 'G' = P.Right $ DNA 2
  | c P.== 'T' = P.Right $ DNA 3
  | otherwise  = P.Left c
