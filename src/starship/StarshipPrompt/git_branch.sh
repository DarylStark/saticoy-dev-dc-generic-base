#!/bin/bash

# Retrieve the branchname and display it as it should
# Arg:
# - <not set> = display full branch name
# - 'branch' = display only the last part of the branch ('issue-10/feature/test-feature' will become 'test-feature')
# - 'type' = display the type of branch ('feature' or 'bugfix'; 'issue-10/feature/test-feature' will become 'feature')
# - 'issue' = display the issue number if it is in the branch ('issue-10/feature/test-feature' will become '10')

# Get the current full branchname
branchname=$(git status | grep -oP "On branch \K(.+)")

# Display only the last part of the branchname
if [ "${1}" == "branch" ]; then
    echo $branchname | rev | cut -d '/' -f 1 | rev
    exit 0
fi

# Display the type only
if [ "${1}" == "type" ]; then
    btype=''
    btypeshort=''
    echo $branchname | grep --quiet 'feature/' && btype="feature" && btypeshort='F'
    echo $branchname | grep --quiet 'bugfix/' && btype="bugfix" && btypeshort='B'
    echo $branchname | grep --quiet 'improvement/' && btype="improvement" && btypeshort='I'
    if [ "$btype" != '' ]; then
        if [ "${2}" == "short" ]; then
            echo $btypeshort
        else
            echo $btype
        fi
        exit 0
    fi
    exit 1
fi

# Only exit value for 'is main'
if [ "${1}" == "is" ]; then
    if [ "${2}" == "main" ]; then
        if [ "$branchname" == "main" ] || [ "$branchname" == "master" ] ; then
            exit 0
        fi
    fi

    if [ "${2}" == "dev" ]; then
        if [ "$branchname" == "dev" ] || [ "$branchname" == "development" ] ; then
            exit 0
        fi
    fi

    # All other; false
    exit 1
fi

# Display the issue number
if [ "${1}" == "issue" ]; then
    issue_number=$(echo $branchname | grep -oP 'issue-\K[0-9]+')
    if [ "$?" == "0" ]; then
        echo $issue_number
        exit 0
    fi
    exit 1
fi

# No args, display the full branchname
echo $branchname
