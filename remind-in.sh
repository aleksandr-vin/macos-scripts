# -*- mode: shell-script -*-
#
# Bash functions to Remind in ## seconds

# Properties that can be set for each task
#   name (text) : the name of the reminder
#   id (text, r/o) : the unique identifier of the reminder
#   body (text) : the notes attached to the reminder
#   completed (boolean) : Is the reminder completed?
#   completion date (date) : the completion date of the reminder
#   container (list, r/o) : the container of the reminder
#   creation date (date, r/o) : the creation date of the reminder
#   due date (date) : the due date of the reminder
#   modification date (date, r/o) : the modification date of the reminder
#   remind me date (date) : the remind date of the reminder
#   priority (integer) : the priority of the reminder

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

remind-job-done() {
    if [[ "$*" == "" ]]
    then
        args=%%
    else
        args=$*
    fi

    for j in $args
    do
        info=$(jobs $j)
        if [[ "$info" != "" ]]
        then
            pid=$(jobs -p $j | sed 's/\[[0-9]\]* [ -+]* \([0-9]*\) .*/\1/')
            lstat=$(ps -o lstart= -p $pid)
            descr="Running since $lstat\nWaited since $(date)"
            echo -e "$descr" | if fg $j
            then
                remind-in 0 "👌 $info"
            else
                remind-in 0 "🤌 $info"
            fi
        fi
    done
}
