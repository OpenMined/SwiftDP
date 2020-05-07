//
//  OCDPErrorReport.m
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

#import "OCDPErrorReport.h"
#import "OCDPBoundingReport.mm"
#import "OCDPConfidenceInterval.mm"
#import <Foundation/Foundation.h>

#include "differential_privacy/proto/data.pb.h"
#include "differential_privacy/proto/util.h"

using namespace differential_privacy;

@interface OCDPErrorReport () {
  Output_ErrorReport *cpp_Errorreport;
}
- (instancetype)initWithCppErrorReport:(Output_ErrorReport)errorreport;
@end

@implementation OCDPErrorReport

- (instancetype)initWithCppErrorReport:(Output_ErrorReport)errorreport {
  self = [super init];
  if (self) {
    // Start PIMPL
    cpp_Errorreport = new Output_ErrorReport(errorreport);
    if (!cpp_Errorreport) {
      self = nil; // destroy Wrapper
    }
    // End PIMPL
  }
  return self;
}

- (nullable OCDPBoundingReport *)bounding_report {
  BoundingReport bounding_report = cpp_Errorreport->bounding_report();
  OCDPBoundingReport *objcBoundingReport =
      [[OCDPBoundingReport alloc] initWithCppBoundingReport:bounding_report];
  return objcBoundingReport;
}

- (nullable OCDPConfidenceInterval *)noise_confidence_interval {
  ConfidenceInterval confidence_interval =
      cpp_Errorreport->noise_confidence_interval();
  OCDPConfidenceInterval *objcConfidenceInterval =
      [[OCDPConfidenceInterval alloc]
          initWithCppConfidenceInterval:confidence_interval];
  return objcConfidenceInterval;
}

@end
