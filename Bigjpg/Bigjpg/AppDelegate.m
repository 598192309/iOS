//
//  AppDelegate.m
//  Bigjpg
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LaunchingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [MainTabBarController new];
    self.window.rootViewController = [LaunchingViewController new];

    [self.window makeKeyAndVisible];
    
    NSLog(@"%@",LanguageStrings(@"donate"));
    
    return YES;
}

#pragma mark - 自定义

+ (void)presentLoginViewContrller
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseNavgationController*nav = [[BaseNavgationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [del.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
