//
//  OCDPStatusOr+CPP.m
//  Dummy
//
//  Created by Madhava Jay on 5/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatusOr.mm"
#import "OCDPStatus.h"
#import "OCDPStatus+CPP.mm"

#import "differential_privacy/base/status.h"
#include "differential_privacy/base/statusor.h"
#include "differential_privacy/proto/data.pb.h"

using namespace differential_privacy;

@interface OCDPStatusOr (CPP)
- (instancetype) initWithCppStatusOr: (base::StatusOr<Output>) statusOr;
@end

@implementation OCDPStatusOr (CPP)

- (instancetype) initWithCppStatusOr: (base::StatusOr<Output>) statusOr {
    self = [super init];
    if (self) {
      // Start PIMPL
      cpp_StatusOr = new base::StatusOr<Output>(statusOr);
      base::Status cpp_Status = statusOr.status();
      status = [[OCDPStatus alloc] initWithCppStatus:cpp_Status];
      if (!cpp_StatusOr) {
        self = nil; // destroy Wrapper
      }
      // End PIMPL
    }
    return self;
}

@end
