//
//  HistoryCell.m
//  Bigjpg
//
//  Created by rabi on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HistoryCell.h"
#import <SDWebImage/SDWebImage.h>
@interface HistoryCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic,strong)   UIImageView *iconImageV;
@property (strong, nonatomic)  UILabel *imageTipLable;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (nonatomic,strong)   UIButton *retryOrDownloadBtn;



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


- (void)configUIWithItem:(M_EnlargeHistory *)item{
    //设置图片
    NSString *smallImagesStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,w_%d,h_%d",item.conf.input,100,100];
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:smallImagesStr]];
    self.titleLabel.text = LanguageStrings(item.status);
    __weak __typeof(self) weakSelf = self;
    [_retryOrDownloadBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];

    if ([item.status isEqualToString:@"success"]) {
        _retryOrDownloadBtn.hidden = NO;
        [_retryOrDownloadBtn setTitle:LanguageStrings(@"download") forState:UIControlStateNormal];
        _retryOrDownloadBtn.backgroundColor = LihgtGreenColor;

    }else if ([item.status isEqualToString:@"success"]) {
        _retryOrDownloadBtn.hidden = NO;
        [_retryOrDownloadBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];
        _retryOrDownloadBtn.backgroundColor = YellowBackColor;
    } else {
        _retryOrDownloadBtn.hidden = YES;
    }
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
        _iconImageV.backgroundColor = LihgtGreenColor;
        
        
        _imageTipLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
         [contentV addSubview:_imageTipLable];
         [_imageTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.center.mas_equalTo(weakSelf.iconImageV);
         }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(220));
            make.center.mas_equalTo(contentV);
        }];
        _retryOrDownloadBtn = [[UIButton alloc] init];
        [_retryOrDownloadBtn setTitle:@"" forState:UIControlStateNormal];
        [_retryOrDownloadBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_retryOrDownloadBtn];
        _retryOrDownloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_retryOrDownloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(80));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(contentV.mas_centerY);
        }];
        _retryOrDownloadBtn.backgroundColor = YellowBackColor;
        ViewRadius(_retryOrDownloadBtn, Adaptor_Value(4));

   
        
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = LineGrayColor;
        [contentV addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV);
            make.height.mas_equalTo(kOnePX);
        }];
        
    }
    return _cellBackgroundView;
}

@end
