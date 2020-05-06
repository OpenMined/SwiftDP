//
//  Sandbox.m
//  SwiftDP-App
//
//  Created by Madhava Jay on 14/4/20.
//

#import "Sandbox.h"
#import "string"
#import <Foundation/Foundation.h>

template <typename T> T myMax(T x, T y) { return (x > y) ? x : y; }

@interface Sandbox ()
@end

@implementation Sandbox

- (void)test {
  NSLog(@"%@", @"sandbox");
  int a = myMax<int>(3, 7);
  double b = myMax<double>(3.0, 7.0);
  char c = myMax<char>('g', 'e');
  NSLog(@"got int %i got float %f got char %s", a, b, &c);
}

@end
