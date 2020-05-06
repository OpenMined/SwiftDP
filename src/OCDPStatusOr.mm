//
//  OCDPStatusOr.m
//  SwiftDP
//
//  Created by Madhava Jay on 1/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatusOr.h"
#import "OCDPStatus.mm"
#import "OCDPOutput.mm"

#import "differential_privacy/base/status.h"
#include "differential_privacy/base/statusor.h"
#include "differential_privacy/proto/data.pb.h"
#include "differential_privacy/proto/util.h"


using namespace differential_privacy;
using differential_privacy::GetValue;

@interface OCDPStatusOr () {
    OCDPStatus *status;
    base::StatusOr<Output> *cpp_StatusOr;
}
- (instancetype) initWithCppStatusOr: (base::StatusOr<Output>) statusOr;
@end

@implementation OCDPStatusOr

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

- (BOOL) ok {
    if (status != nil && status.code == DPStatuskOk) {
        return YES;
    }
    return NO;
}

- (OCDPStatus *) status {
    return status;
}

- (double) getDouble {
    Output output = cpp_StatusOr->ValueOrDie();
    return GetValue<double>(output);
}

- (nullable OCDPOutput *) value {
    Output output = cpp_StatusOr->ValueOrDie();
    OCDPOutput *objcOutput = [[OCDPOutput alloc] initWithCppOutput:output];
    return objcOutput;
}

@end


