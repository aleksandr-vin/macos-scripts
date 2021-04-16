# -*- mode: shell-script -*-
#
# Bash functions to video-call and to iMessage

facetime() {
    open facetime://"$1"
    osascript -e '
tell application "System Events"
  repeat until (button "Call" of window 1 of application process "FaceTime" exists)
    delay 1
  end repeat
  click button "Call" of window 1 of application process "FaceTime"
end tell
'
}

facetimeme() {
    facetime $FACETIME_EMAIL
}
