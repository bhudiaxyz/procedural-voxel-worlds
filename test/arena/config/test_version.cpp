#include <sstream>

#include <gtest/gtest.h>

#include "arena/config/project_version.hpp"
#include "arena/config/version.hpp"

using namespace std;

// Demonstrate some basic assertions.
TEST(ArenaVersionTest, BasicAssertions) {
    // Expect equality.
    EXPECT_STREQ(arena::version().c_str(), PROJECT_VERSION);

    // Expect equality.
    ostringstream oss;
    oss << PROJECT_VERSION_MAJOR << "." << PROJECT_VERSION_MINOR << "." << PROJECT_VERSION_PATCH << ends;

    EXPECT_EQ(arena::version(), oss.str());

    // Expect equality.
    EXPECT_EQ(7 * 6, 42);
}
