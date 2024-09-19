#!/bin/bash

dirname=$1
option=$2
reponame=$(echo $dirname | cut -d '/' -f 4)

if [ "$option" == "project_name" ]; then
    echo $dirname | cut -d '/' -f 3
fi

if [ "$option" == "repo_name" ]; then
    if [ "$reponame" == "" ]; then
        echo "..."
        exit 0
    fi

	inner_folder=$(echo $dirname | cut -d '/' -f 5-)
	if [ "$inner_folder" != "" ]; then              
	inner_folder=" > $inner_folder"             
	fi                                              
	reponame=$(echo $reponame | cut -d '-' -f 4-)
	echo "$reponame$inner_folder"                   
fi

if [ "$option" == "repo_type" ]; then
    echo $reponame | cut -d '-' -f 2
fi

if [ "$option" == "repo_scope" ]; then
    echo $reponame | cut -d '-' -f 3
fi

exit 0
