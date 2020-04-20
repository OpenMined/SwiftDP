#import "SwiftDP_rand.h"
#import "differential_privacy/algorithms/rand.h"
@interface SwiftDP_rand ()

@end

@implementation SwiftDP_rand

- (double)UniformDouble {

  return differential_privacy::UniformDouble();
}

- (UInt64)Geometric {
  return differential_privacy::Geometric();
}

@end
