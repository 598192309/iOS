//
//  HomeViewController.m
//  Bigjpg
//
//  Created by rabi on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HomeViewController.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser.h>
#import "I_Enlarge.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //test
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"添加图片" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)addPic
{

}

@end
