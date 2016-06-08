//
//  WJStatusBarManager.m
//  WJStatusBarView
//
//  Created by wujian on 6/8/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import "WJStatusBarManager.h"
#import <QuartzCore/QuartzCore.h>
#import "WJStatusBarView.h"

#define KStatusBarViewDisplayDelay 7.0f

@interface WJStatusBarManager ()<WJStatusBarViewDelegate>

@property (nonatomic, strong) NSMutableArray *statusBarQueue;
@property (nonatomic, assign, getter = isstatusBarVisible) BOOL statusBarVisible;


- (void)showNextStatusBar;

@end

@implementation WJStatusBarManager

@synthesize statusBarQueue = _statusBarQueue;
@synthesize statusBarVisible = _statusBarVisible;

#pragma mark - Singleton

+ (WJStatusBarManager *)sharedInstance
{
    static dispatch_once_t pred;
    static WJStatusBarManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _statusBarQueue = [[NSMutableArray alloc] init];
        _statusBarVisible = NO;
    }
    return self;
}

#pragma mark - Public

- (void)showStatusBarWithTitle:(NSString *)title
{
    [self showStatusBarWithTitle:title forDuration:KStatusBarViewDisplayDelay callback:nil];
}

- (void)showStatusBarWithTitle:(NSString *)title forDuration:(float)duration
{
    [self showStatusBarWithTitle:title forDuration:duration callback:nil];
}

- (void)showStatusBarWithTitle:(NSString *)title callback:(statusBarCall)callback
{
    [self showStatusBarWithTitle:title forDuration:KStatusBarViewDisplayDelay callback:callback];
}

- (void)showStatusBarWithTitle:(NSString *)title forDuration:(float)duration callback:(statusBarCall)callback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        WJStatusBarView *statusBarView = [[WJStatusBarView alloc] initWithTitle:title];
        statusBarView.callbacks = callback ? [NSArray arrayWithObject:callback] : [NSArray array];
        statusBarView.hasCallback = callback ? YES : NO;
        statusBarView.duration = duration;
        statusBarView.hidden = YES;
        [_statusBarQueue addObject:statusBarView];
        
        if (!_statusBarVisible){
            [self showNextStatusBar];
        }
    });
   
}
- (void)hideAll
{
    _statusBarVisible = NO;
    [_statusBarQueue removeAllObjects];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - Private

- (void)showNextStatusBar
{
    if ([_statusBarQueue count] > 0){
        _statusBarVisible = YES;
        
        WJStatusBarView *statusBarView = [_statusBarQueue objectAtIndex:0];
        statusBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
        statusBarView.hidden = NO;
        statusBarView.delegate = self;
        [statusBarView beganAnimation];

        if (statusBarView){
            [_statusBarQueue removeObject:statusBarView];
        }
    }
}

#pragma mark - WJStatusBarViewDelegate
- (void)animationFinished:(WJStatusBarView *)statusBar
{
    _statusBarVisible = NO;
    if([_statusBarQueue count] > 0) {
        [self showNextStatusBar];
    }
}

- (void)statusBarViewClicked:(WJStatusBarView *)statusBar
{
    if ([statusBar.callbacks count] > 0){
        id obj = [statusBar.callbacks objectAtIndex:0];
        if (![obj isEqual:[NSNull null]]) {
            ((statusBarCall)obj)();
        }
    }

    _statusBarVisible = NO;
    if([_statusBarQueue count] > 0) {
        [self showNextStatusBar];
    }
}

@end
