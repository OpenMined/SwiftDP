//
//  OCDPStatusOr.h
//  SwiftDP
//
//  Created by Madhava Jay on 1/5/20.
//

#import "OCDPOutput.h"
#import "OCDPStatus.h"
#import <Foundation/Foundation.h>

@interface OCDPStatusOr : NSObject

- (BOOL)ok;
- (nonnull OCDPStatus *)status;
- (id)boundingReport;
- (nullable OCDPOutput *)value;

@end
