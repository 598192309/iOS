//
//  SettingViewController.m
//  Bigjpg
//
//  Created by rabi on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCustomView.h"
#import "SettingCell.h"
#import "CustomActivity.h"
#import "SetConfigViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)SettingCustomView *settingCustomView;

@end

@implementation SettingViewController
#pragma mark - 重写

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];

    
    if (@available(iOS 11.0, *)) {
        _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    //监听用户登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kUserSignIn object:nil];
    //监听用户退出登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kUserSignOut object:nil];
  

}

- (void)dealloc{
    NSLog(@"dealloc -- %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - ui
- (void)configUI{
    [self.view addSubview:self.customTableView];
    __weak __typeof(self) weakSelf = self;
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(weakSelf.view);
    }];
    self.customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.settingCustomView];
    [self.settingCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    [self.settingCustomView configUIWithItem:nil finishi:^{
        
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self settingCustomViewAct];

}


#pragma mark - act

- (void)settingCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //登录 退出
    self.settingCustomView.settingCustomViewConfirmBtnClickBlock = ^(NSDictionary * _Nonnull dict, UIButton * _Nonnull sender) {
        NSString *email = [dict safeObjectForKey:@"email"];
        NSString *pwd = [dict safeObjectForKey:@"pwd"];
        if ([[sender titleForState:UIControlStateNormal] isEqualToString:LanguageStrings(@"login_reg")]) {
            RI.is_logined = YES;
        }else{
            RI.is_logined = NO;

        }
       //登录成功 刷新一下settingCustomView
        [weakSelf.settingCustomView configUIWithItem:nil finishi:^{
            UIView *tableHeaderView = [[UIView alloc] init];
            [tableHeaderView addSubview:weakSelf.settingCustomView];
            [weakSelf.settingCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(tableHeaderView);
            }];
            CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            tableHeaderView.lq_height = H;
            weakSelf.customTableView.tableHeaderView = tableHeaderView;
            weakSelf.customTableView.tableHeaderView.lq_height = H;
        }];
    };
    //升级
    self.settingCustomView.settingCustomViewUpdateBtnClickBlock = ^(NSDictionary * _Nonnull dict) {
        
    };
    //忘记密码
    self.settingCustomView.settingCustomViewForgetBtnClickBlock = ^(NSDictionary * _Nonnull dict) {
        
    };
}
//系统分享
- (void)activityShare{
    // 1、设置分享的内容，并将内容添加到数组中
    NSString *shareText = @"分享的标题";
    UIImage *shareImage = [UIImage imageNamed:@"ic_launch_screen"];
    NSURL *shareUrl = [NSURL URLWithString:@"https://www.baidu.com"];
    NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
    
    // 自定义的CustomActivity，继承自UIActivity
    CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL:shareUrl ActivityType:@"Custom"];
    NSArray *activityArray = @[customActivity];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
    activityVC.modalInPopover = YES;
    // 3、设置回调
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // ios8.0 之后用此方法回调
        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionWithItemsHandler = itemsBlock;
    }else{
        // ios8.0 之前用此方法回调
        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionHandler = handlerBlock;
    }
    // 4、调用控制器
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
#pragma mark - net
- (void)requestData{
    
}

#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 5;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SettingCell class]) forIndexPath:indexPath];

    
    if (indexPath.row == 0) {
        [cell refreshUIWithTitle:lqStrings(@"设置")];
        
    }else if (indexPath.row == 1) {
        [cell refreshUIWithTitle:lqStrings(@"分享bigjpg.com")];

    }else if (indexPath.row == 2) {
        [cell refreshUIWithTitle:lqStrings(@"访问bigjpg.com官网")];

    }else if (indexPath.row == 3) {
        [cell refreshUIWithTitle:lqStrings(@"反馈&客服i@bigjpg.com")];

    }else if (indexPath.row == 4) {
        [cell refreshUIWithTitle:lqStrings(@"设置")];

    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            SetConfigViewController *vc = [[SetConfigViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1:{//系统分享
            [self activityShare];
        }
            
            break;
        case 2:{
            
        }
            
            break;
        case 3:{
            
        }
            
            break;
        case 4:{
            
        }
            
            b54:{
            
        }
            
            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor  = [UIColor clearColor];
    return view;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor  = [UIColor clearColor];
    return view;
}


#pragma  mark - lazy
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,LQScreemW, LQScreemH) style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        _customTableView.backgroundColor = BackGroundColor;
        //高度自适应
        _customTableView.estimatedRowHeight=60;
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        
        [_customTableView registerClass:[SettingCell class] forCellReuseIdentifier:NSStringFromClass([SettingCell class])];
        
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
//        [_customTableView beginHeaderRefreshing];
        
        
    }
    return _customTableView;
}
- (SettingCustomView *)settingCustomView{
    if (!_settingCustomView) {
        _settingCustomView = [SettingCustomView new];
    }
    return _settingCustomView;
}
@end
