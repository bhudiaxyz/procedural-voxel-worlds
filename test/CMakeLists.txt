# C++ University

cmake_minimum_required(VERSION 3.15)

project(${CMAKE_PROJECT_NAME}Test VERSION "${MAIN_PROJECT_VERSION}" LANGUAGES CXX)

include(GoogleTest)

# ======== setup project tests ========

set(PROJECT_BUILD_TESTS config)

foreach (arena_area ${PROJECT_BUILD_TESTS})
    set(binary_name "arena_${arena_area}")
    set(test_binary_name "${binary_name}_test")
    message(STATUS "Adding test ${test_binary_name}...")

    # ======== setup project test target ========
    file(GLOB_RECURSE test_binary_sources ${PROJECT_SOURCE_DIR}/arena/${arena_area}/*.cpp)
    add_executable(${test_binary_name} ${test_binary_sources})
    target_include_directories(${test_binary_name} PUBLIC ${MAIN_PROJECT_INCLUDE_DIRS})
    set(link_libraries arena ${CONAN_LIBS})
    target_link_libraries(${test_binary_name} ${link_libraries})

    gtest_discover_tests(${test_binary_name})
    install(TARGETS ${test_binary_name})
endforeach ()
