#include <sstream>

#include "arena/config/project_version.hpp"
#include "arena/config/version.hpp"

using namespace std;

string arena::version() {
    ostringstream oss;

    oss << PROJECT_VERSION << ends;

    return oss.str();
}
