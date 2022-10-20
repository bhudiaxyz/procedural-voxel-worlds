cmake_minimum_required(VERSION 3.15)

project(${CMAKE_PROJECT_NAME}Lib VERSION "${MAIN_PROJECT_VERSION}" LANGUAGES CXX)

# ======== setup project libaries ========

set(PROJECT_BUILD_LIBRARIES arena)

foreach (library_name ${PROJECT_BUILD_LIBRARIES})
    message(STATUS "Adding library ${library_name}...")

    # ======== setup project library target ========
    file(GLOB_RECURSE library_sources ${PROJECT_SOURCE_DIR}/${library_name}/*.cpp)
    add_library(${library_name} ${library_sources})
    target_compile_features(${library_name} PUBLIC cxx_std_20)
    target_include_directories(${library_name} PUBLIC ${MAIN_PROJECT_INCLUDE_DIRS})
    install(TARGETS ${library_name})
endforeach ()
