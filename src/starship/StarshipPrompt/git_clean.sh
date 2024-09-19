#!/bin/bash

# Returns a 0 if the branch is clean and a 1 if the branch is not clean, unless
# the first argument is set, then it reverses it

# Set the correct output
clean_exit=0
not_clean_exit=1
if [ "${#}" -gt 0 ]; then
    clean_exit=1
    not_clean_exit=0
fi

# Check if the branch is clean
clean=$(git status | grep --quiet 'nothing to commit' && echo "C" || echo "N")
if [ "${clean}" == "C" ]; then
    exit ${clean_exit}
fi

exit ${not_clean_exit}
