//
//  ViewController.m
//  WJStatusBarView
//
//  Created by wujian on 6/8/16.
//  Copyright © 2016 wesk痕. All rights reserved.
//

#import "ViewController.h"
#import "WJStatusBarManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTextClicked:(id)sender {
    
    [[WJStatusBarManager sharedInstance] showStatusBarWithTitle:@"this is test"];
}
- (IBAction)showTextCallBackClicked:(id)sender {
    [[WJStatusBarManager sharedInstance] showStatusBarWithTitle:@"this is test" callback:^{
        NSLog(@"you has clicked this statusBarView1");
    }];

}
- (IBAction)callBack2Clicked:(id)sender {
    [[WJStatusBarManager sharedInstance] showStatusBarWithTitle:@"this is test" callback:^{
        NSLog(@"you has clicked this statusBarView2");
    }];
}
@end
