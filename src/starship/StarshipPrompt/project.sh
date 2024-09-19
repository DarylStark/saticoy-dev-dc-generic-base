#!/bin/bash

dirname=$1
option=$2

if [ "$option" == "project_name" ]; then
    echo $dirname | cut -d '/' -f 3
fi

if [ "$option" == "repo_name" ]; then
    reponame=$(echo $dirname | cut -d '/' -f 4)
    if [ "$reponame" == "" ]; then
        echo "..."
        exit 0
    fi
    inner_folder=$(echo $dirname | cut -d '/' -f 5-)
    if [ "$inner_folder" != "" ]; then
        inner_folder=" > $inner_folder"
    fi
    echo "$reponame$inner_folder"
fi

if [ "$option" == "repo_type" ]; then
    echo "Unknown"
    exit 1
fi

if [ "$option" == "repo_scope" ]; then
    echo "Unknown"
    exit 1
fi

exit 0
