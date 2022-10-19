#include <functional>
#include <iostream>

#include "arena/config/version.hpp"

using namespace std;

int main() {
    std::cout << "Project Version: " << arena::version() << std::endl;
    std::cout << "Project Version hash: " << std::hash<std::string>{}(arena::version()) << std::endl;

    return 0;
}
