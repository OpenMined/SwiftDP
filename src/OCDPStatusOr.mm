//
//  OCDPStatusOr.m
//  SwiftDP
//
//  Created by Madhava Jay on 1/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatusOr.h"

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
@end

@implementation OCDPStatusOr

- (BOOL) ok {
    if (status != nil && status.code == DPStatuskOk) {
        return YES;
    }
    return NO;
}

- (OCDPStatus *) status {
    return status;
}

//- (id) boundingReport {
//    return nil;
//}

- (double) getDoubleValue {
    Output output = cpp_StatusOr->ValueOrDie();

    //BoundingReport report = output.error_report().bounding_report();
    return GetValue<double>(output);
}

- (int) getIntValue {
    Output output = cpp_StatusOr->ValueOrDie();
    //BoundingReport report = mean_output.error_report().bounding_report();
    return GetValue<int>(output);
}

- (NSNumber *) getValue {
    return @1;
}

@end
