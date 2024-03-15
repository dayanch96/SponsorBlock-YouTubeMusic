#import "YTMSbUserDefaults.h"

@implementation YTMSbUserDefaults

static NSString *const kDefaultsSuiteName = @"com.dvntm.ytmsponsorblock";

+ (YTMSbUserDefaults *)standardUserDefaults {
    static dispatch_once_t onceToken;
    static YTMSbUserDefaults *defaults = nil;

    dispatch_once(&onceToken, ^{
        defaults = [[self alloc] initWithSuiteName:kDefaultsSuiteName];
        [defaults registerDefaults];
    });

    return defaults;
}

- (void)registerDefaults {
    [self registerDefaults:@{
        @"sponsorBlock": @YES,
        @"sbSkipMode": @0,
        @"sbDuration": @10
    }];
}

@end
