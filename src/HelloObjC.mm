//
//  HelloObjC.mm
//  test
//
//  Created by Madhava Jay on 8/4/20.
//  Copyright © 2020 openmined.org. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HelloObjC.h"
#import "lib/HelloWorld.h"

/*
 Don't forget the Objective-C++ Bridge needs to be an .mm file to mix types
 */

@interface HelloObjC()

@end

@implementation HelloObjC

- (NSString *) hello: (NSString *) name {
    std::string name_str = std::string([name UTF8String]);
    std::string response = HelloWorld::get_greet(name_str);
    NSString *helloStr = [NSString stringWithCString:response.c_str() encoding:[NSString defaultCStringEncoding]];
    [NSString stringWithFormat:@"Got: %@", helloStr];
    return helloStr;
}


@end
