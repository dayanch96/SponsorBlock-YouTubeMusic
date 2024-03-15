#import "Tweak.h"

static UIImage *YTImageNamed(NSString *imageName) {
    CGRect rect = CGRectMake(0, 0, 24, 24);
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:rect.size];
    UIImage *clear = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [[UIColor clearColor] setFill];
        [rendererContext fillRect:rect];
    }];

    return imageName == nil ? clear : [UIImage imageNamed:imageName inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
}

// https://github.com/PoomSmart/Return-YouTube-Music-Dislikes/blob/main/Settings.x (@PoomSmart)
%hook YTMSettingsResponseViewController

- (NSArray <YTMSettingsSectionController *> *)sectionControllersFromSettingsResponse:(id)response {
    NSMutableArray <YTMSettingsSectionController *> *newSectionControllers = [NSMutableArray arrayWithArray:%orig];
    YTMSettingsSectionItem *settingMenuItem = [%c(YTMSettingsSectionItem) itemWithTitle:@(TWEAK_NAME) accessibilityIdentifier:nil detailTextBlock:nil selectBlock:^BOOL(YTSettingsCell *cell, NSUInteger arg1) { return YES; }];
    settingMenuItem.indicatorIconType = 221;
    settingMenuItem.inkEnabled = YES;
    settingMenuItem.selectBlock = ^BOOL(YTSettingsCell *cell, NSUInteger arg1) {
        YTMSettingsResponseViewController *responseVC = [[%c(YTMSettingsResponseViewController) alloc] initWithService:[self valueForKey:@"_service"] parentResponder:self];
        responseVC.title = @(TWEAK_NAME);
        NSMutableArray <YTMSettingsSectionItem *> *settingItems = [NSMutableArray new];

        YTMSettingsSectionItem *enabled = [%c(YTMSettingsSectionItem) switchItemWithTitle:LOC(@"Enabled")
        switchOn:ytmSbBool(@"sponsorBlock")
        switchBlock:^BOOL (YTSettingsCell *cell, BOOL enabled) {
            ytmSbSetBool(enabled, @"sponsorBlock");
            return YES;
        }];

        [settingItems addObject:enabled];

        YTMSettingsSectionItem *behavior = [%c(YTMSettingsSectionItem) itemWithTitle:LOC(@"Behavior")
        titleDescription:LOC(@"BehaviorDesc")
        accessibilityIdentifier:nil
        detailTextBlock:^NSString *() {
            NSArray *behaviorLabels = @[LOC(@"Skip"), LOC(@"Ask")];
            return behaviorLabels[ytmSbInt(@"sbSkipMode")];
        }
        selectBlock:^BOOL (YTSettingsCell *cell, NSUInteger arg1) {

            YTMActionSheetController *sheetController = [%c(YTMActionSheetController) musicActionSheetController];
            [sheetController addHeaderWithTitle:LOC(@"SelectBehavior") subtitle:nil];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:LOC(@"Skip") iconImage:ytmSbInt(@"sbSkipMode") == 0 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(0, @"sbSkipMode");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:LOC(@"Ask") iconImage:ytmSbInt(@"sbSkipMode") == 1 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(1, @"sbSkipMode");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController presentFromViewController:responseVC animated:YES completion:nil];

            return YES;
        }];

        [settingItems addObject:behavior];

        YTMSettingsSectionItem *duration = [%c(YTMSettingsSectionItem) itemWithTitle:LOC(@"Duration")
        titleDescription:LOC(@"DurationDesc")
        accessibilityIdentifier:nil
        detailTextBlock:^NSString *() {
            NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
            formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
            return [formatter stringFromTimeInterval:ytmSbInt(@"sbDuration")];
        }
        selectBlock:^BOOL (YTSettingsCell *cell, NSUInteger arg1) {
            NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
            formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;

            YTMActionSheetController *sheetController = [%c(YTMActionSheetController) musicActionSheetController];
            [sheetController addHeaderWithTitle:LOC(@"SelectDuration") subtitle:nil];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:[formatter stringFromTimeInterval:3] iconImage:ytmSbInt(@"sbDuration") == 3 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(3, @"sbDuration");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:[formatter stringFromTimeInterval:5] iconImage:ytmSbInt(@"sbDuration") == 5 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(5, @"sbDuration");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:[formatter stringFromTimeInterval:10] iconImage:ytmSbInt(@"sbDuration") == 10 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(10, @"sbDuration");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:[formatter stringFromTimeInterval:15] iconImage:ytmSbInt(@"sbDuration") == 15 ? YTImageNamed(@"yt_outline_check_24pt") : YTImageNamed(nil) style:0 handler:^ {
                ytmSbSetInt(15, @"sbDuration");

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[responseVC collectionViewController] reloadData];
                });
            }]];

            [sheetController presentFromViewController:responseVC animated:YES completion:nil];

            return YES;
        }];

        [settingItems addObject:duration];

        YTMSettingsSectionItem *space = [%c(YTMSettingsSectionItem) itemWithTitle:nil titleDescription:nil accessibilityIdentifier:nil detailTextBlock:nil selectBlock:nil];
        [settingItems addObject:space];

        YTMSettingsSectionItem *dev = [%c(YTMSettingsSectionItem) itemWithTitle:LOC(@"Developer")
        titleDescription:nil
        accessibilityIdentifier:nil
        detailTextBlock:^NSString *() {
            return @"@Dayanch96";
        }
        selectBlock:^BOOL (YTSettingsCell *cell, NSUInteger arg1) {
            return [%c(YTUIUtils) openURL:[NSURL URLWithString:@"https://twitter.com/dayanch96"]];
        }];

        [settingItems addObject:dev];

        YTMSettingsSectionItem *support = [%c(YTMSettingsSectionItem) itemWithTitle:LOC(@"Support")
        titleDescription:nil
        accessibilityIdentifier:nil
        detailTextBlock:^NSString *() {
            return @"♡";
        }
        selectBlock:^BOOL (YTSettingsCell *cell, NSUInteger arg1) {

            YTMActionSheetController *sheetController = [%c(YTMActionSheetController) musicActionSheetController];
            [sheetController addHeaderWithTitle:LOC(@"Support") subtitle:nil];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:@"PayPal" iconImage:[self resizedImageNamed:@"paypal"] secondaryIconImage:nil accessibilityIdentifier:nil handler:^ {
                [%c(YTUIUtils) openURL:[NSURL URLWithString:@"https://paypal.me/dayanch96"]];
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:@"Github Sponsors" iconImage:[self resizedImageNamed:@"github"] secondaryIconImage:nil accessibilityIdentifier:nil handler:^ {
                [%c(YTUIUtils) openURL:[NSURL URLWithString:@"https://github.com/sponsors/dayanch96"]];
            }]];

            [sheetController addAction:[%c(YTActionSheetAction) actionWithTitle:@"Buy Me a Coffee" iconImage:[self resizedImageNamed:@"coffee"] secondaryIconImage:nil accessibilityIdentifier:nil handler:^ {
                [%c(YTUIUtils) openURL:[NSURL URLWithString:@"https://www.buymeacoffee.com/dayanch96"]];
            }]];

            [sheetController presentFromViewController:responseVC animated:YES completion:nil];

            return YES;
        }];

        [settingItems addObject:support];

        YTMSettingCollectionSectionController *scsc = [[%c(YTMSettingCollectionSectionController) alloc] initWithTitle:@"" items:settingItems parentResponder:responseVC];
        [responseVC collectionViewController].sectionControllers = @[scsc];
        GOOHeaderViewController *headerVC = [[%c(GOOHeaderViewController) alloc] initWithContentViewController:responseVC];
        [self.navigationController pushViewController:headerVC animated:YES];
        return YES;
    };

    YTMSettingsSectionController *settings = [[%c(YTMSettingsSectionController) alloc] initWithTitle:@"" items:@[settingMenuItem] parentResponder:[self parentResponder]];
    settings.categoryID = 'ytsb';
    [newSectionControllers insertObject:settings atIndex:0];

    return newSectionControllers;
}

%new
- (UIImage *)resizedImageNamed:(NSString *)iconName {

    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(32, 32)];
    UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[NSBundle.ytmSb_defaultBundle pathForResource:iconName ofType:@"png"]]];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.clipsToBounds = YES;
        iconImageView.frame = imageView.bounds;

        [imageView addSubview:iconImageView];
        [imageView.layer renderInContext:rendererContext.CGContext];
    }];

    return image;
}

%end