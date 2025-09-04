#!/bin/bash
set -e
if ! which pytest > /dev/null 2>&1; then
    echo "Error: pytest not found."
    exit 1
fi
echo "Running tests before push"
pytest --verbose
test_result=$?
if [ $test_result -ne 0 ]; then
    echo " py tests are failed. push aborted."
    exit 1
fi
shellcheck /workspaces/codespaces-blank/BashTraining/bash/*.sh 
shell_test_result=$?
if [ $test_result -ne 0 ]; then
    echo " shell check tests are failed. push aborted."
    exit 1
fi
echo "tests are passed. proceeding with push."
exit 0
