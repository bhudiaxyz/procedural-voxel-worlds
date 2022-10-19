cmake_minimum_required(VERSION 3.15)
include(CMakeDependentOption)

set(RUNTIME_OUTPUT_DIRECTORY build)

# ================ PROJECT SETUP ================
project(ProceduralVoxelWorlds VERSION 1.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# Prevent in source builds
set(FORCE_COLORED_OUTPUT ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

# https://cmake.org/cmake/help/latest/prop_tgt/MSVC_RUNTIME_LIBRARY.html
cmake_policy(SET CMP0091 NEW)

string(TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWERCASE)
string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPERCASE)
string(TIMESTAMP MAIN_PROJECT_BUILD_DATE "%Y-%m-%d %H:%M:%S" UTC)

set(MAIN_PROJECT_NAME ${CMAKE_PROJECT_NAME})
set(MAIN_PROJECT_NAME_LOWERCASE ${PROJECT_NAME_LOWERCASE})
set(MAIN_PROJECT_NAME_UPPERCASE ${PROJECT_NAME_UPPERCASE})
set(MAIN_PROJECT_VERSION ${PROJECT_VERSION})
set(MAIN_PROJECT_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(MAIN_PROJECT_BUILD_DIR ${PROJECT_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

# Generate (tokens expanded) header file
configure_file(include/arena/config/project_version.hpp.in include/arena/config/project_version.hpp)

# Copy all resources files into bin builder folder
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/assets/ DESTINATION ${PROJECT_BINARY_DIR}/assets)

# Options
option(MAIN_BUILD_BENCHMARKS "Build benchmarks" OFF)
option(MAIN_BUILD_DOC "Build documentation" OFF)
option(MAIN_BUILD_EXAMPLE "Build example" ON)
option(MAIN_BUILD_TESTS "Build tests" ON)
set(MAIN_CONAN_PROFILE "default" CACHE STRING "conan profile")
option(MAIN_FORCE_COLORED_OUTPUT "Always produce ANSI-colored output (GNU/Clang only)." TRUE)

message(STATUS "MAIN_BUILD_BENCHMARKS = ${MAIN_BUILD_BENCHMARKS}")
message(STATUS "MAIN_BUILD_DOC = ${MAIN_BUILD_DOC}")
message(STATUS "MAIN_BUILD_EXAMPLE = ${MAIN_BUILD_EXAMPLE}")
message(STATUS "MAIN_BUILD_TESTS= ${MAIN_BUILD_TESTS}")
message(STATUS "MAIN_CONAN_PROFILE = ${MAIN_CONAN_PROFILE}")

message(STATUS "CMAKE_VERSION = ${CMAKE_VERSION}")
message(STATUS "CMAKE_GENERATOR = ${CMAKE_GENERATOR}")
message(STATUS "C Compiler executable: ${CMAKE_C_COMPILER}")
message(STATUS "CXX Compiler executable: ${CMAKE_CXX_COMPILER}")
message(STATUS "Linker executable: ${CMAKE_LINKER}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# Hide noise related to deprecated warnings like:
# warning: 'glDrawArrays' is deprecated: first deprecated in macOS 10.14 - OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings) [-Wdeprecated-declarations]
add_compile_options(-DGL_SILENCE_DEPRECATION)

# Enable GCC/clang ANSI-colored terminal output using Ninja build tool
# TODO: Switch to `CMAKE_COLOR_DIAGNOSTICS` with cmake 3.24 in the future
if (FORCE_COLORED_OUTPUT)
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_compile_options(-fdiagnostics-color=always)
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        add_compile_options(-fcolor-diagnostics)
    endif ()
endif ()

# if (APPLE)
#     add_compile_options(-Wno-deprecated-volatile -Wno-deprecated-declarations)
# endif ()
# add_compile_options(-Wall -Wextra)
add_compile_options(-Wno-deprecated-volatile -Wno-deprecated-declarations)

#Setup Glad
set(GLAD_API "gl=4.1" CACHE STRING "" FORCE)
set(GLAD_EXTENSIONS "GL_EXT_texture_filter_anisotropic" CACHE STRING "" FORCE)

# Dependency setup with conan
include(conan_setup)

find_package(Git REQUIRED)

# Extract the current git sha
execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --always --abbrev=7
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        OUTPUT_VARIABLE MAIN_GIT_SHA
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

# ======== Main project ========

set(MAIN_PROJECT_INCLUDE_DIRS "")

include_directories(${PROJECT_BINARY_DIR}/include ${PROJECT_SOURCE_DIR}/include)
list(APPEND MAIN_PROJECT_INCLUDE_DIRS ${PROJECT_BINARY_DIR}/include ${PROJECT_SOURCE_DIR}/include)

# ================ PROJECT SETUP ================

message(STATUS "Cmake module path: ${CMAKE_MODULE_PATH}...")
message(STATUS "Conan libaries: ${CONAN_LIBS}...")
message(STATUS "Main includes: ${MAIN_PROJECT_INCLUDE_DIRS}...")

add_subdirectory(shaders)
add_subdirectory(lib)
add_subdirectory(bin)

if (MAIN_BUILD_TESTS)
    # NOTE: Must enable_testing *before* add_subdirectory otherwise CTest is empty - Doh!
    enable_testing()
    add_subdirectory(test)
endif ()


#if(MAIN_BUILD_BENCHMARKS)
#    add_subdirectory(benchmarks)
#endif()
#
#if(MAIN_BUILD_DOC)
#    add_subdirectory(documentation)
#endif()
#
#if(MAIN_BUILD_EXAMPLE)
#    add_subdirectory(example)
#endif()
#
