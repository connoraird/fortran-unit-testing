cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

# Set project name
set(PROJ_NAME "fortran-unit-testing-with-test-drive" CACHE STRING "Project name.")
project("${PROJ_NAME}"
  LANGUAGES "Fortran"
  VERSION "0.0.1"
  DESCRIPTION "Playground project for testing test-drive"
)

# Get test-drive lib
set(_lib "test-drive")
set(_pkg "TEST_DRIVE")
set(_url "https://github.com/fortran-lang/test-drive")

message(STATUS "Retrieving ${_lib} from ${_url}")
include(FetchContent)
FetchContent_Declare(
    "${_lib}"
    GIT_REPOSITORY "${_url}"
    GIT_TAG "HEAD"
    )
FetchContent_MakeAvailable("${_lib}")

add_library("${_lib}::${_lib}" INTERFACE IMPORTED)
target_link_libraries("${_lib}::${_lib}" INTERFACE "${_lib}")

# We need the module directory in the subproject before we finish the configure stage
FetchContent_GetProperties("${_lib}" SOURCE_DIR "${_pkg}_SOURCE_DIR")
FetchContent_GetProperties("${_lib}" BINARY_DIR "${_pkg}_BINARY_DIR")
if(NOT EXISTS "${${_pkg}_BINARY_DIR}/include")
    make_directory("${${_pkg}_BINARY_DIR}/include")
endif()

# Define src and test files
set(PROJ_SRC_DIR "${PROJECT_SOURCE_DIR}/../../src")
set(PROJ_TEST_DIR "${PROJECT_SOURCE_DIR}")

file(GLOB PROJ_SOURCES          "${PROJ_SRC_DIR}/*.f90")
file(GLOB PROJ_PF_SOURCES       "${PROJ_SRC_DIR}/packing_fraction/*.f90")
file(GLOB PROJ_TEST_SOURCES     "${PROJ_TEST_DIR}/*.f90")

# Build src executable
add_executable("${PROJ_NAME}" "${PROJ_SOURCES}" "${PROJ_PF_SOURCES}")

# Build test executable
add_executable("${PROJ_NAME}-test" "${PROJ_SOURCES}" "${PROJ_PF_SOURCES}" "${PROJ_TEST_SOURCES}")
target_link_libraries("${PROJ_NAME}-test" INTERFACE "${_lib}")
