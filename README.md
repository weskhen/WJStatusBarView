# WJStatusBarView
跑马灯效果 有点击事件 可设置动画时间
use as the Example
    [[WJStatusBarManager sharedInstance] showStatusBarWithTitle:@"this is test" callback:^{
        NSLog(@"you has clicked this statusBarView");
    }];
