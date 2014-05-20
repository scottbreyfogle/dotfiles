import System.IO
import System.Exit
import qualified Data.Map as Map

import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.CycleWS

import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicLog (dynamicLogXinerama, xmobar)
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W

import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.ZoomRow

main = do
    xmonad =<< xmobar defaultConfig
        { borderWidth = 2
        , normalBorderColor = borderColor
        , focusedBorderColor = focusBorderColor
        , manageHook = myManageHook <+> manageDocks
        , layoutHook = myLayout
        , workspaces = spaces
        , keys = myKeys
        , startupHook = startup
        , logHook = dynamicLogWithPP $ xmobarPP
            { ppTitle = xmobarColor "green" "" . shorten 50
            , ppHiddenNoWindows = xmobarColor "grey" ""
            }
        }

borderColor = "#073642"
focusBorderColor = "#657b83"

myLayout = ( tiled ||| largeMaster ||| simpleTabbed ||| zoomRow ||| Mirror tiled )
    where
        tiled = spacing 2 $ Tall numMaster standardDelta standardRatio
        largeMaster = spacing 2 $ Tall numMaster standardDelta largeRatio
        numMaster = 1
        standardRatio = 1/2
        largeRatio = 2/3
        standardDelta = 3/100

spaces = ["1:web","2:proj1","3:proj2","4:proj3","5:misc","6:personal","7:code1","8:code2","9:code3","0:conf"]

myManageHook = composeAll
    [ -- stringProperty "WM_WINDOW_ROLE" =? "pop-up" --> doShift "3:chat"
--   , className =? "Gnome-player" --> doFloat
--   , className =? "Iron" --> doShift "8:web"
--   , className =? "Xchat" --> doShift "2:chat"
    ]

sMod = mod1Mask .|. shiftMask
cMod = mod1Mask .|. controlMask

myKeys conf@(XConfig {XMonad.modMask = modm}) = Map.fromList $
    [ ((modm, xK_x), kill)
    , ((modm, xK_n), refresh)
    , ((modm, xK_t), withFocused $ windows . W.sink)
    , ((modm, xK_space), sendMessage NextLayout)
    , ((sMod, xK_space), setLayout $ XMonad.layoutHook conf)
    , ((sMod, xK_r), spawn reload)
    , ((modm, xK_r), spawn dmenu)
    , ((modm, xK_q), spawn lock)
    , ((sMod, xK_q), logout)
    ]
    ++

    -- Volume
    [ ((0, 0x1008FF11), spawn lowerVolume)
    , ((0, 0x1008FF13), spawn raiseVolume)
    , ((0, 0x1008FF12), spawn toggleMute)
    ]
    ++

    -- Applications
    [ ((modm, xK_c), spawn browser)
    , ((modm, xK_Return), spawn term)
    , ((sMod, xK_Return), spawn tmux)
    ]
    ++

    -- Multiscreen support
    [ ((cMod, xK_j), onPrevNeighbour W.view)
    , ((cMod, xK_k), onNextNeighbour W.view)
    , ((mod1Mask .|. shiftMask .|. controlMask, xK_j), swapPrevScreen)
    , ((mod1Mask .|. shiftMask .|. controlMask, xK_k), swapNextScreen)
    ]
    ++

    -- Moving focus
    [ ((modm, xK_k), windows W.focusUp)
    , ((modm, xK_j), windows W.focusDown)
    , ((sMod, xK_k), windows W.swapUp)
    , ((sMod, xK_j), windows W.swapDown)
    ]
    ++

    -- Master area
    [ ((modm, xK_h), sendMessage Shrink)
    , ((modm, xK_l), sendMessage Expand)
    , ((modm, xK_comma), sendMessage (IncMasterN 1))
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    ]
    ++

    -- ZoomRow
    [ ((modm, xK_minus), sendMessage $ Zoom (4/5))
    , ((modm, xK_equal), sendMessage $ Zoom (5/4))
    , ((modm, xK_0), sendMessage $ zoomReset)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

term = "gnome-terminal"
tmux = "gnome-terminal --window-with-profile=tmux"
dmenu =  "exe=`dmenu_run -b -nb black -nf yellow -sf yellow` && eval \"exec $exe\""
reload = "xmonad --recompile && xmonad --restart"
lock = "gnome-screensaver-command -l"
logout = io (exitWith ExitSuccess)
browser = "google-chrome"

lowerVolume = "amixer set Master 2-"
raiseVolume = "amixer set Master 2+"
toggleMute  = "amixer -D pulse set Master toggle"

startup = do
    spawn "source ~/.xinitrc"
