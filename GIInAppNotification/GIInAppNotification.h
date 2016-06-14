//
//  GIInAppNotification.h
//  RationalApe
//
//  Created by Gnatyuk Ivan on 28.05.16.
//  Copyright © 2016 daleijn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GIInAppNotificationDelegate <NSObject>

@optional
- (void)inAppNotificationLeftButtonTapped;
- (void)inAppNotificationRightButtonTapped;
- (void)inAppNotificationTapped;

@end


@interface GIInAppNotification : UIViewController

typedef NS_ENUM(NSInteger, GIInAppNotificationEvent) {
    GIInAppNotificationEventLeftButton,
    GIInAppNotificationEventRightButton,
    GIInAppNotificationEventTap
};

typedef void (^inAppNotifblock)(GIInAppNotificationEvent event);

@property (nonatomic, strong) id<GIInAppNotificationDelegate> notificationDelegate;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *subtitleText;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *leftButtonText;
@property (nonatomic, strong) NSString *rightButtonText;
@property (nonatomic) BOOL dismissOnTap;

- (void)show;
- (void)dismiss;

- (void)listenEventsWithBlock:(inAppNotifblock)block;

@end
