//
//  OCDPStatus+CPP.m
//  SwiftDP
//
//  Created by Madhava Jay on 5/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatus.mm"
#import "differential_privacy/base/status.h"

using namespace differential_privacy;

@interface OCDPStatus (CPP)
- (instancetype) initWithCppStatus: (base::Status) status;
@end

@implementation OCDPStatus (CPP)

- (instancetype) initWithCppStatus: (base::Status) status {
    // Which one is better?
    //    DPStatus dpCode = (DPStatus)status.code();
    //    NSString *message = [NSString fromCppStringView:status.message()];
    //    return [self initWithStatus:dpCode AndMessage:message];

    self = [super init];
    if (self) {
      // Start PIMPL
      cpp_Status = new base::Status(status);
      if (!cpp_Status) {
        self = nil; // destroy Wrapper
      }
      // End PIMPL
    }
    return self;
}

@end
