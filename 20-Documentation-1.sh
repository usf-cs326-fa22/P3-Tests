source "${TEST_LIB}/funcs.bash"

test_start "Documentation Check" \
    "Ensures documentation is provided for each function and data structure and the README is filled out"

if ! ( which doxygen &> /dev/null ); then
    # "Doxygen is not installed. Please install (as root) with:"
    # "pacman -Sy doxygen"
    test_end 1
fi

# If the grep below finds any TODOs, the test case fails.
grep 'TODO' "${TEST_DIR}/../README.md" && test_end 1


# If we get this far, the README has everything filled out.


# Doxygen will look for javadoc-style documentation above each function, struct,
# etc.
doxygen "${TEST_DIR}/../Doxyfile" 2>&1 \
    | grep -v '__attribute__((packed))' \
    | grep '(function)' \
    | grep 'is not documented.$' \
        && test_end 1

test_end 0
