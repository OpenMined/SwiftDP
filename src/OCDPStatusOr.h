//
//  OCDPStatusOr.h
//  SwiftDP
//
//  Created by Madhava Jay on 1/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatus.h"

@interface OCDPStatusOr : NSObject

// See OCDPStatusOr+CPP.mm for init from C++ side
- (BOOL) ok;
- (OCDPStatus *) status;
- (id) boundingReport;
- (NSNumber *)getValue;
- (double) getDoubleValue;
- (int) getIntValue;

@end
