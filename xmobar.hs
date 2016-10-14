Config {
    -- Appearance
      font = "-*-terminus-medium-r-normal-*-12-*-*-*-*-*-iso8859-*"
    , bgColor = "#002b36"
    , fgColor = "#93a1a1"
    , position = TopSize L 100 14
    , border = BottomB
    , borderColor = "#002b36"
    , allDesktops = False
    , overrideRedirect = True
    , pickBroadest = False
    , hideOnStart = False
    , lowerOnStart = True
    , persistent = True

    -- Layout
    , sepChar = "%"
    , alignSep = "}{"
    , template = " <fc=#cb4b16>%uname%</fc> - %StdinReader% } { %cpu% %coretemp% | %memory% | %dynnetwork% | %diskio% | %battery% | <fc=#cb4b16>%date%</fc>"

    , commands =
        [ Run StdinReader

        , Run Com "uname" [ "-n" ] "" 0

        , Run Date "%a %b %_d %H:%M:%S %Z" "date" 10

        , Run Cpu         [ "-t", "Cpu:<system>% <user>% <total>%"
                          , "-L", "15"
                          , "-H", "60"
                          , "--low",    "#859900"
                          , "--normal", "#b58900"
                          , "--high",   "#dc322f"
                          , "--width", "3"
                          ] 20

        , Run CoreTemp    [ "-t", "<core0>C"
                          , "-L", "45"
                          , "-H", "65"
                          , "--low",    "#859900"
                          , "--normal", "#b58900"
                          , "--high",   "#dc322f"
                          , "--width", "3"
                          ] 50

        , Run Memory      [ "-t", "Mem: <usedratio>%"
                          , "-L", "35"
                          , "-H", "70"
                          , "--low",    "#859900"
                          , "--normal", "#b58900"
                          , "--high",   "#dc322f"
                          , "--width", "3"
                          ] 50

        , Run DynNetwork  [ "-t", "<dev>: <rx> <tx>"
                          , "-L", "1024"
                          , "-H", "1048576"
                          , "-S", "True"
                          , "--low",    "#859900"
                          , "--normal", "#b58900"
                          , "--high",   "#dc322f"
                          , "--width", "7"
                          ] 10

        , Run DiskIO      [ ("sda1", "Disk: <read> <write>")]
                          [ "-L", "10240"
                          , "-H", "102400"
                          , "--low",    "#859900"
                          , "--normal", "#b58900"
                          , "--high",   "#dc322f"
                          , "--width", "4"
                          ] 10

        , Run Battery     [ "-t", "Batt: <acstatus> <left>% - <timeleft>"
                          , "-L", "30"
                          , "-H", "60"
                          , "--low",    "#dc322f"
                          , "--normal", "#b58900"
                          , "--high",   "#859900"
                          ] 100
        ]
    }
