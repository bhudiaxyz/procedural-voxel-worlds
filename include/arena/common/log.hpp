#ifndef _ARENA_COMMON_LOG_HPP_
#define _ARENA_COMMON_LOG_HPP_

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

inline void logger_init() {
#ifndef NDEBUG
    spdlog::set_level(spdlog::level::debug);
#endif
}

}  // namespace arena


#endif  // _ARENA_COMMON_LOG_HPP_
