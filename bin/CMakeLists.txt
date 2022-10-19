cmake_minimum_required(VERSION 3.15)

project(${CMAKE_PROJECT_NAME}Bin VERSION "${MAIN_PROJECT_VERSION}" LANGUAGES CXX)

# ======== setup project binaries ========

file(GLOB_RECURSE PROJECT_BUILD_BINARIES "*/*.cpp")

foreach (main_source ${PROJECT_BUILD_BINARIES})
    file(RELATIVE_PATH main_path ${PROJECT_BINARY_DIR} ${main_source})
    get_filename_component(binary_dir_path_name ${main_path} DIRECTORY)
    get_filename_component(binary_dir_name ${binary_dir_path_name} NAME_WE)
    get_filename_component(app_area_path_name ${binary_dir_path_name} DIRECTORY)
    get_filename_component(app_area ${app_area_path_name} NAME_WE)
    get_filename_component(binary_name ${main_path} NAME_WE)
    message(STATUS "Adding [${app_area}] ${binary_dir_name} binary ${binary_name}...")

    # ======== setup project binary target ========
    add_executable(${binary_name} ${main_source})
    set(link_libraries arena ${CONAN_LIBS})
    target_link_libraries(${binary_name} PUBLIC ${link_libraries} pthread dl)
    target_include_directories(${binary_name} PUBLIC ${MAIN_PROJECT_INCLUDE_DIRS})
    install(TARGETS ${binary_name})
endforeach ()
