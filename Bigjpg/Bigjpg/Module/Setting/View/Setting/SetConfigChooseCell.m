//
//  SetConfigChooseCell.m
//  Bigjpg
//
//  Created by rabi on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "SetConfigChooseCell.h"

@interface SetConfigChooseCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic,strong)UIButton *chooseBtn;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (nonatomic,strong)UIView *lineView;

@end
@implementation SetConfigChooseCell

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
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
}

-(void)configUIWithItem:(NSObject *)item{
//    self.titleLabel.text = item.title;
//    self.titleLabel.textColor = item.is_selected ? [UIColor whiteColor] : TitleGrayColor;
//    self.chooseBtn.selected = item.is_selected;
    self.titleLabel.text = @"自动";
    self.chooseBtn.selected =!self.chooseBtn.selected;
}



#pragma mark - act


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
            make.height.mas_equalTo(Adaptor_Value(60));
            
        }];
        contentV.backgroundColor = BackGroundColor;
        
        _chooseBtn = [[UIButton alloc] init];

        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
        [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateSelected];
        [contentV addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(20));
            make.left.mas_equalTo(Adaptor_Value(20));
            make.centerY.mas_equalTo(contentV);
        }];
        _chooseBtn.backgroundColor = DeepGreenColor;
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.chooseBtn.mas_right).offset(Adaptor_Value(15));
            make.centerY.mas_equalTo(contentV);
        }];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = LineGrayColor;
        [contentV addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV);
            make.height.mas_equalTo(kOnePX);
        }];

    }
    return _cellBackgroundView;
}

@end
