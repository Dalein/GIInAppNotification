//
//  ViewController.m
//  GIInAppNotification
//
//  Created by Gnatyuk Ivan on 14.06.16.
//  Copyright © 2016 Gnatyuk Ivan. All rights reserved.
//

#import "ViewController.h"
#import "GIInAppNotification.h"

@interface ViewController () <GIInAppNotificationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showNotificatonDidTapped:(id)sender {
    
    __block GIInAppNotification * _inAppNotif = [[GIInAppNotification alloc] init];
    _inAppNotif.titleText = @"New message";
    _inAppNotif.subtitleText = @"The Matrix has you";
    _inAppNotif.leftButtonText = @"Done";
    _inAppNotif.rightButtonText = @"Later";
    _inAppNotif.imageName = @"alarm-button";
    _inAppNotif.dismissOnTap = YES;
    
    // If you'll use listenEventsWithBlock: - you don't need delegate
    _inAppNotif.notificationDelegate = self;
    
    [_inAppNotif show];
    
    [_inAppNotif listenEventsWithBlock:^(GIInAppNotificationEvent event) {
        
        switch (event) {
            case GIInAppNotificationEventLeftButton:
                NSLog(@"Left");
                [_inAppNotif dismiss];
                _inAppNotif = nil;
                break;
                
            case GIInAppNotificationEventRightButton:
                NSLog(@"Right");
                [_inAppNotif dismiss];
                _inAppNotif = nil;
                break;
                
            case GIInAppNotificationEventTap:
                NSLog(@"Tap");
                [_inAppNotif dismiss];
                _inAppNotif = nil;
                break;
                
            default:
                break;
        }
    }];
}


#pragma InAppNotification delegate

- (void)inAppNotificationLeftButtonTapped {
    NSLog(@"inAppNotificationLeftButtonTapped");
}

- (void)inAppNotificationRightButtonTapped {
     NSLog(@"inAppNotificationRightButtonTapped");
}

- (void)inAppNotificationTapped {
     NSLog(@"inAppNotificationTapped");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
