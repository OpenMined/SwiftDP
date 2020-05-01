#import "OCDPStatus.h"
#import "DPUtil.mm"
#import "differential_privacy/base/status.h"

using namespace differential_privacy;

@interface OCDPStatus () {
  base::Status *cpp_Status;
}
@end

@implementation OCDPStatus

- (instancetype)initWithStatus:(DPStatus)code AndMessage:(NSString *)message {
  self = [super init];
  if (self) {
    // Start PIMPL
    cpp_Status =
        new base::Status([OCDPStatus dpStatusToCode:code], [message toCpp]);
    if (!cpp_Status) {
      self = nil; // destroy Wrapper
    }
    // End PIMPL
  }
  return self;
}

- (NSString *)toString {
  return [NSString fromCppStringView:cpp_Status->ToString()];
}

- (DPStatus)code {
  return [OCDPStatus dpStatusFromCode:cpp_Status->code()];
}

- (NSString *)message {
  return [NSString fromCppStringView:cpp_Status->message()];
}

- (void)dealloc {
  delete cpp_Status;
}

@end
