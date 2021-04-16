# -*- mode: shell-script -*-
#
# Bash functions to iMessage

imessage() {
    buddy=$1
    msg=$(cat)
    osascript -e "
    tell application \"Messages\"
        set targetService to 1st service whose service type = iMessage
        set targetBuddy to buddy \"$buddy\" of targetService
        send \"$msg\" to targetBuddy
    end tell
"
}

imessageme() {
    imessage $FACETIME_EMAIL
}
