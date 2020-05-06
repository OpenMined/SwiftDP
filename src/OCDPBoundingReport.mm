//
//  OCDPBoundingReport.m
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPBoundingReport.h"

#include "differential_privacy/proto/data.pb.h"
#include "differential_privacy/proto/util.h"

using namespace differential_privacy;

@interface OCDPBoundingReport () {
    BoundingReport *cpp_Boundingreport;
}
- (instancetype) initWithCppBoundingReport: (BoundingReport) bounding_report;
@end

@implementation OCDPBoundingReport

- (instancetype) initWithCppBoundingReport: (BoundingReport) bounding_report {
    self = [super init];
    if (self) {
      // Start PIMPL
      cpp_Boundingreport = new BoundingReport(bounding_report);
      if (!cpp_Boundingreport) {
        self = nil; // destroy Wrapper
      }
      // End PIMPL
    }
    return self;
}

- (int) lower_bound {
    ValueType lb = cpp_Boundingreport->lower_bound();
    return GetValue<int>(lb);
}

- (int) upper_bound {
    ValueType ub = cpp_Boundingreport->upper_bound();
    return GetValue<int>(ub);
}

- (double) num_inputs {
    return cpp_Boundingreport->num_inputs();
}

- (double) num_outside {
    return cpp_Boundingreport->num_outside();
}

@end
