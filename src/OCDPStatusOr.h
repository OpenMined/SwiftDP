//
//  OCDPStatusOr.h
//  SwiftDP
//
//  Created by Madhava Jay on 1/5/20.
//

#import <Foundation/Foundation.h>
#import "OCDPStatus.h"
#import "OCDPOutput.h"

@interface OCDPStatusOr : NSObject

- (BOOL) ok;
- (nonnull OCDPStatus *) status;
- (id) boundingReport;
- (nullable OCDPOutput *) value;

@end
