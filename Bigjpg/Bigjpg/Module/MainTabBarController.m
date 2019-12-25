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




// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    [self addChildViewController:vc1 withImageName:@"home" selectedImageName:@"home_sel" withTittle:lqLocalized(@"开始",nil)];
    
    HistoryViewController *vc2 = [[HistoryViewController alloc] init];
    [self addChildViewController:vc2 withImageName:@"wallet" selectedImageName:@"history_sel" withTittle:lqStrings(@"放大历史")];

    SettingViewController *vc3 = [[SettingViewController alloc] init];
    [self addChildViewController:vc3 withImageName:@"account" selectedImageName:@"account_sel" withTittle:lqLocalized(@"设置",nil)];
    
    
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
    
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];

    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TitleBlackColor,NSFontAttributeName:AdaptedFontSize(13)} forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(212, 212, 212),NSFontAttributeName:AdaptedFontSize(13)} forState:UIControlStateNormal];



    //取消设置半透明
    self.tabBar.translucent = NO;


    
    nav.tabBarItem.title = tittle;
    //        controller.navigationItem.title = tittle;
    //    controller.title = tittle;//这句代码相当于上面两句代码
    //    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    
    [self addChildViewController:nav];
}


#pragma mark <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    
    return YES;
}


@end
