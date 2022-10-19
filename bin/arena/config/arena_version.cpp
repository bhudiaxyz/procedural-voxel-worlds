#include <functional>

#include "arena/common/log.hpp"
#include "arena/config/version.hpp"

int main() {
    spdlog::info("Project Version: {}", arena::version());
    spdlog::info("Project Version hash: {}", std::hash<std::string>{}(arena::version()));

    return EXIT_SUCCESS;
}
