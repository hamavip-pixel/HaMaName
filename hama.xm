
#import <UIKit/UIKit.h>

static UIView *badgeView = nil;

static void showOfficialBadge() {
    if (badgeView) return;

    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;

    if (!mainWindow) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if (windows.count > 0) {
            mainWindow = windows[0];
        }
    }

    if (!mainWindow) return;

    UILabel *label = [[UILabel alloc] init];
    label.text = @"SONIC⚡VIP";
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];

    CGFloat padX = 20;
    CGFloat padY = 8;
    CGFloat boxWidth = label.frame.size.width + (padX * 2);
    CGFloat boxHeight = label.frame.size.height + (padY * 2);

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, boxWidth, boxHeight)];

    // Background behind SONIC VIP
    container.backgroundColor =
        [UIColor colorWithRed:0.02 green:0.10 blue:0.24 alpha:0.92];

    container.layer.borderColor =
        [UIColor colorWithRed:0.29 green:0.65 blue:1.0 alpha:1.0].CGColor;

    container.layer.borderWidth = 2;
    container.layer.cornerRadius = 30;
    container.clipsToBounds = NO;

    // Blue glow
    container.layer.shadowColor =
        [UIColor colorWithRed:0.10 green:0.55 blue:1.0 alpha:1.0].CGColor;

    container.layer.shadowOffset = CGSizeZero;
    container.layer.shadowRadius = 9;
    container.layer.shadowOpacity = 0.85;

    label.frame = CGRectMake(
        padX,
        padY,
        label.frame.size.width,
        label.frame.size.height
    );

    [container addSubview:label];

    CGFloat centerX = mainWindow.bounds.size.width / 2;
    CGFloat topY = 55;

    container.center = CGPointMake(centerX, topY);

    container.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin;

    [mainWindow addSubview:container];
    badgeView = container;

    // Entrance animation
    container.alpha = 0;
    container.transform = CGAffineTransformMakeScale(0.9, 0.9);

    [UIView animateWithDuration:0.3 animations:^{
        container.alpha = 1;
        container.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

        // Slow up and down movement
        [UIView animateWithDuration:1.8
                              delay:0
                            options:UIViewAnimationOptionAutoreverse |
                                    UIViewAnimationOptionRepeat |
                                    UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            container.transform =
                CGAffineTransformMakeTranslation(0, 7);
        } completion:nil];
    }];
}

%ctor {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
        dispatch_get_main_queue(), ^{
            showOfficialBadge();
        }
    );
}
