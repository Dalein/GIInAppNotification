//
//  GIInAppNotification.m
//  RationalApe
//
//  Created by Gnatyuk Ivan on 28.05.16.
//  Copyright © 2016 daleijn. All rights reserved.
//

#import "GIInAppNotification.h"

@interface GIInAppNotification ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (nonatomic, copy) inAppNotifblock internalBlock;

@end

@implementation GIInAppNotification {
    UIVisualEffectView *blurView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel.text = _titleText;
    _subtitleLabel.text = _subtitleText;
    [_leftButton setTitle:_leftButtonText forState:UIControlStateNormal];
    [_rightButton setTitle:_rightButtonText forState:UIControlStateNormal];
    _imageView.image = [UIImage imageNamed:_imageName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSelfFrames)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    [self configBtnUI:_leftButton];
    [self configBtnUI:_rightButton];
}

- (void)configBtnUI:(UIButton *)btn {
    [btn.layer setCornerRadius:3];
    //[btn.layer setBorderWidth:1];
    //[btn.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [btn.layer setMasksToBounds:YES];
}

- (void)updateSelfFrames {
    float _width = [[UIScreen mainScreen] bounds].size.width;
    float _height = [[UIScreen mainScreen] bounds].size.height;
    
    float baseHeight = 99.0; // Height of view without heights of labels
    float titleIntrHeight = _titleLabel.intrinsicContentSize.height;
    float subTitleIntrHeight = _subtitleLabel.intrinsicContentSize.height;
    float finalViewHeight = MIN((baseHeight + titleIntrHeight + subTitleIntrHeight), _height);
    
    CGRect frame = self.view.frame;
    frame.size.width = _width;
    frame.size.height = finalViewHeight;
    self.view.frame = frame;
    blurView.frame = frame;
}


#pragma UIView appearance control

- (void)show {
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self.view];
    
    UIVisualEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    blurView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
    [self.view insertSubview:blurView belowSubview:_viewContainer];
    
    [self showView:YES];
    
    _internalBlock = ^(GIInAppNotificationEvent event) {};
    
    if (_dismissOnTap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnNotifView)];
        tap.numberOfTapsRequired = 1;
        [self.view addGestureRecognizer:tap];
    }
}

- (void)tappedOnNotifView {
    [self.notificationDelegate inAppNotificationTapped];
    
    if (_internalBlock) {
        _internalBlock(GIInAppNotificationEventTap);
    }
}

- (void)showView:(BOOL)show {
    CGAffineTransform transformInitial = show ? CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.view.frame)) : CGAffineTransformIdentity;
    CGAffineTransform transformFinal = show ? CGAffineTransformIdentity :  CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.view.frame));
    
    self.view.transform = transformInitial;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = transformFinal;
    } completion:^(BOOL finished) {
        if (!show) {
            [self.view removeFromSuperview];
        }
    }];

}

- (void)dismiss {
    [self showView:NO];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self updateSelfFrames];
}


#pragma Buttons actions

- (IBAction)leftBtnTapped:(id)sender {
    [self.notificationDelegate inAppNotificationLeftButtonTapped];
    
    if (_internalBlock) {
        _internalBlock(GIInAppNotificationEventLeftButton);
    }
}

- (IBAction)rightBtnTapped:(id)sender {
    [self.notificationDelegate inAppNotificationRightButtonTapped];
    
    if (_internalBlock) {
        _internalBlock(GIInAppNotificationEventRightButton);
    }
}


- (void)listenEventsWithBlock:(inAppNotifblock)block {
    
    _internalBlock = ^(GIInAppNotificationEvent event) {
        
        if (block) {
            block(event);
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"__%@__ dealloc", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

@end
