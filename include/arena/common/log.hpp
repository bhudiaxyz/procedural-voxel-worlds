#ifndef _ARENA_COMMON_LOG_HPP_
#define _ARENA_COMMON_LOG_HPP_

#include <filesystem>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_sinks.h>
#include <spdlog/sinks/stdout_color_sinks.h>

// auto prog = std::filesystem::path(argv[0]);
//
// // Use context logger (stdout, multi-threaded, colored)
// auto console = spdlog::stdout_color_mt("console");
// console->info("Welcome to spdlog - {} [{}]!", prog.filename().string(), prog.parent_path().string());
//
// // Use the default [context-less] logger (stdout, multi-threaded, colored)
// spdlog::info("Welcome to spdlog - {} [{}]!", prog.filename().string(), prog.parent_path().string());

namespace arena {

static inline void logger_init(char const *prog_name = nullptr) {
#ifndef NDEBUG
    spdlog::set_level(spdlog::level::debug);
#endif

    // Log start-up
    if (prog_name != nullptr) {
        auto prog = std::filesystem::path(prog_name);
#ifndef NDEBUG
        spdlog::info("Starting {} [from {}]", prog.filename().c_str(), prog.parent_path().c_str());
#else
        spdlog::info("Starting {}", prog.filename().c_str());
#endif
    }
}

}  // namespace arena

#endif  // _ARENA_COMMON_LOG_HPP_
