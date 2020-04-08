//
//  HelloWorld.hpp
//  test
//
//  Created by Madhava Jay on 8/4/20.
//  Copyright © 2020 openmined.org. All rights reserved.
//

#ifndef HelloWorld_hpp
#define HelloWorld_hpp

#include <stdio.h>
#include <string>

class HelloWorld {
public:
    static std::string get_greet(const std::string &thing);
};


#endif /* HelloWorld_hpp */
