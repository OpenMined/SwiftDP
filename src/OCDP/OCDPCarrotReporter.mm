//
//  OCDPCarrotReporter.mm
//  SwiftDP
//
//  Created by Madhava Jay on 20/4/20.
//

#import "OCDPCarrotReporter.h"
#import "OCDPStatus.mm"
#import "OCDPStatusOr.mm"
#import "OCDPUtil.mm"
#import <Foundation/Foundation.h>

#import "differential_privacy/algorithms/bounded-mean.h"
#import "differential_privacy/algorithms/bounded-sum.h"
#import "differential_privacy/algorithms/count.h"
#include "differential_privacy/algorithms/order-statistics.h"
#include "differential_privacy/base/canonical_errors.h"
#include "differential_privacy/base/statusor.h"
#include "differential_privacy/proto/data.pb.h"
#include <map>
#include <string>

using namespace differential_privacy;

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

- (nonnull OCDPStatusOr *)PrivateSum:(double)privacy_budget {
  base::StatusOr<Output> result = [self _PrivateSum:privacy_budget];
  OCDPStatusOr *statusOr = [[OCDPStatusOr alloc] initWithCppStatusOr:result];
  return statusOr;
}

- (base::StatusOr<Output>)_PrivateSum:(double)privacy_budget {
  privacy_budget_ -= privacy_budget;

  if (privacy_budget_ < privacy_budget) {
    return base::InvalidArgumentError("Not enough privacy budget.");
  }

  ASSIGN_OR_RETURN(std::unique_ptr<BoundedSum<int>> sum_algorithm,
                   BoundedSum<int>::Builder()
                       .SetEpsilon(epsilon_)
                       .SetLower(0)
                       .SetUpper(150)
                       .Build());

  for (const auto &pair : carrots_per_animal_) {
    sum_algorithm->AddEntry(pair.second);
  }
  return sum_algorithm->PartialResult(privacy_budget);
}

- (nonnull OCDPStatusOr *)PrivateMean:(double)privacy_budget {
  base::StatusOr<Output> result = [self _PrivateMean:privacy_budget];
  OCDPStatusOr *statusOr = [[OCDPStatusOr alloc] initWithCppStatusOr:result];
  return statusOr;
}

- (base::StatusOr<Output>)_PrivateMean:(double)privacy_budget {
  if (privacy_budget_ < privacy_budget) {
    return base::InvalidArgumentError("Not enough privacy budget.");
  }
  privacy_budget_ -= privacy_budget;
  ASSIGN_OR_RETURN(std::unique_ptr<BoundedMean<int>> mean_algorithm,
                   BoundedMean<int>::Builder().SetEpsilon(epsilon_).Build());
  for (const auto &pair : carrots_per_animal_) {
    mean_algorithm->AddEntry(pair.second);
  }
  return mean_algorithm->PartialResult(privacy_budget);
}

- (nonnull OCDPStatusOr *)PrivateCountAbove:(double)privacy_budget
                                      limit:(int)max {
  base::StatusOr<Output> result = [self _PrivateCountAbove:privacy_budget
                                                     limit:max];
  OCDPStatusOr *status = [[OCDPStatusOr alloc] initWithCppStatusOr:result];
  return status;
}

- (base::StatusOr<Output>)_PrivateCountAbove:(double)privacy_budget
                                       limit:(int)max {
  if (privacy_budget_ < privacy_budget) {
    return base::InvalidArgumentError("Not enough privacy budget.");
  }
  privacy_budget_ -= privacy_budget;
  ASSIGN_OR_RETURN(std::unique_ptr<Count<std::string>> count_algorithm,
                   Count<std::string>::Builder().SetEpsilon(epsilon_).Build());

  for (const auto &pair : carrots_per_animal_) {
    if (pair.second > max) {
      count_algorithm->AddEntry(pair.first);
    }
  }
  return count_algorithm->PartialResult(privacy_budget);
}

- (nonnull OCDPStatusOr *)PrivateMax:(double)privacy_budget {
  base::StatusOr<Output> result = [self _PrivateMax:privacy_budget];
  OCDPStatusOr *status = [[OCDPStatusOr alloc] initWithCppStatusOr:result];
  return status;
}

- (base::StatusOr<Output>)_PrivateMax:(double)privacy_budget {
  if (privacy_budget_ < privacy_budget) {
    return base::InvalidArgumentError("Not enough privacy budget.");
  }
  privacy_budget_ -= privacy_budget;
  ASSIGN_OR_RETURN(std::unique_ptr<continuous::Max<int>> max_algorithm,
                   continuous::Max<int>::Builder()
                       .SetEpsilon(epsilon_)
                       .SetLower(0)
                       .SetUpper(150)
                       .Build());
  for (const auto &pair : carrots_per_animal_) {
    max_algorithm->AddEntry(pair.second);
  }
  return max_algorithm->PartialResult(privacy_budget);
}

@end
