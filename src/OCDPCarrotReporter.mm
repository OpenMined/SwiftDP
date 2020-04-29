//
//  OCDPCarrotReporter.mm
//  Dummy
//
//  Created by Madhava Jay on 20/4/20.
//

#import "OCDPCarrotReporter.h"
#import "DPUtil.mm"
#import "OCDPStatus.h"
#import <Foundation/Foundation.h>
#include <map>
#include <string>

#import "differential_privacy/algorithms/bounded-sum.h"
#include "differential_privacy/base/statusor.h"
#include "differential_privacy/proto/data.pb.h"

// class extension to hold iVars for PIMPL
@interface OCDPCarrotReporter () {
  std::map<std::string, int> carrots_per_animal_;
  double epsilon_;
  double privacy_budget_;
}

@end

@implementation OCDPCarrotReporter

- (nonnull instancetype)init {
  return [self initWithEpsilon:1 AndData:@{}]; // default value of epsilon
}

- (nonnull instancetype)initWithEpsilon:(double)epsilon
                                AndData:(NSDictionary<NSString *, NSNumber *> *)
                                            data {
  self = [super init];
  if (self) {
    // Start PIMPL
    self->epsilon_ = epsilon;
    self->privacy_budget_ = 1;
    self->carrots_per_animal_ = [data toCppMap];
    // End PIMPL
  }
  return self;
}
- (NSDictionary<NSString *, NSNumber *> *)getCarrotsData {
  return DPUtil::convertToDictionary(carrots_per_animal_);
}

- (void)setCarrotsData:(NSDictionary *)carrotsAnimal {
  self->carrots_per_animal_ = DPUtil::convertFromDictionary(carrotsAnimal);
}

- (int)Sum {
  int sum = 0;
  for (const auto &pair : self->carrots_per_animal_) {
    sum += pair.second;
  }
  return sum;
}

// True mean of carrots eaten.
- (double)Mean {
  return static_cast<double>([self Sum]) / self->carrots_per_animal_.size();
}

- (int)CountAbove:(int)limit {
  int count = 0;
  for (const auto &pair : self->carrots_per_animal_) {
    if (pair.second > limit) {
      ++count;
    }
  }
  return count;
}

// True maximum of the number of carrots eaten by any one animal.
- (int)Max {
  int max = 0;
  for (const auto &pair : carrots_per_animal_) {
    max = std::max(pair.second, max);
  }
  return max;
}

// Returns the remaining privacy budget. Animals should check this to see if
// they should answer any more of Farmer Fred's questions.
- (double)PrivacyBudget {
  return self->privacy_budget_;
}

- (int)PrivateSum:(double)privacy_budget {
  differential_privacy::base::StatusOr<differential_privacy::Output> result =
      [self _PrivateSum:privacy_budget];
  differential_privacy::base::Status status = result.status();

  int code = static_cast<int>(status.code());
  absl::string_view cpp_str_view = status.message();
  std::string cpp_str = static_cast<std::string>(cpp_str_view);
  NSString *str =
      [NSString stringWithCString:cpp_str.c_str()
                         encoding:[NSString defaultCStringEncoding]];

  DPStatus dpCode = (DPStatus)code;

  OCDPStatus *statusCode = [[OCDPStatus alloc] initWithStatus:dpCode
                                                   AndMessage:str];

  NSLog(@"Got back this code: %d %@ %d %@", code, statusCode, [statusCode code],
        [statusCode message]);

  int value = GetValue<int>(result.ValueOrDie());
  return value;
}

- (differential_privacy::base::StatusOr<differential_privacy::Output>)
    _PrivateSum:(double)privacy_budget {
  privacy_budget_ -= privacy_budget;

  ASSIGN_OR_RETURN(
      std::unique_ptr<differential_privacy::BoundedSum<int>> sum_algorithm,
      differential_privacy::BoundedSum<int>::Builder()
          .SetEpsilon(epsilon_)
          .SetLower(0)
          .SetUpper(150)
          .Build());

  for (const auto &pair : carrots_per_animal_) {
    sum_algorithm->AddEntry(pair.second);
  }
  return sum_algorithm->PartialResult(privacy_budget);
}

@end
