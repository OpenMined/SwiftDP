//
//  SwiftDP_CarrotReporter.h
//  SwiftDP-Test-Framework
//
//  Created by Madhava Jay on 20/4/20.
//

#import <Foundation/Foundation.h>

@interface SwiftDP_CarrotReporter: NSObject
- (nonnull instancetype) init;
- (nonnull instancetype) initWithEpsilon: (double) epsilon;

// Replace CSV for convenience
- (NSDictionary*) getCarrotsData;
- (void) setCarrotsData: (NSDictionary *) carrotsAnimal;

// True sum of all the carrots eaten.
- (int) Sum;

// True mean of carrots eaten.
- (double) Mean;

- (int) CountAbove: (int) limit;

// True maximum of the number of carrots eaten by any one animal.
- (int) Max;

// Returns the remaining privacy budget. Animals should check this to see if
// they should answer any more of Farmer Fred's questions.
- (double) PrivacyBudget;

@end
