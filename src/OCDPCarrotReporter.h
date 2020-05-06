//
//  OCDPCarrotReporter.h
//  SwiftDP-Test-Framework
//
//  Created by Madhava Jay on 20/4/20.
//

#import "OCDPStatusOr.h"
#import <Foundation/Foundation.h>

@interface OCDPCarrotReporter : NSObject
- (nonnull instancetype)init;
- (nonnull instancetype)initWithEpsilon:(double)epsilon
                                AndData:(NSDictionary<NSString *, NSNumber *> *)
                                            data;

// Replace CSV for convenience
- (NSDictionary<NSString *, NSNumber *> *)getCarrotsData;
- (void)setCarrotsData:(NSDictionary *)carrotsAnimal;

// True sum of all the carrots eaten.
- (int)Sum;

// True mean of carrots eaten.
- (double)Mean;

- (int)CountAbove:(int)limit;

// True maximum of the number of carrots eaten by any one animal.
- (int)Max;

// Returns the remaining privacy budget. Animals should check this to see if
// they should answer any more of Farmer Fred's questions.
- (double)PrivacyBudget;

- (nonnull OCDPStatusOr *)PrivateSum:(double)privacy_budget;
- (nonnull OCDPStatusOr *)PrivateMean:(double)privacy_budget;
- (nonnull OCDPStatusOr *)PrivateCountAbove:(double)privacy_budget
                                      limit:(int)max;
- (nonnull OCDPStatusOr *)PrivateMax:(double)privacy_budget;

@end
