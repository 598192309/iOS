//
//  HistoryCell.m
//  Bigjpg
//
//  Created by rabi on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HistoryCell.h"

@interface HistoryCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic,strong)   UIImageView *iconImageV;
@property (strong, nonatomic)  UILabel *imageTipLable;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (nonatomic,strong)   UIButton *removeBtn;


@end
@implementation HistoryCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BackGroundColor;
        
    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
}


- (void)configUIWithItem:(NSObject *)item{
    self.titleLabel.text = @"aaaaa";
}

#pragma mark - act
- (void)removeBtnClick:(UIButton *)sender{

}

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor clearColor];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
            make.height.mas_equalTo(Adaptor_Value(120));
        }];
        contentV.backgroundColor = BackGroundColor;
        
        _iconImageV = [[UIImageView alloc] init];
        [contentV addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(80));
            make.left.mas_equalTo(Adaptor_Value(10));
            make.centerY.mas_equalTo(contentV);
        }];
        
        _imageTipLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
         [contentV addSubview:_imageTipLable];
         [_imageTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.center.mas_equalTo(weakSelf.iconImageV);
         }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(220));
            make.center.mas_equalTo(contentV);
        }];
        

        _removeBtn = [[UIButton alloc] init];
        [_removeBtn setTitle:lqStrings(@"删除") forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_removeBtn];
        [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(80));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(contentV);
        }];
        _removeBtn.backgroundColor = RedColor;
        ViewRadius(_removeBtn, Adaptor_Value(3));
        
    }
    return _cellBackgroundView;
}

@end
