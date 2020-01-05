//
//  MainTabBarController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MainTabBarController.h"
#import "SDImageCache.h"

#import "HomeViewController.h"
#import "HistoryViewController.h"
#import "SettingViewController.h"



@interface MainTabBarController ()<UITabBarControllerDelegate>


@end

@implementation MainTabBarController


+ (void)initialize
{
    [[UITabBar appearance] setTranslucent:NO];
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor blackColor];
    HomeViewController *vc1 = [HomeViewController controller];
    [self addChildViewController:vc1 withImageName:@"add" selectedImageName:@"add" withTittle:LanguageStrings(@"begin")];
    
    HistoryViewController *vc2 = [[HistoryViewController alloc] init];
    [self addChildViewController:vc2 withImageName:@"history" selectedImageName:@"history" withTittle:LanguageStrings(@"log")];

    SettingViewController *vc3 = [[SettingViewController alloc] init];
    [self addChildViewController:vc3 withImageName:@"setting" selectedImageName:@"setting" withTittle:LanguageStrings(@"conf")];
    
    
    [self setupBasic];
    self.delegate = self;
    
    //监听

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)setupBasic {
    
    self.tabBar.barTintColor = TabbarGrayColor;
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];

}

-(void)dealloc {
    
}

#pragma mark - act

- (void)addChildViewController:(UIViewController *)controller withImageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName withTittle:(NSString *)tittle{
    BaseNavgationController *nav = [[BaseNavgationController alloc] initWithRootViewController:controller];
    
    UIImage * image = [[[UIImage imageNamed:imageName] qmui_imageWithTintColor:[UIColor lq_colorWithHexString:@"d2d2d2"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[[UIImage imageNamed:selectImageName] qmui_imageWithTintColor:[UIColor blackColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];



    
    nav.tabBarItem.title = tittle;
    //        controller.navigationItem.title = tittle;
    //    controller.title = tittle;//这句代码相当于上面两句代码
    //    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    
    [self addChildViewController:nav];
//    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
//    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
}


#pragma mark <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    return YES;
}


@end
