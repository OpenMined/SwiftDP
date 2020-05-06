//
//  OCDPBoundingReport.h
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

@interface OCDPBoundingReport : NSObject

- (int) lower_bound;
- (int) upper_bound;
- (double) num_inputs;
- (double) num_outside;

@end
