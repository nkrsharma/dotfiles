import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ withUrgencyHook NoUrgencyHook myConfig
    { manageHook = manageDocks <+> manageHook myConfig
    , layoutHook = avoidStruts $ smartBorders $ layoutHook myConfig
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    }

myConfig = defaultConfig
  { terminal = "urxvtc"
  , modMask = mod4Mask
  }
