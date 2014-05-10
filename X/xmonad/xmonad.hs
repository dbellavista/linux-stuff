--
--

import XMonad hiding ( (|||) )
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Maximize
import XMonad.Layout.WindowNavigation
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.ComboP
import XMonad.Actions.CopyWindow
import System.Environment (getEnv)
import System.IO.Unsafe
import XMonad.Layout.IndependentScreens

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Stuff path
linuxStuff = unsafePerformIO $ getEnv "STUFF"

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "/usr/bin/terminator"

background = "~/Pictures/wallpaper_gentoo"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#535d6c"

-- Some functions
--

exitFunc :: X ()
exitFunc = do
  runProcessWithInput "/bin/bash" [] ((linuxStuff ++ "/scripts/logout.sh"))
  broadcastMessage ReleaseResources
  io (exitWith ExitSuccess)
  return ()

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    , ((modm              , xK_f), sendMessage $ JumpToLayout "Full")

    , ((modm, xK_backslash), withFocused (sendMessage . maximizeRestore))

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), exitFunc)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    , ((modm .|. controlMask .|. shiftMask, xK_Right), sendMessage $ Move R)
    , ((modm .|. controlMask .|. shiftMask, xK_Left ), sendMessage $ Move L)
    , ((modm .|. controlMask .|. shiftMask, xK_Up   ), sendMessage $ Move U)
    , ((modm .|. controlMask .|. shiftMask, xK_Down ), sendMessage $ Move D)
    , ((modm .|. controlMask .|. shiftMask, xK_s    ), sendMessage $ SwapWindow)

    ----- Applications
    -- Google Chrome
    , ((modm              , xK_g     ), spawn "google-chrome-stable")
    -- Firefox
    , ((modm .|. shiftMask, xK_g     ), spawn "firefox")
    -- VirtualBox
    , ((modm              , xK_v     ), spawn "VirtualBox")
    , ((modm .|. shiftMask, xK_v     ), spawn "wireshark")
    , ((modm              , xK_y     ), spawn "spacefm")
    , ((modm              , xK_x     ), spawn (linuxStuff ++ "/scripts/blank.sh"))
    , ((modm .|. shiftMask, xK_x     ), spawn "i3lock -c 000000 -d")

    ----- Multimedia
    , ((0, xF86XK_AudioMute), spawn (linuxStuff ++ "/scripts/mute_toggle"))
    , ((0, xF86XK_AudioRaiseVolume), spawn (linuxStuff ++ "/scripts/vol_up"))
    , ((0, xF86XK_AudioLowerVolume), spawn (linuxStuff ++ "/scripts/vol_down"))
    , ((0, xF86XK_AudioPlay), spawn (linuxStuff ++ "/scripts/media.sh play"))
    , ((0, xF86XK_AudioNext), spawn (linuxStuff ++ "/scripts/media.sh next"))
    , ((0, xF86XK_AudioPrev), spawn (linuxStuff ++ "/scripts/media.sh prev"))
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Pictures/'")
    , ((controlMask, xK_Print), spawn "scrot -s -e 'mv $f ~/Pictures/'")
    , ((0, 0x1008ffa9), spawn (linuxStuff ++ "/scripts/toggle_touchpad.sh"))

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask) ]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| (Full *||* tiled) ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = maximize $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "mpv"            --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , resource  =? "Dialog"         --> doFloat
    , title     =? "Firefox Preferences" --> doFloat
    , title     =? "Terminator Preferences" --> doFloat
    , isFullscreen --> doFullFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = ewmhDesktopsEventHook <+> fullscreenEventHook
--mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook xmproc =
  dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" "" . shorten 50
        , ppVisible = xmobarColor "red" "" . wrap "(" ")"
        , ppHiddenNoWindows = xmobarColor "#999999" ""
        , ppUrgent = xmobarColor "" "#eaa932"
        }

xmobarScreen1 xmproc =
  dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppTitle = xmobarColor "green" ""
        , ppVisible = xmobarColor "yellow" "" . wrap "(" ")"
        , ppCurrent = xmobarColor "red" "" . wrap "[" "]"
        , ppOrder = \(ws:_:t:_) -> [ws, t]
        , ppHiddenNoWindows = xmobarColor "#999999" ""
        , ppUrgent = xmobarColor "" "#eaa932"
        }

{-nullEventHook = mempty-}
{-coolEventHook = xmobarScreen1(spawnPipe "xmobar -x 1 ~/.xmonad/xmobarrc_x1")-}

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = ewmhDesktopsStartup

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

secondScreenAdjusting = do
  screencount <- countScreens
  if screencount == 1
    then do
      spawn "xrandr --output DP1 --off"
      spawnPipe "/bin/true"
  else do
    spawn "xrandr --output DP1 --auto --right-of LVDS1"
    spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
  xmprocS1 <- secondScreenAdjusting
  spawn (linuxStuff ++ "/scripts/autostart.sh")
  spawn $ "feh --bg-fill " ++ background
  xmonad $ defaultConfig
    {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = smartBorders . avoidStruts $ myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = myEventHook,
        logHook            = ewmhDesktopsLogHook <+> myLogHook(xmproc) <+> xmobarScreen1(xmprocS1),
        startupHook        = myStartupHook
      }
