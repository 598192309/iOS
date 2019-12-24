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
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)SettingCustomView *settingCustomView;
@property (nonatomic,strong)NSMutableArray *typeArr;

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
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self settingCustomViewAct];
}

//改换主题  红涨绿跌 或者语言  都在这里变
- (void)changeTheme{
    
}


#pragma mark - act

- (void)settingCustomViewAct{
    __weak __typeof(self) weakSelf = self;
   
    
}

//
//- (void)umengShare{
//
//
//    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
//    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.top.mas_equalTo([UIApplication sharedApplication].keyWindow);
//    }];
//    __weak __typeof(self) weakSelf = self;
//    self.shareView.umShareViewcellClick = ^(NSInteger index) {
//        [weakSelf requestInviteFriendsData:index];
//    };
//    self.shareView.umShareViewCloseBtnClick = ^(UIButton * _Nonnull sender) {
//        [weakSelf.shareView removeFromSuperview];
//        weakSelf.shareView = nil;
//    };
//
//    [self.shareView show];
//
//}
//- (void)shareToPlatform:(UMSocialPlatformType)type  inviteData:(InviteFriendsItem *)item{
//    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
//    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
//    BOOL hadInstalledWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]];
//
//
//
//    // 根据获取的platformType确定所选平台进行下一步操作
//    //创建分享消息对象
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    //创建图文内容对象
//    UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
//    InviteFriendsDetailItem *detailItem ;
//    if (type == UMSocialPlatformType_WechatSession) {
//        if (!hadInstalledWeixin) {
//            [LSVProgressHUD showInfoWithStatus:@"未安装微信"];
//            return;
//        }
//        detailItem = item.weixin;
//    }else if (type == UMSocialPlatformType_WechatTimeLine){
//        if (!hadInstalledWeixin) {
//            [LSVProgressHUD showInfoWithStatus:@"未安装微信"];
//            return;
//        }
//
//        detailItem = item.friend_circle;
//
//    }else if (type == UMSocialPlatformType_QQ){
//        if (!hadInstalledQQ) {
//            [LSVProgressHUD showInfoWithStatus:@"未安装QQ"];
//            return;
//        }
//
//        detailItem = item.qq;
//
//    }else if (type == UMSocialPlatformType_Sina){
//        if (!hadInstalledWeibo) {
//            [LSVProgressHUD showInfoWithStatus:@"未安装微博"];
//            return;
//        }
//
//        detailItem = item.weibo;
//
//    }
//
//    shareObject.webpageUrl =detailItem.link;
//    shareObject.title = detailItem.title;
//
//    shareObject.descr = detailItem.content;
//    shareObject.thumbImage = detailItem.thumb;
//
//    messageObject.shareObject = shareObject;
//    __weak __typeof(self) weakSelf = self;
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//            [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"分享失败", nil)];
//
//        }else{
//            NSLog(@"response data is %@",data);
//            [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"分享成功", nil)];
//
//        }
//        [weakSelf.shareView removeFromSuperview];
//        weakSelf.shareView = nil;
//    }];
//}


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
        [cell refreshUIWithTitle:lqStrings(@"设置")];

    }else if (indexPath.row == 2) {
        [cell refreshUIWithTitle:lqStrings(@"设置")];

    }else if (indexPath.row == 3) {
        [cell refreshUIWithTitle:lqStrings(@"设置")];

    }else if (indexPath.row == 4) {
        [cell refreshUIWithTitle:lqStrings(@"设置")];

    }
  
    return cell;
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
#pragma mark - UMSocialShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidAppear
{
    NSLog(@"UMSocialShareMenuViewDidAppear");
}
- (void)UMSocialShareMenuViewDidDisappear
{
    NSLog(@"UMSocialShareMenuViewDidDisappear");
}

//不需要改变父窗口则不需要重写此协议
- (UIView*)UMSocialParentView:(UIView*)defaultSuperView
{
    return defaultSuperView;
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
