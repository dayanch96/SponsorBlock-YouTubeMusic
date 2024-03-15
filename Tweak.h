#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <YouTubeHeader/GOOAlertView.h>
#import <YouTubeHeader/YTCommonUtils.h>
#import <YouTubeHeader/YTInnerTubeCollectionViewController.h>
#import <YouTubeHeader/YTResponder.h>
#import <YouTubeHeader/YTSettingsSectionController.h>
#import <YouTubeHeader/YTSettingsSectionItem.h>
#import <YouTubeHeader/YTUIUtils.h>
#import <YouTubeMusicHeader/YTMToastController.h>

#import "Utils/NSBundle+YTMSb.h"
#import "Utils/YTMSbUserDefaults.h"

#define LOC(key) ({ \
    NSString *localizedString = [NSBundle.ytmSb_defaultBundle localizedStringForKey:(key) value:nil table:nil]; \
    (localizedString.length > 0) ? localizedString : (key); \
})

#define ytmSbBool(key) [[YTMSbUserDefaults standardUserDefaults] boolForKey:key]
#define ytmSbInt(key) [[YTMSbUserDefaults standardUserDefaults] integerForKey:key]

#define ytmSbSetBool(value, key) [[YTMSbUserDefaults standardUserDefaults] setBool:(value) forKey:(key)]
#define ytmSbSetInt(value, key) [[YTMSbUserDefaults standardUserDefaults] setInteger:(value) forKey:(key)]

@interface YTPlayerViewController : UIViewController
@property (nonatomic, strong) NSMutableDictionary *sponsorBlockValues;

- (void)seekToTime:(CGFloat)time;
- (NSString *)currentVideoID;
- (CGFloat)currentVideoMediaTime;
- (void)skipSegment;
@end

@interface YTActionSheetAction : NSObject
+ (instancetype)actionWithTitle:(NSString *)title iconImage:(UIImage *)image style:(NSInteger)style handler:(void (^)(void))handler;
+ (instancetype)actionWithTitle:(NSString *)title iconImage:(UIImage *)image secondaryIconImage:(UIImage *)secondaryIconImage accessibilityIdentifier:(NSString *)identifier handler:(void (^)(void))handler;
@end

@interface YTActionSheetController : NSObject
@property (nonatomic, strong, readwrite) UIView *sourceView;
- (void)addAction:(YTActionSheetAction *)action;
- (void)addHeaderWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
- (void)presentFromViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void(^)(void))completion;
@end

@interface YTMActionSheetController : YTActionSheetController
+ (instancetype)musicActionSheetController;
@end

@interface GOOHeaderViewController : UIViewController
@end

@interface YTBaseInnerTubeViewController : UIViewController <YTResponder>
@end

@interface YTMBaseInnerTubeViewController : YTBaseInnerTubeViewController
@end

@interface YTMInnerTubeCollectionViewController : YTInnerTubeCollectionViewController
- (void)reloadData;
@end

@interface YTMSettingsResponseViewController : YTMBaseInnerTubeViewController
- (instancetype)initWithService:(id)service parentResponder:(id <YTResponder>)parentResponder;
- (YTMInnerTubeCollectionViewController *)collectionViewController;
- (UIImage *)resizedImageNamed:(NSString *)iconName;
@end

@interface YTMSettingsSectionItem : YTSettingsSectionItem
@property (nonatomic, assign, readwrite, getter=isAsynchronous) BOOL asynchronous;
@end

@interface YTMSettingsSectionController : YTSettingsSectionController <YTResponder>
@property (nonatomic, assign, readwrite) int categoryID;
- (instancetype)initWithTitle:(NSString *)title items:(NSArray <YTMSettingsSectionItem *> *)items parentResponder:(id <YTResponder>)parentResponder;
@end

@interface YTMSettingCollectionSectionController : YTMSettingsSectionController
@end

@interface YTMActionRowView : UIView
@end

@interface MDCButton : UIButton
- (void)ytm_sizeToFitWithSize:(int)arg1;
@end

@interface YTMAlertView : GOOAlertView
@end