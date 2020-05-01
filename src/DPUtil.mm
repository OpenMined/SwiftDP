//
//  DPUtil.mm
//  SwiftDP
//
//  Created by Madhava Jay on 22/4/20.
//

#import "OCDPStatus.h"
#include "absl/strings/string_view.h"
#include "differential_privacy/base/statusor.h"
#import <Foundation/Foundation.h>
#include <map>
#include <string>

using namespace std;
using namespace differential_privacy;

#pragma mark - Static C Utils

class DPUtil {
public:
  static NSNumber *convertToNSInteger(int cpp_int) {
    return [NSNumber numberWithInt:cpp_int];
  }

  static NSString *convertToNSString(string cpp_str) {
    return [NSString stringWithCString:cpp_str.c_str()
                              encoding:[NSString defaultCStringEncoding]];
  }

  static NSDictionary<NSString *, NSNumber *> *
  convertToDictionary(map<string, int> cpp_map) {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (auto element = cpp_map.begin(); element != cpp_map.end(); element++) {
      [dict setObject:DPUtil::convertToNSInteger(element->second)
               forKey:DPUtil::convertToNSString(element->first)];
    }
    return dict;
  }

  static map<string, int> convertFromDictionary(NSDictionary *objcDict) {
    map<string, int> cpp_map;
    for (id key in objcDict) {
      NSNumber *num = [objcDict objectForKey:key];
      cpp_map.insert(
          pair<string, int>(string([key UTF8String]), [num intValue]));
    }
    return cpp_map;
  }
};

#pragma mark - NSString

@interface NSString (DPUtils)
+ (instancetype)fromCpp:(string)cpp_str;
+ (instancetype)fromCppStringView:(absl::string_view)cpp_str;
- (string)toCpp;
@end

@implementation NSString (DPUtils)
+ (instancetype)fromCpp:(string)cpp_str {
  return [NSString stringWithCString:cpp_str.c_str()
                            encoding:[NSString defaultCStringEncoding]];
}
+ (instancetype)fromCppStringView:(absl::string_view)cpp_str {
  return [NSString fromCpp:static_cast<std::string>(cpp_str)];
}
- (string)toCpp {
  return string([self UTF8String]);
}
@end

#pragma mark - NSNumber

@interface NSNumber (DPUtils)
+ (instancetype)fromCppInt:(int)cpp_str;
- (int)toCppInt;
@end

@implementation NSNumber (DPUtils)
+ (instancetype)fromCppInt:(int)cpp_int {
  return [NSNumber numberWithInt:cpp_int];
}
- (int)toCppInt {
  return [self intValue];
}
@end

#pragma mark - NSDictionary

@interface NSDictionary (DPUtils)
+ (instancetype)fromCppMap:(map<string, int>)cpp_map;
- (map<string, int>)toCppMap;
@end

@implementation NSDictionary (DPUtils)
+ (instancetype)fromCppMap:(map<string, int>)cpp_map {
  NSMutableDictionary *dict = [NSMutableDictionary new];
  for (auto element = cpp_map.begin(); element != cpp_map.end(); element++) {
    [dict setObject:DPUtil::convertToNSInteger(element->second)
             forKey:DPUtil::convertToNSString(element->first)];
  }
  return dict;
}
- (map<string, int>)toCppMap {
  map<string, int> cpp_map;
  for (id key in self) {
    NSNumber *num = [self objectForKey:key];
    cpp_map.insert(pair<string, int>(string([key UTF8String]), [num intValue]));
  }
  return cpp_map;
}
@end

#pragma mark - OCDPStatus

@interface OCDPStatus (DPUtils)
+ (instancetype)fromCppStatus:(base::Status)cpp_status;
+ (DPStatus)dpStatusFromInt:(NSUInteger)cpp_int;
@end

@implementation OCDPStatus (DPUtils)
+ (instancetype)fromCppStatus:(base::Status)cpp_status {
  DPStatus statusCode = [OCDPStatus dpStatusFromCode:cpp_status.code()];
  NSString *message = [NSString fromCppStringView:cpp_status.message()];
  return [[OCDPStatus alloc] initWithStatus:statusCode AndMessage:message];
}

+ (DPStatus)dpStatusFromCode:(base::StatusCode)code {
  int cpp_int = static_cast<int>(code);
  if (cpp_int < 0 || 20 < cpp_int) {
    cpp_int = 255; // bad enum
  }
  return [self dpStatusFromInt:cpp_int];
}

+ (DPStatus)dpStatusFromInt:(int)cpp_int {
  return (DPStatus)cpp_int;
}

+ (base::StatusCode)dpStatusToCode:(DPStatus)code {
  return static_cast<base::StatusCode>(code);
}

@end
