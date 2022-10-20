
function(set_project_compiler_options)
    # From: https://github.com/lefticus/cppbestpractices/blob/master/02-Use_the_Tools_Available.md
    option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)

    set(MSVC_WARNINGS
            /W4 # Baseline reasonable warnings
            /w14242 # 'identifier': conversion from 'type1' to 'type1', possible loss of data
            /w14254 # 'operator': conversion from 'type1:field_bits' to 'type2:field_bits', possible loss of data
            /w14263 # 'function': member function does not override any base class virtual member function
            /w14265 # 'classname': class has virtual functions, but destructor is not virtual instances of this class may not
            # be destructed correctly
            /w14287 # 'operator': unsigned/negative constant mismatch
            /we4289 # nonstandard extension used: 'variable': loop control variable declared in the for-loop is used outside
            # the for-loop scope
            /w14296 # 'operator': expression is always 'boolean_value'
            /w14311 # 'variable': pointer truncation from 'type1' to 'type2'
            /w14545 # expression before comma evaluates to a function which is missing an argument list
            /w14546 # function call before comma missing argument list
            /w14547 # 'operator': operator before comma has no effect; expected operator with side-effect
            /w14549 # 'operator': operator before comma has no effect; did you intend 'operator'?
            /w14555 # expression has no effect; expected expression with side- effect
            /w14619 # pragma warning: there is no warning number 'number'
            /w14640 # Enable warning on thread un-safe static member initialization
            /w14826 # Conversion from 'type1' to 'type_2' is sign-extended. This may cause unexpected runtime behavior.
            /w14905 # wide string literal cast to 'LPSTR'
            /w14906 # string literal cast to 'LPWSTR'
            /w14928 # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
            /permissive- # standards conformance mode for MSVC compiler.
            )

    set(CLANG_WARNINGS
            -Wno-deprecated-volatile
            -Wno-deprecated-declarations
            -Wpedantic # warn if non-standard C++ is used
            -Wextra # reasonable and standard
            -Wno-unused-parameter
            -Wno-conversion # warn on type conversions that may lose data
            # -Wall
#            -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor. This helps
#            # catch hard to track down memory errors
#            -Wno-old-style-cast # warn for c-style casts
#            -Wno-cast-align # warn for potential performance problem casts
#            # -Wunused # warn on anything being unused
#            -Woverloaded-virtual # warn if you overload (not override) a virtual function
#            -Wno-sign-conversion # warn on sign conversions
#            -Wno-sign-compare
#            -Wno-double-promotion
#            -Wno-implicit-int-conversion
#            -Wno-implicit-float-conversion
#            -Wnull-dereference # warn if a null dereference is detected
#            -Wdouble-promotion # warn if float is implicit promoted to double
#            -Wformat=2 # warn on security issues around functions that format output (ie printf)
#            -Wno-unused-lambda-capture # We like explicit capture
            )

    if (WARNINGS_AS_ERRORS)
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif ()

    if (WIN32)
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
    else ()
        set(PROJECT_WARNINGS ${CLANG_WARNINGS})
    endif ()

    add_compile_options(${PROJECT_WARNINGS})

    # ================ PROJECT SETUP ================

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

    add_compile_options(-Wno-psabi)

endfunction()
