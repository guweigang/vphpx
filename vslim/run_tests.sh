#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$DIR"

PHP_BIN=$(which php)
if [ -z "$PHP_BIN" ]; then
    echo "Error: PHP is not found in PATH."
    exit 1
fi

RUN_TESTS="../vphptest/run-tests.php"
if [ ! -f "$RUN_TESTS" ]; then
    echo "Error: $RUN_TESTS is not available."
    exit 1
fi

echo "Running tests with PHP: $PHP_BIN"

# Some PHPT cases share their basename with checked-in PHP and shell fixtures.
artifact_prefix=".vslim-phpt-$$-"
RUN_ARGS=(-q --artifact-prefix "$artifact_prefix")
if [ "${VSLIM_TEST_SHOW:-}" = "all" ]; then
    RUN_ARGS+=(--show-all)
fi

include_runtime_tests=false
if [ "${VSLIM_INCLUDE_RUNTIME_TESTS:-0}" = "1" ]; then
    include_runtime_tests=true
fi

# Only pass PHPT files to the harness. The tests/ directory also contains
# fixtures, helper scripts, and transient *.out/*.diff/*.log artifacts from
# previous local debugging runs, so handing the whole directory to run-tests.php
# is more fragile than being explicit here.
if [ "$#" -gt 0 ]; then
    TESTS=("$@")
else
    TESTS=()
    while IFS= read -r test_file; do
        if [ "$include_runtime_tests" != "true" ]; then
            case "$test_file" in
                tests/test_httpd*.phpt|tests/test_vhttpd*.phpt|tests/*worker*.phpt)
                    continue
                    ;;
            esac
        fi
        TESTS+=("$test_file")
    done <<EOF
$(find tests -type f -name '*.phpt' | sort)
EOF
fi

if [ "${#TESTS[@]}" -eq 0 ]; then
    echo "Error: no PHPT tests found."
    exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Running VSlim architecture boundary scan"
    if [ "${OS:-}" = "Windows_NT" ]; then
        v -cc msvc test tests/boundary_scan_test.v
    else
        v test tests/boundary_scan_test.v
    fi
fi

RUN_ARGS+=(-d extension=./vslim.so)
trap 'find tests -type f -name "${artifact_prefix}*" -delete' EXIT
TEST_PHP_EXECUTABLE="$PHP_BIN" php "$RUN_TESTS" "${RUN_ARGS[@]}" "${TESTS[@]}"
