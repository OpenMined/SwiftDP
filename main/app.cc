#include "lib/HelloWorld.h"
#include <iostream>
#include <string>

int main(int argc, char **argv)
{
    std::string who = "Alice";
    if (argc > 1)
    {
        who = argv[1];
    }
    std::cout << HelloWorld::get_greet(who) << std::endl;
    return 0;
}
