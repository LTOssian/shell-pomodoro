#!/bin/bash
#|-----------------------------------------------------------------------------------------------------------------|
#| Program Name: pomodoro.sh
#|-----------------------------------------------------------------------------------------------------------------|
#| Description: This script allows to start pomodoro session within the command line
#|        1) You choose the duration of session or/and the duration of pauses.
#|        2) It keeps track of your total session hours.
#|        4) Rings a sound when a session is over.
#|
#|-----------------------------------------------------------------------------------------------------------------|
#| Author: Louisan TCHITOULA
#| Date: 19/04/2023

#DEFAULT VALUES
TITLE="PomodoShell"
SESSION_DURATION=30
PAUSE_DURANTION=1
N_SESSIONS=3

show_help() {
    HELP="
    -s, set time for sessions (in minutes) \default: 30
    -p, set time for pauses (in minutes) \default: 5
    -n, set number of sessions \default: 3
    "

    echo "$HELP"
}

show_credits() {
    CREDITS="
    AUTHOR: Louisan TCHITOULA
    Date: 19/04/2023
    GitHub: LTOssian
    LinkedIn: Louisan Tchitoula

    Thanks for trying it out, any feedback is welcomed.
    "

    echo "$CREDITS"
}

chronometer () {
    START=$(($(date +%s) + $1))

    while [[ "$START" -ge "$(date +%s)" ]]
    do
        echo "test"
    done

}

start() {
    SESSION_DURATION=$(echo "($SESSION_DURATION * 60)/1" | bc)
    PAUSE_DURANTION=$(echo "($PAUSE_DURATION * 60)/1" | bc)
    COUNT=0

    while [[ COUNT -lt N_SESSIONS ]]
    do 
        clear
        chronometer SESSION_DURATION 
        echo "End of session"
        ((COUNT = COUNT + 1))
    done
}




# While the number of arguments passed is greater than 0
while [[ $# -gt 0 ]]
do 
    case $1 in 
        -s|--session)
            SESSION_DURATION="$2"
            shift && shift
            ;;
        -p|--pause)
            PAUSE_DURATION="$2"
            shift && shift
            ;;
        -n)
            N_SESSIONS="$2"
            shift && shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -c|--credit)
            show_credits
            exit 0
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
        esac
done

start