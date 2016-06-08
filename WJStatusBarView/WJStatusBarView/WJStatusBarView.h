//
//  WJStatusBarView.h
//  WJStatusBarView
//
//  Created by wujian on 6/8/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import <UIKit/UIKit.h>
#define STATUS_BAR_HEIGHT               [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_SIZE                     [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH                    SCREEN_SIZE.width
#define SCREEN_HEIGHT                   SCREEN_SIZE.height

@class WJStatusBarView;
@protocol WJStatusBarViewDelegate <NSObject>

- (void)animationFinished:(WJStatusBarView *)statusBar;

- (void)statusBarViewClicked:(WJStatusBarView *)statusBar;

@end
@interface WJStatusBarView : UIWindow

@property (nonatomic, assign) float duration;
@property (nonatomic, assign) BOOL hasCallback;
@property (nonatomic, strong) NSArray *callbacks;

- (id)initWithTitle:(NSString*)title;

@property (nonatomic, weak)  id <WJStatusBarViewDelegate> delegate;
- (void)beganAnimation;

@end
