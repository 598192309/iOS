//
//  SettingCustomView.m
//  Bigjpg
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "SettingCustomView.h"

@interface SettingCustomView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIView *tipView;
@property (nonatomic,strong)UIButton *tipBtn;
@property (nonatomic,strong)UIButton *updateBtn;

@property (nonatomic,strong)UIView *textFBackView;

@property (nonatomic,strong)UITextField *emailTextF;
@property (nonatomic,strong)UITextField *pwdTF;

@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)UIButton *confirmBtn;

@property (nonatomic,strong)UIButton *zhuceChooseBtn;
@property (nonatomic,strong)UILabel *zhuceTipLabel;


@property (nonatomic,strong)UIImageView *erweimaImageV;
@property (nonatomic,strong)UILabel *erweimaTipLable;
@end
@implementation SettingCustomView


#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(NSObject *)item finishi:(void(^)())finishBlock{
    
    
    
    finishBlock();
}
#pragma mark - act
- (void)updateBtnClick:(UIButton *)sender{
    if (self.settingCustomViewUpdateBtnClickBlock) {
        self.settingCustomViewUpdateBtnClickBlock(@{});
    }
}
- (void)zhuceChooseBtnClick:(UIButton *)sender{

}

- (void)fogetBtnClick:(UIButton *)sender{
    if (self.settingCustomViewForgetBtnClickBlock) {
        self.settingCustomViewForgetBtnClickBlock(nil);
    }
}

- (void)confirmBtnClick:(UIButton *)sender{
    if (self.settingCustomViewConfirmBtnClickBlock) {
        self.settingCustomViewConfirmBtnClickBlock(@{@"mobile":SAFE_NIL_STRING(self.emailTextF.text),@"pwd":SAFE_NIL_STRING(self.pwdTF.text)}, sender);
    }
}

- (void)zhuceTap:(UITapGestureRecognizer *)gest{
    if (self.settingCustomViewZhuceClickBlock) {
        self.settingCustomViewZhuceClickBlock(nil);
    }
}


#pragma  mark - UITextField delegate
- (void)textFDidChange:(UITextField *)textf{
    
    //限制输入字数
    if (self.emailTextF.text.length >= 11) {
        self.emailTextF.text = [self.emailTextF.text substringToIndex:11];
    }
    
    if (self.emailTextF.text.length > 0 && self.pwdTF.text.length > 0 ) {
        self.confirmBtn.enabled = YES;
    }else{
        self.confirmBtn.enabled = NO;
    }
    
}




#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BackGroundColor;
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _tipView = [UIView new];
        _tipView.backgroundColor = BackGrayColor;
        [contentV addSubview:_tipView];
        [_tipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(120));
            make.top.mas_equalTo(Adaptor_Value(30));
        }];
        ViewRadius(_tipView, Adaptor_Value(10));
        
        _tipBtn = [[UIButton alloc] init];
        [_tipBtn setTitle:lqStrings(@"免费版") forState:UIControlStateNormal];
        [_tipBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_tipView addSubview:_tipBtn];
        [_tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.tipView);
            make.width.mas_equalTo(Adaptor_Value(80));
            make.right.mas_equalTo(weakSelf.tipView.mas_centerX).offset(-Adaptor_Value(10));
            
        }];
        _tipBtn.enabled = NO;
        
        _updateBtn = [[UIButton alloc] init];
        [_updateBtn setTitle:lqStrings(@"升级") forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_updateBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_tipView addSubview:_updateBtn];
        [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.tipView);
            make.width.mas_equalTo(Adaptor_Value(80));
            make.left.mas_equalTo(weakSelf.tipView.mas_centerX).offset(Adaptor_Value(10));
            
        }];
        _updateBtn.backgroundColor = LihgtGreenColor;
        ViewRadius(_updateBtn, Adaptor_Value(5));
        
        
        
        _textFBackView = [UIView new];
        _textFBackView.backgroundColor = BackGroundColor;
        [contentV addSubview:_textFBackView];
        [_textFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipView.mas_bottom).offset(Adaptor_Value(25));
            make.left.mas_equalTo(weakSelf.tipView);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
      
        _emailTextF = [[UITextField alloc] init];
        [_textFBackView addSubview:_emailTextF];
        [_emailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.textFBackView);
            make.height.mas_equalTo(Adaptor_Value(35));
            make.top.mas_equalTo(Adaptor_Value(5));
        }];
        _emailTextF.keyboardType = UIKeyboardTypeNumberPad;
        _emailTextF.textColor = [UIColor whiteColor];
        [_emailTextF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _emailTextF.placeholder = lqStrings(@"邮箱");

        // "通过KVC修改placeholder的颜色"
        [_emailTextF setPlaceholderColor:TitleGrayColor font:nil];


        
        UIView *rowLine1 =  [UIView new];
        rowLine1.backgroundColor = LihgtGreenColor;
        [_textFBackView addSubview:rowLine1];
        [rowLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *2);
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.top.mas_equalTo(weakSelf.emailTextF.mas_bottom).offset(5);
        }];
        

        
        _pwdTF = [[UITextField alloc] init];
        [_textFBackView addSubview:_pwdTF];
        [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.emailTextF);
            make.height.mas_equalTo(Adaptor_Value(35));
            make.top.mas_equalTo(weakSelf.emailTextF.mas_bottom).offset(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.textFBackView);
            make.bottom.mas_equalTo(weakSelf.textFBackView).offset(-Adaptor_Value(5));
        }];
        _pwdTF.textColor = TitleBlackColor;
        _pwdTF.secureTextEntry = YES;
        [_pwdTF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _pwdTF.placeholder = lqStrings(@"密码");

        // "通过KVC修改placeholder的颜色"
        [_pwdTF setPlaceholderColor:TitleGrayColor font:nil];

        UIView *rowLine2 =  [UIView new];
        rowLine2.backgroundColor = LihgtGreenColor;
        [_textFBackView addSubview:rowLine2];
        [rowLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *2);
            make.bottom.mas_equalTo(weakSelf.textFBackView);
            make.left.right.mas_equalTo(rowLine1);

        }];
        
        UIView *zhuceView = [UIView new];
        [contentV addSubview:zhuceView];
        [zhuceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.textFBackView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.textFBackView);
            
        }];

        
        
        _zhuceChooseBtn = [[UIButton alloc] init];
        _zhuceChooseBtn.backgroundColor = [UIColor redColor];
        [_zhuceChooseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_zhuceChooseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_zhuceChooseBtn addTarget:self action:@selector(zhuceChooseBtnClick:) forControlEvents:UIControlEventTouchDown];
        [zhuceView addSubview:_zhuceChooseBtn];
        [_zhuceChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(zhuceView);
            make.height.width.mas_equalTo(Adaptor_Value(20));
        }];
        
        
        
        _zhuceTipLabel = [UILabel lableWithText:lqStrings(@"注册一个新用户") textColor:[UIColor lq_colorWithHexString:@"#616161"] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [zhuceView addSubview:_zhuceTipLabel];
        [_zhuceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.mas_equalTo(zhuceView);
            make.left.mas_equalTo(weakSelf.zhuceChooseBtn.mas_right).offset(Adaptor_Value(5));
        }];


        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_confirmBtn setTitle:lqStrings(@"登录") forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:BackGroundColor forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = AdaptedFontSize(17);

        _confirmBtn.backgroundColor = LihgtGreenColor;
        [contentV addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(zhuceView.mas_bottom).offset(Adaptor_Value(25));
            
        }];
        ViewRadius(_confirmBtn, Adaptor_Value(5));
        _confirmBtn.enabled = NO;
        
        

        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:lqStrings(@"忘记密码?") forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(fogetBtnClick:) forControlEvents:UIControlEventTouchDown];
        _forgetBtn.titleLabel.font = AdaptedFontSize(17);
        [contentV addSubview:_forgetBtn];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.confirmBtn.mas_bottom).offset(Adaptor_Value(10));
            
        }];
        
        UIView *rowLine3 =  [UIView new];
        rowLine3.backgroundColor = LineGrayColor;
        [contentV addSubview:rowLine3];
        [rowLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX);
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.top.mas_equalTo(weakSelf.forgetBtn.mas_bottom).offset(20);
        }];
        
        _erweimaImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat_qr"]];
        [contentV addSubview:_erweimaImageV];
        [_erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(80));
            make.top.mas_equalTo(weakSelf.forgetBtn.mas_bottom).offset(Adaptor_Value(40));
            make.left.mas_equalTo(weakSelf.textFBackView);
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];
        
        UIView *rowLine4 =  [UIView new];
        rowLine4.backgroundColor = LineGrayColor;
        [contentV addSubview:rowLine4];
        [rowLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kOnePX);
            make.left.mas_equalTo(weakSelf.erweimaImageV.mas_right).offset(Adaptor_Value(10));
            
            make.top.mas_equalTo(weakSelf.erweimaImageV).offset(-Adaptor_Value(5));
            make.bottom.mas_equalTo(weakSelf.erweimaImageV).offset(Adaptor_Value(5));

        }];
        
        _erweimaTipLable = [UILabel lableWithText:lqStrings(@"[bigjpg 人工智能] 微信公众号会定期推送超超超清美图壁纸插画和黑科技新功能") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_erweimaTipLable];
        [_erweimaTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.erweimaImageV);
            make.left.mas_equalTo(rowLine4.mas_right).offset(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
    }
    return _header;
}
@end
