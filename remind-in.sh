# -*- mode: shell-script -*-
#
# Bash functions to Remind in ## seconds

remind-in() {
    body=$(cat)
    delay=$1
    shift
    summary="$*"
    osascript -e "
    set theDelayValue to $delay
    set theDueDate to (current date) + theDelayValue
    set theSummary to \"$summary\"
    set theBody to \"$body\"

    tell application \"Reminders\"
	 tell list \"Reports\"
	      make reminder with properties {name:theSummary, remind me date:theDueDate, body:theBody}
	      activate
         end tell
    end tell
"
}
