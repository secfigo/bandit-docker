#!/bin/bash

set -v 

IGNORE_FILE="/src/bandit.ignore"
RESULT_FILE="/src/banditResult.json"

echo 'Running Bandit tests'
bandit -r -f json -o $RESULT_FILE /src/

if [ ! -f $IGNORE_FILE ]; then
    echo "Initially creating bandit.ignore file"
    mv /bandit/bandit.ignore.example /src/bandit.ignore 
    chmod -R 444 "$IGNORE_FILE"
fi

echo 'Results:'
python /bandit/banditParser.py -o $RESULT_FILE -i $IGNORE_FILE 
