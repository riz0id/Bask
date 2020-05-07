{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_multiple_alignment (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/riz/.cabal/bin"
libdir     = "/home/riz/.cabal/lib/x86_64-linux-ghc-8.8.3/multiple-alignment-0.1.0.0-inplace-multiple-alignment"
dynlibdir  = "/home/riz/.cabal/lib/x86_64-linux-ghc-8.8.3"
datadir    = "/home/riz/.cabal/share/x86_64-linux-ghc-8.8.3/multiple-alignment-0.1.0.0"
libexecdir = "/home/riz/.cabal/libexec/x86_64-linux-ghc-8.8.3/multiple-alignment-0.1.0.0"
sysconfdir = "/home/riz/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "multiple_alignment_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "multiple_alignment_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "multiple_alignment_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "multiple_alignment_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "multiple_alignment_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "multiple_alignment_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
