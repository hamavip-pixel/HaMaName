
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

static UIView *badgeView = nil;
static AVSpeechSynthesizer *sonicSpeech = nil;

// Function declaration - FIX
static void showOfficialBadge(void);

// SONIC INTRO
static void showSonicIntro(void) {

    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;

    if (!mainWindow) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if (windows.count > 0) {
            mainWindow = windows[0];
        }
    }

    if (!mainWindow) return;

    UIView *introView = [[UIView alloc] initWithFrame:mainWindow.bounds];
    introView.backgroundColor = [UIColor blackColor];
    introView.alpha = 0;
    introView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;

    // Main SONIC VIP text
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"SONIC⚡VIP";
    titleLabel.font = [UIFont systemFontOfSize:35 weight:UIFontWeightHeavy];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
    titleLabel.layer.shadowRadius = 12;
    titleLabel.layer.shadowOpacity = 0.9;
    titleLabel.layer.shadowOffset = CGSizeZero;
    [titleLabel sizeToFit];

    titleLabel.center = CGPointMake(
        introView.bounds.size.width / 2,
        introView.bounds.size.height / 2 - 12
    );

    titleLabel.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;

    [introView addSubview:titleLabel];

    // Blue subtitle
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = @"SONIC ANTIBAN SYSTEM READY";
    subtitleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightBold];
    subtitleLabel.textColor =
        [UIColor colorWithRed:0.20 green:0.58 blue:1.0 alpha:1.0];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.layer.shadowColor =
        [UIColor colorWithRed:0.10 green:0.45 blue:1.0 alpha:1.0].CGColor;
    subtitleLabel.layer.shadowRadius = 8;
    subtitleLabel.layer.shadowOpacity = 0.9;
    subtitleLabel.layer.shadowOffset = CGSizeZero;
    [subtitleLabel sizeToFit];

    subtitleLabel.center = CGPointMake(
        introView.bounds.size.width / 2,
        CGRectGetMaxY(titleLabel.frame) + 28
    );

    subtitleLabel.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;

    [introView addSubview:subtitleLabel];

    [mainWindow addSubview:introView];

    // Welcome voice
    sonicSpeech = [[AVSpeechSynthesizer alloc] init];

    AVSpeechUtterance *utterance =
        [AVSpeechUtterance speechUtteranceWithString:@"Welcome to Sonic VIP"];

    utterance.voice =
        [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];

    utterance.rate = 0.48;
    utterance.pitchMultiplier = 1.0;

    [sonicSpeech speakUtterance:utterance];

    // Intro entrance
    [UIView animateWithDuration:0.7 animations:^{
        introView.alpha = 1.0;
    }];

    // Fade out after 3 seconds
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC),
        dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:1.0 animations:^{
                introView.alpha = 0;
            } completion:^(BOOL finished) {

                [introView removeFromSuperview];

                // Show original badge
                showOfficialBadge();
            }];
        }
    );
}

// ORIGINAL BADGE
static void showOfficialBadge(void) {

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
    container.layer.cornerRadius = 12;
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
    CGFloat topY = 75;

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

// Constructor
%ctor {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC),
        dispatch_get_main_queue(), ^{
            showSonicIntro();
        }
    );
}
