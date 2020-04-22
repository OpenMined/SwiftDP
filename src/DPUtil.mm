//
//  DPUtil.mm
//  SwiftDP
//
//  Created by Madhava Jay on 22/4/20.
//

#import <Foundation/Foundation.h>
#include <string>
#include <map>

using namespace std;

class DPUtil {
public:
    static NSNumber* convertToNSInteger(int cpp_int) {
        return [NSNumber numberWithInt:cpp_int];
    }

    static NSString* convertToNSString(string cpp_str) {
        return [NSString stringWithCString:cpp_str.c_str() encoding:[NSString defaultCStringEncoding]];
    }

    static NSDictionary* convertToDictionary(map<string, int> cpp_map) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        for (auto element = cpp_map.begin();
                  element != cpp_map.end(); element++) {
            [dict setObject: DPUtil::convertToNSInteger(element->second)
                  forKey: DPUtil::convertToNSString(element->first)];
        }
        return dict;
    }

    static map<string, int> convertFromDictionary(NSDictionary* objcDict) {
        map<string, int> cpp_map;
        for (id key in objcDict) {
            NSNumber *num = [objcDict objectForKey:key];
            cpp_map.insert(pair<string, int>(string([key UTF8String]), [num intValue]));
        }
        return cpp_map;
    }
};
