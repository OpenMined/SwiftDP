//
//  OCDPConfidenceInterval.m
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

#import <Foundation/Foundation.h>

#import "OCDPConfidenceInterval.h"

#include "differential_privacy/proto/data.pb.h"
#include "differential_privacy/proto/util.h"

using namespace differential_privacy;

@interface OCDPConfidenceInterval () {
    ConfidenceInterval *cpp_ConfidenceInterval;
}
- (instancetype) initWithCppConfidenceInterval: (ConfidenceInterval) confidence_interval;
@end

@implementation OCDPConfidenceInterval

- (instancetype) initWithCppConfidenceInterval: (ConfidenceInterval) confidence_interval {
    self = [super init];
    if (self) {
      // Start PIMPL
      cpp_ConfidenceInterval = new ConfidenceInterval(confidence_interval);
      if (!cpp_ConfidenceInterval) {
        self = nil; // destroy Wrapper
      }
      // End PIMPL
    }
    return self;
}

- (double) lower_bound {
    return cpp_ConfidenceInterval->lower_bound();
}

- (double) upper_bound {
    return cpp_ConfidenceInterval->upper_bound();
}

- (double) confidence_level {
    return cpp_ConfidenceInterval->confidence_level();
}

@end
