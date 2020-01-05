//
//  SettingCustomView.m
//  Bigjpg
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "SettingCustomView.h"
#import "M_User.h"

@interface SettingCustomView()<UITextFieldDelegate>
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIView *tipView;
@property (nonatomic,strong)UIButton *tipBtn;
@property (nonatomic,strong)UIButton *updateBtn;

@property (nonatomic,strong)UIView *lorginTipView;
@property (nonatomic,strong)UIButton *lorgintipBtn;
@property (nonatomic,strong)UIButton *lorgintimeBtn;
@property (nonatomic,strong)UIButton *lorginupdateBtn;
@property (nonatomic,strong)UILabel *lorgintotalTipLabel;


@property (nonatomic,strong)UIView *textFBackView;

@property (nonatomic,strong)UITextField *emailTextF;
@property (nonatomic,strong)UIView *lineview1;
@property (nonatomic,strong)UIView *greenlineview1;

@property (nonatomic,strong)UITextField *pwdTF;
@property (nonatomic,strong)UIView *lineview2;
@property (nonatomic,strong)UIView *greenlineview2;

@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)UIButton *confirmBtn;

@property (nonatomic,strong)UIView *zhuceView;
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
- (void)configUIWithItem:(M_User *)item finishi:(void(^)())finishBlock{
    __weak __typeof(self) weakSelf = self;

    if (RI.is_logined) {
        
        [_textFBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(0));
        }];
        self.emailTextF.hidden = YES;
        self.pwdTF.hidden = YES;
        self.pwdTF.text = @"";
        self.lineview1.hidden = YES;
        self.lineview2.hidden = YES;

        [self.zhuceChooseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.zhuceTipLabel.text = nil;
        
        [self.confirmBtn setTitle:[NSString stringWithFormat:@"%@ %@",LanguageStrings(@"logout"),item.username] forState:UIControlStateNormal];
         [self.confirmBtn mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(weakSelf.zhuceView.mas_bottom).offset(Adaptor_Value(-20));
         }];
      
        NSArray *arr = [ConfManager.shared contentWith:@"version"];
        NSString *typestr;
        if ([item.version isEqualToString:@"free"]) {
            typestr = [arr safeObjectAtIndex:0];
        }else if ([item.version isEqualToString:@"basic"]) {
            typestr = [arr safeObjectAtIndex:1];
        }else if ([item.version isEqualToString:@"std"]) {
            typestr = [arr safeObjectAtIndex:2];
        }else{
            typestr = [arr safeObjectAtIndex:3];
        }
        NSArray *typeArr = [typestr componentsSeparatedByString:@":"];

        [self.lorgintipBtn setTitle:typeArr.lastObject forState:UIControlStateNormal];
        NSString *time = [item.expire lq_dealTimeFormarter:@"yyyy-MM-dd HH:mm:ss" changeFormater:@"yyyy-MM-dd"];
        [self.lorgintimeBtn setTitle:time forState:UIControlStateNormal];
        self.lorgintotalTipLabel.text = [NSString stringWithFormat:@"%@%lu",LanguageStrings(@"used"),(unsigned long)item.historyList.count];
        
        [_forgetBtn setTitle:LanguageStrings(@"change_password") forState:UIControlStateNormal];
    }else{
 
        [_textFBackView mas_updateConstraints:^(MASConstraintMaker *make) {
              make.height.mas_equalTo(Adaptor_Value(90));
          }];
        self.emailTextF.hidden = NO;
        self.pwdTF.hidden = NO;
        self.lineview1.hidden = NO;
        self.lineview2.hidden = NO;
        
        [self.zhuceChooseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
              make.height.mas_equalTo(20);
          }];
        self.zhuceTipLabel.text = LanguageStrings(@"reg_new");
        
        [self.confirmBtn setTitle:LanguageStrings(@"login_reg") forState:UIControlStateNormal];
         [self.confirmBtn mas_updateConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo(weakSelf.zhuceView.mas_bottom).offset(Adaptor_Value(25));
         }];
        [_forgetBtn setTitle:LanguageStrings(@"reset") forState:UIControlStateNormal];

    
    }

    self.lorginTipView.hidden = !RI.is_logined;
    
    
    
    finishBlock();
}



#pragma mark - act
- (void)updateBtnClick:(UIButton *)sender{
    if (self.settingCustomViewUpdateBtnClickBlock) {
        self.settingCustomViewUpdateBtnClickBlock(@{});
    }
}
- (void)zhuceChooseBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)fogetBtnClick:(UIButton *)sender{
    if (self.settingCustomViewForgetBtnClickBlock) {
        self.settingCustomViewForgetBtnClickBlock(@{},sender);
    }
}

- (void)confirmBtnClick:(UIButton *)sender{
    if (self.settingCustomViewConfirmBtnClickBlock) {
        self.settingCustomViewConfirmBtnClickBlock(@{@"email":SAFE_NIL_STRING(self.emailTextF.text),@"pwd":SAFE_NIL_STRING(self.pwdTF.text),@"zhuce":@(self.zhuceChooseBtn.selected)}, sender);
    }
}

- (void)zhuceTap:(UITapGestureRecognizer *)gest{
    [self zhuceChooseBtnClick:self.zhuceChooseBtn];
}


#pragma  mark - UITextField delegate
- (void)textFDidChange:(UITextField *)textf{
    
    if (self.emailTextF.text.length > 0 && self.pwdTF.text.length > 0 ) {
        self.confirmBtn.enabled = YES;
    }else{
        self.confirmBtn.enabled = NO;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.emailTextF]) {
        self.greenlineview1.hidden = NO;
        self.greenlineview2.hidden = YES;

    }else{
        self.greenlineview1.hidden = YES;
        self.greenlineview2.hidden = NO;
    }
    return YES;
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
            make.top.mas_equalTo(Adaptor_Value(45));
        }];
        ViewRadius(_tipView, Adaptor_Value(10));
                
        
        _tipBtn = [[UIButton alloc] init];
        NSArray *arr = [ConfManager.shared contentWith:@"version"];
        [_tipBtn setTitle:[arr safeObjectAtIndex:0] forState:UIControlStateNormal];
        [_tipBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_tipView addSubview:_tipBtn];
        [_tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.tipView);
            make.right.mas_equalTo(weakSelf.tipView.mas_centerX).offset(-Adaptor_Value(10));
       }];
        _tipBtn.enabled = NO;
        
        _updateBtn = [[UIButton alloc] init];
        [_updateBtn setTitle:LanguageStrings(@"upgrade") forState:UIControlStateNormal];
        [_updateBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _updateBtn.titleLabel.font = AdaptedFontSize(15);
        [_tipView addSubview:_updateBtn];
        CGFloat w = [LanguageStrings(@"upgrade") boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(17)} context:nil].size.width + Adaptor_Value(15);

        [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.tipView);
            make.left.mas_equalTo(weakSelf.tipView.mas_centerX).offset(Adaptor_Value(10));
            make.width.mas_equalTo(w);
            
        }];
        _updateBtn.backgroundColor = LihgtGreenColor;
        ViewRadius(_updateBtn, Adaptor_Value(5));
        
        [contentV addSubview:self.lorginTipView];
        [self.lorginTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.tipView);
        }];
        self.lorginTipView.hidden = !RI.is_logined;
        

        
        _textFBackView = [UIView new];
        _textFBackView.backgroundColor = BackGroundColor;
        [contentV addSubview:_textFBackView];
        [_textFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipView.mas_bottom).offset(Adaptor_Value(25));
            make.left.mas_equalTo(weakSelf.tipView);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(90));
        }];
      
        _emailTextF = [[UITextField alloc] init];
        [_textFBackView addSubview:_emailTextF];
        [_emailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.textFBackView);
            make.height.mas_equalTo(Adaptor_Value(35));
            make.top.mas_equalTo(Adaptor_Value(5));
        }];
        NSArray *user_pass = [ConfManager.shared contentWith:@"user_pass"];

        _emailTextF.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextF.textColor = TitleBlackColor;
        [_emailTextF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _emailTextF.placeholder = [user_pass safeObjectAtIndex:0];
        _emailTextF.delegate = self;

        // "通过KVC修改placeholder的颜色"
        [_emailTextF setPlaceholderColor:TitleGrayColor font:nil];
        _emailTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];

        
        UIView *rowLine1 =  [UIView new];
        _lineview1 = rowLine1;
        rowLine1.backgroundColor = LihgtGreenColor;
        [_textFBackView addSubview:rowLine1];
        [rowLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *2);
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.top.mas_equalTo(weakSelf.emailTextF.mas_bottom).offset(5);
        }];
        
        _greenlineview1 = [UIView new];
        _greenlineview1.backgroundColor = [UIColor greenColor];
        [_textFBackView addSubview:_greenlineview1];
        [_greenlineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *3);
            make.left.right.mas_equalTo(weakSelf.lineview1);
            make.centerY.mas_equalTo(weakSelf.lineview1);
        }];
        _greenlineview1.hidden = YES;

        
        _pwdTF = [[UITextField alloc] init];
        [_textFBackView addSubview:_pwdTF];
        [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.emailTextF);
            make.height.mas_equalTo(Adaptor_Value(35));
            make.top.mas_equalTo(weakSelf.emailTextF.mas_bottom).offset(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.textFBackView);
//            make.bottom.mas_equalTo(weakSelf.textFBackView).offset(-Adaptor_Value(5));
        }];
        _pwdTF.textColor = TitleBlackColor;
        _pwdTF.secureTextEntry = YES;
        [_pwdTF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _pwdTF.placeholder = [user_pass safeObjectAtIndex:1];
        _pwdTF.delegate = self;

        // "通过KVC修改placeholder的颜色"
        [_pwdTF setPlaceholderColor:TitleGrayColor font:nil];

        UIView *rowLine2 =  [UIView new];
        _lineview2 = rowLine2;
        rowLine2.backgroundColor = LihgtGreenColor;
        [_textFBackView addSubview:rowLine2];
        [rowLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *2);
            make.bottom.mas_equalTo(weakSelf.textFBackView);
            make.left.right.mas_equalTo(rowLine1);

        }];
        
        _greenlineview2 = [UIView new];
        _greenlineview2.backgroundColor = [UIColor greenColor];
        [_textFBackView addSubview:_greenlineview2];
        [_greenlineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX *3);
            make.left.right.mas_equalTo(weakSelf.lineview2);
            make.centerY.mas_equalTo(weakSelf.lineview2);
        }];
        _greenlineview2.hidden = YES;
        
        UIView *zhuceView = [UIView new];
        _zhuceView = zhuceView;
        [contentV addSubview:zhuceView];
        [zhuceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.textFBackView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.textFBackView);
            
        }];

        
        
        _zhuceChooseBtn = [[UIButton alloc] init];
        [_zhuceChooseBtn setImage:[UIImage imageNamed:@"ic_uncheck"]  forState:UIControlStateNormal];
        [_zhuceChooseBtn addTarget:self action:@selector(zhuceChooseBtnClick:) forControlEvents:UIControlEventTouchDown];
        [zhuceView addSubview:_zhuceChooseBtn];
        [_zhuceChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(zhuceView);
            make.height.width.mas_equalTo(Adaptor_Value(20));
        }];
        
        
        
        _zhuceTipLabel = [UILabel lableWithText:LanguageStrings(@"reg_new") textColor:[UIColor lq_colorWithHexString:@"#616161"] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [zhuceView addSubview:_zhuceTipLabel];
        [_zhuceTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.mas_equalTo(zhuceView);
            make.left.mas_equalTo(weakSelf.zhuceChooseBtn.mas_right).offset(Adaptor_Value(5));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zhuceTap:)];
        _zhuceTipLabel.userInteractionEnabled = YES;
        [_zhuceTipLabel addGestureRecognizer:tap];


        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_confirmBtn setTitle:lqStrings(@"登录") forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:BackGroundColor forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = AdaptedFontSize(16);

        _confirmBtn.backgroundColor = LihgtGreenColor;
        [contentV addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(zhuceView.mas_bottom).offset(Adaptor_Value(25));
            
        }];
        ViewRadius(_confirmBtn, Adaptor_Value(5));
        
        

        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:LanguageStrings(@"reset") forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(fogetBtnClick:) forControlEvents:UIControlEventTouchDown];
        _forgetBtn.titleLabel.font = AdaptedFontSize(17);
        [contentV addSubview:_forgetBtn];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.confirmBtn.mas_bottom).offset(Adaptor_Value(10));
            
        }];
        BOOL iszh = [ConfManager.shared.localLanguage isEqualToString:@"zh"];
        
        UIView *rowLine3 =  [UIView new];
        rowLine3.backgroundColor = LineGrayColor;
        [contentV addSubview:rowLine3];
        [rowLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kOnePX);
            make.left.right.mas_equalTo(weakSelf.textFBackView);
            make.top.mas_equalTo(weakSelf.forgetBtn.mas_bottom).offset(20);
            if (!iszh) {
                make.bottom.mas_equalTo(contentV);
            }
        }];
        
        _erweimaImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat_qr"]];
        [contentV addSubview:_erweimaImageV];
        [_erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(80));
            make.top.mas_equalTo(weakSelf.forgetBtn.mas_bottom).offset(Adaptor_Value(40));
            make.left.mas_equalTo(weakSelf.textFBackView);
            if (iszh) {
                make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            }
        }];
        _erweimaImageV.hidden = !iszh;
        
        UIView *rowLine4 =  [UIView new];
        rowLine4.backgroundColor = LineGrayColor;
        [contentV addSubview:rowLine4];
        [rowLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kOnePX);
            make.left.mas_equalTo(weakSelf.erweimaImageV.mas_right).offset(Adaptor_Value(10));
            
            make.top.mas_equalTo(weakSelf.erweimaImageV).offset(-Adaptor_Value(5));
            make.bottom.mas_equalTo(weakSelf.erweimaImageV).offset(Adaptor_Value(5));

        }];
        rowLine4.hidden = !iszh;

        
        _erweimaTipLable = [UILabel lableWithText:lqStrings(@"[bigjpg 人工智能] 微信公众号会定期推送超超超清美图壁纸插画和黑科技新功能") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_erweimaTipLable];
        [_erweimaTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.erweimaImageV);
            make.left.mas_equalTo(rowLine4.mas_right).offset(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        _erweimaTipLable.hidden = !iszh;

        
    }
    return _header;
}
- (UIView *)lorginTipView{
    if (!_lorginTipView) {
        _lorginTipView = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = BlueBackColor;
        [_lorginTipView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.lorginTipView);
        }];
        
        _lorgintimeBtn = [[UIButton alloc] init];
        [_lorgintimeBtn setTitle:lqStrings(@"") forState:UIControlStateNormal];
        [_lorgintimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [contentV addSubview:_lorgintimeBtn];
        [_lorgintimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentV.mas_centerY);
            make.centerX.mas_equalTo(contentV);
            
        }];

        _lorgintipBtn = [[UIButton alloc] init];
        NSArray *arr = [ConfManager.shared contentWith:@"version"];
        [_lorgintipBtn setTitle:[arr safeObjectAtIndex:0] forState:UIControlStateNormal];
        [_lorgintipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [contentV addSubview:_lorgintipBtn];
        [_lorgintipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.lorgintimeBtn);
            make.right.mas_equalTo(weakSelf.lorgintimeBtn.mas_left).offset(-Adaptor_Value(10));
            
        }];
        

        
        _lorginupdateBtn = [[UIButton alloc] init];
        [_lorginupdateBtn setTitle:LanguageStrings(@"upgrade") forState:UIControlStateNormal];
        [_lorginupdateBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_lorginupdateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lorginupdateBtn.titleLabel.font = AdaptedFontSize(15);
        [contentV addSubview:_lorginupdateBtn];
        CGFloat w = [LanguageStrings(@"upgrade") boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(17)} context:nil].size.width + Adaptor_Value(15);
        
        [_lorginupdateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.lorgintimeBtn);
            make.left.mas_equalTo(weakSelf.lorgintimeBtn.mas_right).offset(Adaptor_Value(10));
            make.width.mas_equalTo(w);
            
        }];
        _lorginupdateBtn.backgroundColor = LihgtGreenColor;
        ViewRadius(_lorginupdateBtn, Adaptor_Value(5));
        
        _lorgintotalTipLabel = [UILabel lableWithText:LanguageStrings(@"used") textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_lorgintotalTipLabel];
        [_lorgintotalTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.lorginupdateBtn.mas_bottom).offset(Adaptor_Value(15));
        }];
        ViewRadius(_lorginTipView, Adaptor_Value(10));

    }
    return _lorginTipView;
}
@end
