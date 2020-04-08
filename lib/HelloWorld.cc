//
//  HelloWorld.cpp
//  test
//
//  Created by Madhava Jay on 8/4/20.
//  Copyright © 2020 openmined.org. All rights reserved.
//

#include "HelloWorld.h"
#include <string>

std::string HelloWorld::get_greet(const std::string& who) {
    return "C++ Says Hello " + who;
}
