import System.IO
import System.Posix.Unistd

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Util.Run

import qualified Data.Map as M

main = do
  host <- fmap nodeName getSystemID
  dzenLeftBar  <- spawnPipe myXmonadBar
  dzenRightBar <- spawnPipe myStatusBar
  xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
    { terminal   = myTerminal
    , modMask    = mod4Mask
    , workspaces = myWorkspaces
    , keys       = \c -> myKeys c `M.union` keys defaultConfig c
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
    , logHook    = myLogHook dzenLeftBar host
    }

myDzenStyle = "-h 15 -bg '#002b36' -fn '-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso8859-*' -xs 1 -e 'onstart=lower'"
myXmonadBar = "dzen2 -ta l -w 800 -x 0 -y 0 " ++ myDzenStyle
myStatusBar = "killall conky; conky -c ~/.conkyrc | dzen2 -ta r -x 800 -y 0 " ++ myDzenStyle

myTerminal = "urxvtx"
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

myLogHook output host = dynamicLogWithPP $ defaultPP
  { ppOutput  = hPutStrLn output
  , ppTitle   = dzenColor "#859900" "" . shorten 72
  , ppCurrent = dzenColor "yellow" "" . wrap "[" "]"
  , ppVisible = wrap "(" ")"
  , ppUrgent  = dzenColor "red" "yellow"
  , ppOrder   = \(w:l:t:e) -> [" "++w,l,t]
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

