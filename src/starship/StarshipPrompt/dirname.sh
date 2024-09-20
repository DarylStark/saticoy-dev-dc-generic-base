#!/bin/bash

full_pwd=$(pwd)
option=$1
detail=$2

# Make sure the home directory is set correctly
short_pwd=$(dirs +0)

is_workspaces() {
    short_pwd=$1
    first_dirs=$(echo $short_pwd | cut -d '/' -f 1,2)
    if [ "$first_dirs" == '/workspaces' ]; then
        if [ "$(echo $short_pwd | cut -d '/' -f 2)" == "" ]; then
            return 1
        fi
        return 0
    fi
    return 1
}

if [ "$option" == "is" ]; then
    if [ "$detail" == "home" ]; then
        first_dir=$(echo $short_pwd | cut -d '/' -f 1)
        if [ "$first_dir" == '~' ]; then
            exit 0
        fi
        exit 1
    fi

    if [ "$detail" == "not_home" ]; then
        first_dir=$(echo $short_pwd | cut -d '/' -f 1)
        if [ "$first_dir" == '~' ]; then
            exit 1
        fi
        exit 0
    fi

    if [ "$detail" == "workspaces" ]; then
        is_workspaces $short_pwd
        exit $?
    fi

    if [ "$detail" == "not_workspaces" ]; then
        is_workspaces $short_pwd
        if [ "$?" == "0" ]; then
            exit 1
        fi
        exit 0
    fi
fi

echo $short_pwd
