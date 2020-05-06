#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DPStatus) {
  DPStatuskOk = 0,
  DPStatuskCancelled = 1,
  DPStatuskUnknown = 2,
  DPStatuskInvalidArgument = 3,
  DPStatuskDeadlineExceeded = 4,
  DPStatuskNotFound = 5,
  DPStatuskAlreadyExists = 6,
  DPStatuskPermissionDenied = 7,
  DPStatuskResourceExhausted = 8,
  DPStatuskFailedPrecondition = 9,
  DPStatuskAborted = 10,
  DPStatuskOutOfRange = 11,
  DPStatuskUnimplemented = 12,
  DPStatuskInternal = 13,
  DPStatuskUnavailable = 14,
  DPStatuskDataLoss = 15,
  DPStatuskUnauthenticated = 17,
  DPStatuskDoNotUseReservedForFutureExpansionUseDefaultInSwitchInstead_ = 20,
  DPStatuskSWIFTDPEnumMatchNotFound = 255
};

@interface OCDPStatus : NSObject
- (nonnull NSString *)toString;
- (nonnull NSString *)message;
- (DPStatus)code;
- (nullable instancetype)initWithStatus:(DPStatus)code
                             AndMessage:(NSString *)message;

@end
