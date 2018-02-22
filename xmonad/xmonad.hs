import System.IO
import System.Posix.Unistd
import Graphics.X11.ExtraTypes.XF86

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
    { terminal        = myTerminal
    , modMask         = mod4Mask
    , keys            = \c -> myKeys c `M.union` keys defaultConfig c
    , handleEventHook = docksEventHook
    , manageHook      = manageDocks <+> manageHook defaultConfig
    , layoutHook      = avoidStruts $ smartBorders $ layoutHook defaultConfig
    , logHook         = myLogHook dzenLeftBar host
    }

myDzenStyle = "-bg '#090300' -fn '-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso8859-*' -xs 1 -e 'onstart=lower'"
myXmonadBar = "dzen2 -dock -ta l -w 700 -x 0 -y 0 " ++ myDzenStyle
myStatusBar = "killall conky; conky -c ~/.conkyrc | dzen2 -dock -ta r -x 700 -y 0 " ++ myDzenStyle

myTerminal = "urxvtc"

myLogHook output host = dynamicLogWithPP $ defaultPP
  { ppOutput  = hPutStrLn output
  , ppTitle   = dzenColor "#01a252" "" . shorten 72
  , ppCurrent = dzenColor "#fded02" "" . wrap "[" "]"
  , ppVisible = wrap "(" ")"
  , ppUrgent  = dzenColor "#db2d20" "#fded02"
  , ppOrder   = \(w:l:t:e) -> [" "++w,l,t]
  }

myKeys XConfig { modMask = modM } = M.fromList $
  [
  -- Toggle struts (xmobar/dzen2)
    ((modM,               xK_f ), sendMessage ToggleStruts)

  -- Application shortcuts
  , ((modM,               xK_F1), safeSpawn "google-chrome" [])
  , ((modM .|. shiftMask, xK_F1), safeSpawn "google-chrome" ["--incognito"])
  , ((modM,               xK_F2), safeSpawn "firefox" [])
  , ((modM,               xK_F3), safeSpawn "vlc" [])
  , ((modM .|. shiftMask, xK_f ), safeSpawn "thunar" [])

  -- Lock screen.
  , ((modM .|. shiftMask, xK_l ), safeSpawn "slock" [])

  -- Screen capture
  , ((0,    xK_Print), safeSpawn "scrot" [])
  , ((modM, xK_Print), safeSpawn "scrot" ["--select"])

  -- Audio control (assuming pulseaudio)
  , ((0, xF86XK_AudioRaiseVolume), safeSpawn "pactl" ["set-sink-volume", "0", "+5%"])
  , ((0, xF86XK_AudioLowerVolume), safeSpawn "pactl" ["set-sink-volume", "0", "-5%"])
  , ((0, xF86XK_AudioMute       ), safeSpawn "pactl" ["set-sink-mute", "0", "toggle"])
  ]
