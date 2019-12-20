//
//  BaseNavgationController.m
//  FullShareTop
//
//  Created by lqq on 17/3/21.
//  Copyright © 2017年 FSB. All rights reserved.
//

#import "BaseNavgationController.h"
@interface BaseNavgationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavgationController

+ (void)initialize
{
    //设置NavgationBar
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    //设置NavgationBar的title
//     [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXColor(@"#0E1C29"),NSFontAttributeName:MediumFont(17)}];
//    //设置UIBarButtonItem的title
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXColor(@"#3AA7FF"), NSFontAttributeName:RegularFont(16)} forState:UIControlStateNormal];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXColor(@"#3AA7FF"), NSFontAttributeName:RegularFont(16)} forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //默认都开启右划返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.delegate = self;
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}
// @param viewController 刚刚push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果viewController不是最早push进来的子控制器
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL needHideNav = [viewController needHideNav];

    
    [self setNavigationBarHidden:needHideNav animated:animated];
}


/**
 转场动画
 */
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{

    return nil;
}

@end
