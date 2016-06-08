//
//  WJStatusBarView.h
//  WJStatusBarView
//
//  Created by wujian on 6/8/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import "WJStatusBarView.h"


@interface WJStatusBarView ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) NSString  *titleString;
@end
@implementation WJStatusBarView

@synthesize duration = _duration;
@synthesize hasCallback = _hasCallback;
@synthesize callbacks = _callbacks;

#pragma mark - Alloc/Init

- (id)initWithTitle:(NSString*)title
{
    self = [super initWithFrame:CGRectZero];
    if (self){
        
        self.backgroundColor = [UIColor grayColor];
//        self.clipsToBounds = NO;
        self.userInteractionEnabled = YES;
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.titleString = title;

    }
    return self;
}

- (void)beganAnimation
{
    if (self.titleString.length == 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(animationFinished:)]) {
            [self.delegate animationFinished:self];
        }
        return;
    }
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT);
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfClicked:)];
    [self addGestureRecognizer:gest];
    
    [self addSubview:self.titleLabel];
    _titleLabel.text = self.titleString;
    [_titleLabel sizeToFit];
    _titleLabel.center = self.center;

    __block CGRect frame = _titleLabel.frame;
    frame.origin.x = SCREEN_WIDTH;
    _titleLabel.frame = frame;
    
    [UIView animateWithDuration:self.duration animations:^{
        frame = self.titleLabel.frame;
        frame.origin.x = - frame.size.width;
        self.titleLabel.frame = frame;

    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(animationFinished:)]) {
            [self.delegate animationFinished:self];
            self.delegate = nil;
        }
    }];
}

- (void)selfClicked:(id)sender
{
    if (self.hasCallback && self.delegate && [self.delegate respondsToSelector:@selector(statusBarViewClicked:)]) {
        [self.delegate statusBarViewClicked:self];
        self.delegate = nil;
    }
}


#pragma mark - setter

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
