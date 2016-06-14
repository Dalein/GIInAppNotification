
#GIInAppNotification
Dropdown notification view for iOS

#Demo
![Demo](https://github.com/Dalein/GIInAppNotification/blob/master/demo.gif)

#Example
Interface of the GIInAppNotification created in .xib so you can easy modify it like you want. 
AppNotification is automatically rotate when device rotated, it supports portrait and lanscape appearance. 
To get GIInAppNotification actions (buttons event or tap on view itself) you can use block or subscribe to it's delegate.

```objectivec
__block GIInAppNotification * _inAppNotif = [[GIInAppNotification alloc] init];
_inAppNotif.titleText = @"New message";
_inAppNotif.subtitleText = @"The Matrix has you";
_inAppNotif.leftButtonText = @"Done";
_inAppNotif.rightButtonText = @"Later";
_inAppNotif.imageName = @"alarm-button";
```
If you want to hide the notification by tapping it, set dimissOnTap to YES:

```objectivec
_inAppNotif.dismissOnTap = YES;
```

If you'll use block to get events - you don't need delegate, or you can subscribe to 3 opional delegate methods.

```objectivec
_inAppNotif.notificationDelegate = self;
```

To present it just call:

```objectivec
[_inAppNotif show];
```
There's no difference where you call this from (from NSObject subclass or ViewController) don't worry about view heriacy - it will be added on top of everything.

To handle the buttons events, you can add 3 methods defined by the delegate:

```objectivec
- (void)inAppNotificationLeftButtonTapped {
NSLog(@"inAppNotificationLeftButtonTapped");
}

- (void)inAppNotificationRightButtonTapped {
NSLog(@"inAppNotificationRightButtonTapped");
}

- (void)inAppNotificationTapped {
NSLog(@"inAppNotificationTapped");
}
```

Or you can use block:

```objectivec
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
```

#Usage
Copy GIInAppNotification folder into your project.

# License 
Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:

 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
