#!/bin/bash
#|-----------------------------------------------------------------------------------------------------------------|
#| Program Name: pomodoro.sh
#|-----------------------------------------------------------------------------------------------------------------|
#| Description: This script allows to start pomodoro session within the command line
#|        1) You choose the duration of session or/and the duration of pauses.
#|        2) It keeps track of your total session hours.
#|
#|-----------------------------------------------------------------------------------------------------------------|
#| Author: Louisan TCHITOULA
#| Date: 19/04/2023

#DEFAULT VALUES
TITLE="PomodoShell"
SESSION_DURATION=30
PAUSE_DURATION=5
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

start() {
    SESSION_DURATION=$(expr $SESSION_DURATION \* 60)
    PAUSE_DURATION=$(expr $PAUSE_DURATION \* 60)
    COUNT=0


    for((i=0; i < $N_SESSIONS; i++))
    do 
        START=$(($(date +%s) + $SESSION_DURATION))
        while [[ $(date +%s) -lt $START ]]
        do  
            clear
            echo "Current session : $i / $N_SESSIONS"
            echo "$((START - $(date +%s) ))" | awk '{print int($1/60)"m :"int($1%60)"s"}'
            sleep 1
        done


        PAUSE=$(($(date +%s) + $PAUSE_DURATION))
        while [[ $(date +%s) -lt $PAUSE ]]
        do 
            clear
            echo "Next session($i + 1) starts in :"
            echo "$((PAUSE - $(date +%s) ))" | awk '{print int($1/60)"m :"int($1%60)"s"}'
            sleep 1
        done
    done

    echo "$(date +"%Y-%m-%d"): $N_SESSIONS sessions of $SESSION_DURATION minutes" >> logs
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