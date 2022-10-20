from conans import ConanFile, CMake


class MainConan(ConanFile):
    settings = (
        "os",
        "compiler",
        "build_type",
        "arch"
    )

    requires = (
        "entt/3.10.3",
        "fmt/9.1.0",
        "freetype/2.12.1",
        "glad/0.1.36",
        "glfw/3.3.8",
        "glm/0.9.9.8",
        "gtest/1.12.1",
        "spdlog/1.10.0",
        "stb/cci.20210910",
        # "glslang/11.7.0",
        # "imgui/1.88",
        # "sfml/2.5.1",
        # "tinygltf/2.5.0",
        # "toml11/3.7.1",
    )

    options = {
        "build_benchmarks": [True, False],
        "build_tests": [True, False],
    }
    default_options = {
        "build_benchmarks": False,
        "build_tests": True,
    }

    generators = "cmake"

    def configure(self):
        if self.settings.os == "Linux" and self.settings.compiler.libcxx == "libstdc++":
            raise Exception("Main is not compatible with libstdc++. "
                            "Please change the 'compiler.libcxx'-setting "
                            "(e.g. to libstdc++11).")

        # Configure GLAD options
        # self.options['glad'].shared = False
        # self.options['glad'].fPIC = True
        # self.options['glad'].no_loader = False
        self.options['glad'].spec = 'gl'
        # self.options['glad'].gl_profile = 'core'
        self.options['glad'].gl_version = '4.6'
        self.options['glad'].extensions = 'GL_EXT_texture_filter_anisotropic'

    def requirements(self):
        if self.options.build_benchmarks:
            self.requires("benchmark/1.6.2")
        if self.options.build_tests:
            self.requires("gtest/1.12.1")

    def imports(self):
        # Copies all dll files from packages bin folder to my "bin" folder (win)
        self.copy("*.dll", dst="bin", src="bin")

        # Copies all dylib files from packages lib folder to my "lib" folder (macosx)
        self.copy("*.dylib*", dst="lib", src="lib")

        # Copies all so files from packages lib folder to my "lib" folder (linux)
        self.copy("*.so*", dst="lib", src="lib")

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

# conanfile.txt:
#
# [requires]
# glfw/3.3.3
# glad/0.1.34
#
# [generators]
# cmake_find_package
#
# [options]
# glad:gl_profile=core
# glad:gl_version=4.6
