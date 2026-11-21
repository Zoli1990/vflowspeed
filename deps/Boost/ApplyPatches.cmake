if (NOT DEFINED SOURCE_DIR OR NOT IS_DIRECTORY "${SOURCE_DIR}")
    message(FATAL_ERROR "Boost source directory does not exist: '${SOURCE_DIR}'")
endif ()

if (NOT DEFINED PATCH_1 OR NOT EXISTS "${PATCH_1}")
    message(FATAL_ERROR "Boost patch 1 was not found: '${PATCH_1}'")
endif ()

if (NOT DEFINED PATCH_2 OR NOT EXISTS "${PATCH_2}")
    message(FATAL_ERROR "Boost patch 2 was not found: '${PATCH_2}'")
endif ()

find_program(GIT_EXECUTABLE NAMES git git.exe)
if (NOT GIT_EXECUTABLE)
    message(FATAL_ERROR "Git executable was not found.")
endif ()

# Boost is extracted below the main vflowspeed repository. Without a local
# repository here, git apply discovers the parent repository and skips the
# Boost-relative paths because they are outside that repository's worktree.
execute_process(
    COMMAND "${GIT_EXECUTABLE}" init
    WORKING_DIRECTORY "${SOURCE_DIR}"
    RESULT_VARIABLE git_init_result
    OUTPUT_VARIABLE git_init_output
    ERROR_VARIABLE git_init_error
)

if (NOT git_init_result EQUAL 0)
    message(FATAL_ERROR
        "Could not initialize a temporary Git repository in the Boost source.\n"
        "${git_init_output}\n${git_init_error}")
endif ()

execute_process(
    COMMAND "${GIT_EXECUTABLE}" apply
        --verbose
        --ignore-space-change
        --whitespace=fix
        "${PATCH_1}"
        "${PATCH_2}"
    WORKING_DIRECTORY "${SOURCE_DIR}"
    RESULT_VARIABLE git_apply_result
    OUTPUT_VARIABLE git_apply_output
    ERROR_VARIABLE git_apply_error
)

message(STATUS "${git_apply_output}")
message(STATUS "${git_apply_error}")

if (NOT git_apply_result EQUAL 0)
    message(FATAL_ERROR
        "Applying the Boost patches failed (exit code ${git_apply_result}).")
endif ()
