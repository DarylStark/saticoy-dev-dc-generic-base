#!/bin/bash

full_pwd=$(pwd)
option=$1
detail=$2

# Make sure the home directory is set correctly
short_pwd=$(dirs +0)

is_project() {
    short_pwd=$1
    first_dirs=$(echo $short_pwd | cut -d '/' -f 1,2)
    if [ "$first_dirs" == '~/Projects' ]; then
        if [ "$(echo $short_pwd | cut -d '/' -f 3)" == "" ]; then
            return 1
        fi
        return 0
    fi
    return 1
}

project_name() {
    short_pwd=$1
    is_project $short_pwd
    if [ "$?" == "0" ]; then
        projectname=$(echo $short_pwd | cut -d '/' -f 3)
        echo $projectname
        return 0
    fi
    return 1
}

project_script() {
    short_pwd=$1
    p=$(project_name $short_pwd)
    basedir="~/StarshipPrompt"
    basedir="${basedir/#\~/$HOME}"
    p_script="$basedir/project-$p.sh"
    if [ -x $p_script ]; then
        echo $p_script
        exit 0
    fi
    echo "$basedir/project.sh"
    exit 1
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

    if [ "$detail" == "projects" ]; then
        is_project $short_pwd
        exit $?
    fi

    if [ "$detail" == "not_projects" ]; then
        is_project $short_pwd
        if [ "$?" == "0" ]; then
            exit 1
        fi
        exit 0
    fi
fi

if [ "$option" == "project_name" ]; then
    script=$(project_script $short_pwd)
    $script $short_pwd project_name
    exit $?
fi

if [ "$option" == "project_repo_name" ]; then
    script=$(project_script $short_pwd)
    $script $short_pwd repo_name
    exit $?
fi

if [ "$option" == "project_repo_type" ]; then
    script=$(project_script $short_pwd)
    $script $short_pwd repo_type
    exit $?
fi

if [ "$option" == "project_repo_scope" ]; then
    script=$(project_script $short_pwd)
    $script $short_pwd repo_scope
    exit $?
fi

echo $short_pwd
