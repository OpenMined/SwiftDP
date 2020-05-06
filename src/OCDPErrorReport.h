//
//  OCDPErrorReport.h
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

#import "OCDPBoundingReport.h"
#import "OCDPConfidenceInterval.h"

@interface OCDPErrorReport : NSObject

- (nullable OCDPBoundingReport *) bounding_report;
- (nullable OCDPConfidenceInterval *) noise_confidence_interval;

@end
