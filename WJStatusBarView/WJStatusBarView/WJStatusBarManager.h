//
//  WJStatusBarManager
//  WJStatusBarView
//
//  Created by wujian on 6/8/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^statusBarCall)();

@interface WJStatusBarManager : NSObject

+ (WJStatusBarManager *)sharedInstance;

- (void)showStatusBarWithTitle:(NSString *)title;
- (void)showStatusBarWithTitle:(NSString *)title callback:(statusBarCall)callback;

- (void)showStatusBarWithTitle:(NSString *)title forDuration:(float)duration;
- (void)showStatusBarWithTitle:(NSString *)title forDuration:(float)duration callback:(statusBarCall)callback;

- (void)hideAll;
@end
