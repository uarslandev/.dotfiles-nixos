import Colors.Nord
import Graphics.X11.Xinerama
import Graphics.X11.Xlib
import Graphics.X11.Xrandr
import System.Process (callCommand)
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.SpawnOnce (spawnOnce)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

main :: IO ()
main = do
    n <- countScreens
    xmprocs <- mapM (\i -> spawnPipe $ "xmobar /home/user/.xmobarrc" ++ " -x " ++ show i) [0..n-1]
    xmonad $ ewmhFullscreen . ewmh $  xmobarProp $ def
        { modMask            = mod4Mask
        , terminal           = "kitty"
        , manageHook = myManageHook <+> manageHook def
        , borderWidth        = 1
        , focusFollowsMouse  = True
        , normalBorderColor  = "#282c34"
        , workspaces         = myWorkspaces
        , focusedBorderColor = "#61afef"
        , startupHook        = myStartupHook >> setWMName "LG3D"
        , layoutHook         = myLayout
        } `additionalKeysP` myKeys

myStartupHook = do
    spawnOnce "keepassxc"
    spawnOnce "flameshot"
    spawnOnce "nm-applet"
    spawnOnce "copyq"
    spawn "feh --bg-fill ~/.config/bg.jpg"
    spawn "picom"
    spawn "killall trayer"
    spawn ("sleep 2 &&  trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22")

myLayout = toggleLayouts Full $ spacing 10 $ tiled ||| threeCol ||| threeColMid
  where
    tiled       = Tall 1 (2/100) (1/2)       -- Definition of 'tiled'
    threeCol    = ThreeCol 1 (3/100) (1/2)    -- Definition of 'threeCol'
    threeColMid = ThreeColMid 1 (3/100) (1/2) -- Definition of 'threeColMid'

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset
myWorkspaces = [" dev ", " www ", " prod ", " gfx ", " chat ", " anki ", " idk1 ", " idk2 ", " idk3 "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

myManageHook :: ManageHook
myManageHook = composeAll
    [ -- Floating rules first
      className =? "notification"    --> doFloat 
    , className =? "file_progress"   --> doFloat
    , className =? "steamwebhelper"  --> doFloat
    , title =? "Steam Settings"      --> doFloat
    , title =? "Friends List"        --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , className =? "Yad"             --> doCenterFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
    , isFullscreen --> doFullFloat
    , className =? "Alacritty"   --> doShift (myWorkspaces !! 0)  -- www
    , className =? "Brave-browser"   --> doShift (myWorkspaces !! 1)  -- www
    , className =? "Code"   --> doShift (myWorkspaces !! 0)  -- www
    , className =? "Firefox"   --> doShift (myWorkspaces !! 1)  -- www
    , className =? "Gimp" --> doF (W.shift " gfx ") <+> doFloat
    , className =? "anki"             --> doShift (myWorkspaces !! 6)  -- vid
    , className =? "discord"             --> doShift (myWorkspaces !! 4)  -- vid
    , className =? "element"             --> doShift (myWorkspaces !! 4)  -- vid
    , className =? "gimp"             --> doShift (myWorkspaces !! 3)  -- vid
    , className =? "kitty"   --> doShift (myWorkspaces !! 0)  -- www
    , className =? "mpv"             --> doShift (myWorkspaces !! 6)  -- vid
    , className =? "notion"   --> doShift (myWorkspaces !! 2)
    , className =? "resolve"             --> doShift (myWorkspaces !! 3)  -- vid
    , className =? "thunderbird"             --> doShift (myWorkspaces !! 4)  -- vid
    , className =? "vesktop"             --> doShift (myWorkspaces !! 4)  -- vid
    , className =? "obsidian"             --> doShift (myWorkspaces !! 2)  -- vid
    , className =? "Google-chrome" <&&> title ~? "Google Chrome" --> doShift (myWorkspaces !! 1)
    , title =? "Notion - Dashboard"             --> doShift (myWorkspaces !! 4)  -- vid
    , title =? "Notion"             --> doShift (myWorkspaces !! 2)  -- vid
    , title =? "Notion Calendar"             --> doShift (myWorkspaces !! 2)  -- vid
    -- Move to Workspace
    ]

myKeys =
    [ ("M-S-<Return>", spawn "kitty")
    , ("M-<Space>", sendMessage NextLayout)       -- Mod+Space → Next layout
    , ("M-S-<Space>", sendMessage FirstLayout)
    , ("M-d", spawn "rofi -show drun -show-icons")
    , ("M-S-p", spawn "thunar")
    , ("M-S-o", spawn "keepassxc")
    , ("M-S-;", spawn "copyq show")
    , ("M-S-i", spawn "pavucontrol")
    , ("M-S-s", spawn "flameshot gui")
    , ("M-S-l", spawn "lock")
    , ("M-S-c", kill)  -- Close focused window
    , ("M-b", sendMessage ToggleStruts)
    , ("M-f", sendMessage (Toggle "Full"))
    , ("M-q", spawn "xmonad --recompile; pkill xmobar; pkill trayer; xmonad --restart")
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
    , ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    , ("<XF86AudioMicMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 5%+")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPause>", spawn "playerctl play-pause")
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    ]

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
