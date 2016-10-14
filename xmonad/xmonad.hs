import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Util.Run
import System.IO

import qualified Data.Map as M

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobar.hs"
  xmonad $ withUrgencyHook NoUrgencyHook myConfig
    { manageHook = manageDocks <+> manageHook myConfig
    , layoutHook = avoidStruts $ smartBorders $ layoutHook myConfig
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "#859900" "" . shorten 72
      }
    }

myConfig = defaultConfig
  { terminal = "urxvtc"
  , modMask = mod4Mask
  , keys = \c -> myKeys c `M.union` keys defaultConfig c
  }

myKeys XConfig { modMask = modM } = M.fromList $
  [
  -- Application shortcuts
    ((modM, xK_F1), safeSpawn "google-chrome" [])
  , ((modM, xK_F2), safeSpawn "firefox" [])

  -- Lock screen.
  , ((modM .|. shiftMask, xK_l), safeSpawn "slock" [])

  -- Toggle struts (xmobar)
  , ((modM, xK_f), sendMessage ToggleStruts)

  -- Screen capture
  , ((modM, xK_Print), safeSpawn "scrot" [])

  -- Audio control
  ]
