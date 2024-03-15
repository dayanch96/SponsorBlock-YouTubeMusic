#import "NSBundle+YTMSb.h"

@implementation NSBundle (YTMSb)

+ (NSBundle *)ytmSb_defaultBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *tweakBundlePath = [[NSBundle mainBundle] pathForResource:@"YTMSponsorBlock" ofType:@"bundle"];
        NSString *rootlessBundlePath = ROOT_PATH_NS("/Library/Application Support/YTMSponsorBlock.bundle");

        bundle = [NSBundle bundleWithPath:tweakBundlePath ?: rootlessBundlePath];
    });

    return bundle;
}

@end