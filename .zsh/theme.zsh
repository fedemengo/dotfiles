
title=$(todo.sh ls | tail -n 1)
todos=$(todo.sh ls | head -n $(($(todo.sh ls | wc -l)-2)) | sort)
echo "$(tput setaf 197)$title $(tput sgr0)"; echo $todos; echo "";

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="powerline"
ZSH_DISABLE_COMPFIX=true

#############################################################################
####################### POWERLEVEL9K CONFIGURATION ##########################
#############################################################################

###################### REMOVE/EDIT ICONS ####################
#POWERLEVEL9K_VCS_BOOKMARK_ICON="\uF27B"
POWERLEVEL9K_VCS_COMMIT_ICON="\uF221"
#POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON="\u2192"
#POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uF113"
#POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON="\uF171"
#POWERLEVEL9K_VCS_SVN_ICON="(svn)"

POWERLEVEL9K_FOLDER_ICON=""
POWERLEVEL9K_HOME_ICON=""
POWERLEVEL9K_HOME_SUB_ICON=""
POWERLEVEL9K_LOCK_ICON=""
POWERLEVEL9K_ETC_ICON=""

POWERLEVEL9K_NETWORK_ICON=""

EMPTY_BG=232
DEFAULT_FG=0

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\U1F892 " # \u25B8 "

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=""
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=""

# Status
POWERLEVEL9K_CUSTOM_ERRNO=true
POWERLEVEL9K_MY_STATUS_OK=true
POWERLEVEL9K_MY_STATUS_CROSS=true
POWERLEVEL9K_MY_STATUS_OK_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_MY_STATUS_ERROR_BACKGROUND=$EMPTY_BG

# Dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

POWERLEVEL9K_DIR_HOME_FOREGROUND="38;5;39"
POWERLEVEL9K_DIR_HOME_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="38;5;39"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="38;5;39"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_DIR_ETC_FOREGROUND="38;5;39"
POWERLEVEL9K_DIR_ETC_BACKGROUND=$EMPTY_BG

# VCS
POWERLEVEL9K_VCS_GIT_ICON=""
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""
POWERLEVEL9K_VCS_COMMIT_ICON="#"
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_SHOW_CHANGESET=true

POWERLEVEL9K_VCS_CLEAN_FOREGROUND=041
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=197
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=227
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=$EMPTY_BG

# TODO
POWERLEVEL9K_MY_TODO_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_MY_TODO_FOREGROUND=208

# Execution time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=226
POWERLEVEL9K_EXECUTION_TIME_ICON="s" #"\u23F1"

# BG jobs
POWERLEVEL9K_BACKGROUND_JOBS_ICON=""
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=135
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=$EMPTY_BG

# IP
POWERLEVEL9K_IP_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_IP_FOREGROUND=087

# Time
POWERLEVEL9K_TIME_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_TIME_FOREGROUND="white"
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_TIME_ICON=""

# User
POWERLEVEL9K_USER_BACKGROUND=$EMPTY_BG
POWERLEVEL9K_USER_FOREGROUNG=076

prompt_my_todo() {
  if $(hash todo.sh 2>&-); then
    count=$(todo.sh ls | egrep "TODO: [0-9]+ of ([0-9]+) tasks shown" | awk '{ print $4 }')
    if [[ "$count" = <-> ]]; then
      "$1_prompt_segment" "$0" "$2" "244" "$DEFAULT_COLOR" "TODO: $count"
    fi
  fi
}

POWERLEVEL9K_USER_TEMPLATE="%n"
prompt_my_user() {
  local current_state="DEFAULT"
  typeset -AH user_state
  if [[ "$POWERLEVEL9K_ALWAYS_SHOW_USER" == true ]] || [[ "$(whoami)" != "$DEFAULT_USER" ]]; then
    if [[ $(print -P "%#") == '#' ]]; then
      user_state=(
        "STATE"               "ROOT"
        "CONTENT"             "${POWERLEVEL9K_USER_TEMPLATE}"
        "BACKGROUND_COLOR"    "${POWERLEVEL9K_USER_BACKGROUND}"
        "FOREGROUND_COLOR"    "${POWERLEVEL9K_USER_FOREGROUNG}"
        "VISUAL_IDENTIFIER"   ""
      )
    elif sudo -n true 2>/dev/null; then
      user_state=(
        "STATE"               "SUDO"
        "CONTENT"             "${POWERLEVEL9K_USER_TEMPLATE}"
        "BACKGROUND_COLOR"    "${POWERLEVEL9K_USER_BACKGROUND}"
        "FOREGROUND_COLOR"    "${POWERLEVEL9K_USER_FOREGROUNG}"
        "VISUAL_IDENTIFIER"   ""
      )
    else
      user_state=(
        "STATE"               "DEFAULT"
        "CONTENT"             "${POWERLEVEL9K_USER_TEMPLATE}"
        "BACKGROUND_COLOR"    "${POWERLEVEL9K_USER_BACKGROUND}"
        "FOREGROUND_COLOR"    "${POWERLEVEL9K_USER_FOREGROUNG}"
        "VISUAL_IDENTIFIER"   ""
      )
    fi
    "$1_prompt_segment" "${0}_${user_state[STATE]}" "$2" "${user_state[BACKGROUND_COLOR]}" "${user_state[FOREGROUND_COLOR]}" "${user_state[CONTENT]}" "${user_state[VISUAL_IDENTIFIER]}"
  fi
}

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(my_user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time background_jobs my_todo)
