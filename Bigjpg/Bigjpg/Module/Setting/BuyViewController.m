//
//  BuyViewController.m
//  Bigjpg
//
//  Created by lqq on 2020/1/14.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BuyViewController.h"
#import "BuyCell.h"

@interface BuyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@end

@implementation BuyViewController
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

}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = TabbarGrayColor;
    self.navigationTextLabel.text = LanguageStrings(@"upgrade");
}

#pragma mark - act


#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [ConfManager.shared contentWith:@"func"];
    return arr.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BuyCell class])];
    NSArray *arr = [ConfManager.shared contentWith:@"func"];
    NSArray *dataArr = [arr safeObjectAtIndex:indexPath.row];
    UIColor *color = TitleGrayColor;
    if (indexPath.row == 0) {
        color = TitleGrayColor;
    }else  if (indexPath.row == 1) {
        color = RGB(155, 48, 175);
    }else  if (indexPath.row == 2) {
        color = RGB(31, 184, 34);
    }else  if (indexPath.row == 3) {
        color = RGB(44, 152, 240);
    }else{
        color = RGB(241, 56, 56);
    }
    [cell configUIWithArr:dataArr color:color];
    return cell;
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
        
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _customTableView.estimatedRowHeight = Adaptor_Value(120);
        _customTableView.rowHeight = UITableViewAutomaticDimension;
        
        [_customTableView registerClass:[BuyCell class] forCellReuseIdentifier:NSStringFromClass([BuyCell class])];

        
    }
    return _customTableView;
}
@end
