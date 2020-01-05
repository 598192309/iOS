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
@property (nonatomic,strong)   UIView *iconImageVCoverView;

@property (strong, nonatomic)  UILabel *imageTipLable;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (nonatomic,strong)   UIButton *retryOrDownloadBtn;

@property (nonatomic,strong)   UIButton *chooseBtn;


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


- (void)configUIWithItem:(M_EnlargeHistory *)item downAll:(BOOL)downAll{
    //设置图片
    NSString *smallImagesStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_fill,w_%d,h_%d",item.conf.input,100,100];
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:smallImagesStr]];
    __weak __typeof(self) weakSelf = self;
    [_retryOrDownloadBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];
    CGFloat w = 0;
    if ([item.status isEqualToString:@"success"]) {
        _retryOrDownloadBtn.hidden = NO;
        [_retryOrDownloadBtn setTitle:LanguageStrings(@"download") forState:UIControlStateNormal];
        _retryOrDownloadBtn.backgroundColor = LihgtGreenColor;
        w = [LanguageStrings(@"download") boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.width + Adaptor_Value(15);
    }else if ([item.status isEqualToString:@"success"]) {
        _retryOrDownloadBtn.hidden = NO;
        [_retryOrDownloadBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];
        _retryOrDownloadBtn.backgroundColor = YellowBackColor;
        w = [LanguageStrings(@"retry") boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.width + Adaptor_Value(15);

    } else {
        _retryOrDownloadBtn.hidden = YES;
    }
    [_retryOrDownloadBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
    }];
    NSString *noiseStr ;
    if (item.conf.noise == -1) {
        noiseStr = LanguageStrings(@"none");
    }else if (item.conf.noise == 0) {
        noiseStr = LanguageStrings(@"low");
    }else if (item.conf.noise == 1) {
        noiseStr = LanguageStrings(@"mid");
    }else if (item.conf.noise == 2) {
        noiseStr = LanguageStrings(@"high");
    }else if (item.conf.noise == 3) {
        noiseStr = LanguageStrings(@"highest");
    }
    
    NSString *x2Str ;
     if (item.conf.x2 == 1) {
        x2Str = @"2x";
    }else if (item.conf.x2 == 2) {
        x2Str = @"4x";
    }else if (item.conf.x2 == 3) {
        x2Str = @"8x";
    }else if (item.conf.x2 == 4) {
        x2Str = @"14x";
    }
    NSString *typeStr ;
     if ([item.conf.style isEqualToString:@"art"]) {
        typeStr = LanguageStrings(@"carton");
    }else  {
        typeStr = LanguageStrings(@"photo");
    }
    NSString *sizeStr = @"";
    if (item.conf.files_size < 1024) {
        sizeStr = [NSString stringWithFormat:@"%ldbytes",(long)item.conf.files_size];
    } else if (item.conf.files_size/ 1024.0 < 1024) {
        sizeStr = [NSString stringWithFormat:@"%.1fkb",item.conf.files_size/1024.0];
    } else {
        sizeStr = [NSString stringWithFormat:@"%.1fM",item.conf.files_size/1024.0/1024.0];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"%@,%@,%@,\n%@:%@",x2Str,sizeStr,typeStr,LanguageStrings(@"noise"),noiseStr];
    self.imageTipLable.text = item.status;
    self.imageTipLable.hidden = [item.status isEqualToString:@"success"];
    self.iconImageVCoverView.hidden = [item.status isEqualToString:@"success"];
    
    self.chooseBtn.hidden = !downAll;
    self.retryOrDownloadBtn.hidden = downAll;
    self.chooseBtn.selected = item.customSlected;
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
        ViewRadius(_iconImageV, Adaptor_Value(5));
        _iconImageV.backgroundColor = LineGrayColor;
        
        _iconImageVCoverView = [UIView new];
        _iconImageVCoverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        
        _imageTipLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:RedColor fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
         [contentV addSubview:_imageTipLable];
         [_imageTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.center.mas_equalTo(weakSelf.iconImageV);
         }];
        
      
        _retryOrDownloadBtn = [[UIButton alloc] init];
        [_retryOrDownloadBtn setTitle:@"" forState:UIControlStateNormal];
        [_retryOrDownloadBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchDown];
        _retryOrDownloadBtn.titleLabel.font = AdaptedFontSize(15);
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
        
        
        _chooseBtn = [[UIButton alloc] init];
        [_chooseBtn setImage:[[UIImage imageNamed:@"ic_uncheck"] qmui_imageWithTintColor:DeepGreenColor] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateSelected];
        [_chooseBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.width.mas_equalTo(Adaptor_Value(40));
            make.center.mas_equalTo(weakSelf.retryOrDownloadBtn);
        }];
        _chooseBtn.userInteractionEnabled = NO;
   
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(LQScreemW - Adaptor_Value(220));
//            make.center.mas_equalTo(contentV);
            make.center.mas_equalTo(contentV);
            make.left.mas_greaterThanOrEqualTo(weakSelf.iconImageV.mas_left).offset(Adaptor_Value(10));
            make.right.mas_greaterThanOrEqualTo(weakSelf.retryOrDownloadBtn.mas_left).offset(-Adaptor_Value(10));
        }];
        
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
