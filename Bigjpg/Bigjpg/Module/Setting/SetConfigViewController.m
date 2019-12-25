//
//  SetConfigViewController.m
//  Bigjpg
//
//  Created by rabi on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "SetConfigViewController.h"
#import "SetConfigChooseCell.h"
#import "CustomTableAlertView.h"

@interface SetConfigViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;

@property (nonatomic,strong)UIView *footer;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UIButton *languageBtn;

@property (nonatomic,strong)CustomTableAlertView *customTableAlertView;
@end

@implementation SetConfigViewController
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

    [self setUpNav];
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
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];

    
    //footer
    UIView *tableFooterView = [[UIView alloc] init];
    [tableFooterView addSubview:self.footer];
    [self.footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableFooterView);
    }];
    CGFloat H = [tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableFooterView.lq_height = H;
    self.customTableView.tableFooterView = tableFooterView;
    self.customTableView.tableFooterView.lq_height = H;
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationTextLabel.text = lqStrings(@"设置");
}

#pragma mark - act
- (void)languageBtnClick:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    [[UIApplication sharedApplication].keyWindow addSubview:self.customTableAlertView];
    [self.customTableAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
    [self.customTableAlertView configUIWithArr:@[@"1",@"1",@"1",@"1",@"1"]];
    self.customTableAlertView.CustomTableAlertChooseBlock = ^(NSInteger index, NSString * _Nonnull str) {
        [LSVProgressHUD showInfoWithStatus:str];
        [weakSelf.customTableAlertView removeFromSuperview];
        weakSelf.customTableAlertView = nil;
    };
    
    self.customTableAlertView.CustomTableAlertRemoveBlock = ^{
        [weakSelf.customTableAlertView removeFromSuperview];
        weakSelf.customTableAlertView = nil;
    };
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

    return 2;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetConfigChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SetConfigChooseCell class]) forIndexPath:indexPath];
    [cell configUIWithItem:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //改变数据源
    [self.customTableView reloadData];
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
        
        [_customTableView registerClass:[SetConfigChooseCell class] forCellReuseIdentifier:NSStringFromClass([SetConfigChooseCell class])];
        
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;


        
        
    }
    return _customTableView;
}

- (UIView *)footer{
    if (!_footer) {
        _footer = [UIView new];
        
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;
        [_footer addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.footer);
        }];
        
        _tipLable = [UILabel lableWithText:lqLocalized(@"语言",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        
        _languageBtn = [[UIButton alloc] init];
        [_languageBtn setTitle:lqStrings(@"简体中文") forState:UIControlStateNormal];
        [_languageBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_languageBtn addTarget:self action:@selector(languageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentV addSubview:_languageBtn];
        [_languageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.tipLable);
            make.top.mas_equalTo(weakSelf.tipLable.mas_bottom).offset(Adaptor_Value(15));
            
            make.bottom.mas_equalTo(contentV);
        }];
        
    }
    return _footer;
}

- (CustomTableAlertView *)customTableAlertView{
    if (!_customTableAlertView) {
        _customTableAlertView = [CustomTableAlertView new];
    }
    return _customTableAlertView;
}
@end
