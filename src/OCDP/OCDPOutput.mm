//
//  OCDPOutput.mm
//  SwiftDP
//
//  Created by Madhava Jay on 5/5/20.
//

#import "OCDPOutput.h"
#import "OCDPErrorReport.mm"
#import "OCDPUtil.mm"
#import <Foundation/Foundation.h>

#include "differential_privacy/proto/data.pb.h"
#include "differential_privacy/proto/util.h"

using namespace differential_privacy;
using differential_privacy::GetValue;

@interface OCDPOutput () {
  Output *cpp_Output;
}
- (instancetype)initWithCppOutput:(Output)output;
@end

@implementation OCDPOutput

- (instancetype)initWithCppOutput:(Output)output {
  self = [super init];
  if (self) {
    // Start PIMPL
    cpp_Output = new Output(output);
    if (!cpp_Output) {
      self = nil; // destroy Wrapper
    }
    // End PIMPL
  }
  return self;
}

- (double)getDouble {
  return GetValue<double>(*cpp_Output);
}

- (int)getInt {
  return GetValue<int>(*cpp_Output);
}

- (nonnull NSString *)DebugString {
  return [NSString fromCpp:cpp_Output->DebugString()];
}

- (nullable OCDPErrorReport *)error_report {
  Output_ErrorReport cpp_Errorreport = cpp_Output->error_report();
  OCDPErrorReport *objcErrorReport =
      [[OCDPErrorReport alloc] initWithCppErrorReport:cpp_Errorreport];
  return objcErrorReport;
}

@end
