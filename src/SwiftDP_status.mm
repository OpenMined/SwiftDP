#import "SwiftDP_status.h"
#import "differential_privacy/base/status.h"

@interface SwiftDP_status () {
  differential_privacy::base::Status *cpp_Status;
}
@end

@implementation SwiftDP_status

- (instancetype)initWithStatus:(DPStatus)code AndMessage:(NSString *)message {
  self = [super init];
  if (self) {
    // Start PIMPL
    NSLog(@"obj-c vars coming in to init: %d %@", code, message);

    std::string cpp_message = std::string([message UTF8String]);
    differential_privacy::base::StatusCode initCode =
        static_cast<differential_privacy::base::StatusCode>(code);

    printf("cpp vars going into init ", message, initCode);

    cpp_Status = new differential_privacy::base::Status(initCode, cpp_message);
    if (!cpp_Status) {
      self = nil; // destroy Wrapper
    }

    // End PIMPL
  }
  return self;
}

- (NSString *)toString {
  std::string cpp_str = cpp_Status->ToString();

  NSString *str =
      [NSString stringWithCString:cpp_str.c_str()
                         encoding:[NSString defaultCStringEncoding]];

  return str;
}

- (int)code {
  return static_cast<int>(cpp_Status->code());
}

- (NSString *)message {

  absl::string_view cpp_str_view = cpp_Status->message();
  std::string cpp_str = static_cast<std::string>(cpp_str_view);
  NSString *str =
      [NSString stringWithCString:cpp_str.c_str()
                         encoding:[NSString defaultCStringEncoding]];
  return str;
}

- (void)dealloc {
  delete cpp_Status;
}

@end
