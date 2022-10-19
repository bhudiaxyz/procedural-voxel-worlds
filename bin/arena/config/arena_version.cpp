#include <functional>

#include "arena/common/log.hpp"
#include "arena/config/version.hpp"

int main(int argc, char const **argv) {
    arena::logger_init(argv[0]);

    spdlog::info("Project Version: {}", arena::version());
    spdlog::info("Project Version hash: {}", std::hash<std::string>{}(arena::version()));

    return EXIT_SUCCESS;
}
