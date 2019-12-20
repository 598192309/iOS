//
//  BaseViewController.m
//  FullShareTop
//
//  Created by lqq on 17/3/21.
//  Copyright © 2017年 FSB. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isFirstViewDidAppear=YES;
    self.view.backgroundColor = [UIColor lq_colorWithHexString:@"F4F6F9"];
    [self lq_setBackButtonWithImageName:@""];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isVisible = YES;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isFirstViewDidAppear=NO;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _isVisible = NO;
}




@end
