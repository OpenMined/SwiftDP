//
//  OCDPOutput.h
//  SwiftDP
//
//  Created by Madhava Jay on 5/5/20.
//

#import "OCDPErrorReport.h"
#import <Foundation/Foundation.h>

@interface OCDPOutput : NSObject

- (double)getDouble;
- (int)getInt;
- (nonnull NSString *)DebugString;
- (nullable OCDPErrorReport *)error_report;

@end
