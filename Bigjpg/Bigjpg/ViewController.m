//
//  ViewController.m
//  Bigjpg
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "ViewController.h"
#import "I_Account.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)action:(id)sender {
    [I_Account loginOrRegistWithUserName:@"454140866@qq.com" pwd:@"123456" notReg:NO success:^(M_Account * _Nonnull account) {
        
    } :^(NSError *error) {
        
    }];
}

@end
