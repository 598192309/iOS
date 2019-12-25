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
//    [I_Account loginOrRegistWithUserName:@"454140866@qq.com" pwd:@"123456" notReg:NO success:^(M_Account * _Nonnull account) {
//
//    } :^(NSError *error) {
//
//    }];
    
//    [I_Account getUserInfoOnSuccess:^(NSDictionary * _Nonnull result) {
//
//    } failure:^(NSError *error) {
//
//    }];
    
//    [I_Account retryEnlargeFids:@[@"8015a325f9994eedaef8f5b6b9829665"] success:^{
//
//    } failure:^(NSError *error) {
//
//    }];
    
    [I_Account deleteEnlargeTasks:@[@"8015a325f9994eedaef8f5b6b9829665"] success:^{

    } failure:^(NSError *error) {

    }];
}

@end
