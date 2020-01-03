//
//  SettingCustomView.h
//  Bigjpg
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_User;
NS_ASSUME_NONNULL_BEGIN

@interface SettingCustomView : UIView
/**点击升级*/
@property(nonatomic,copy)void(^settingCustomViewUpdateBtnClickBlock)(NSDictionary *dict);
/**点击忘记密码*/
@property(nonatomic,copy)void(^settingCustomViewForgetBtnClickBlock)(NSDictionary *dict);

/**点击登录*/
@property(nonatomic,copy)void(^settingCustomViewConfirmBtnClickBlock)(NSDictionary *dict,UIButton *sender);


- (void)configUIWithItem:(M_User *)item finishi:(void(^)())finishBlock;
@end

NS_ASSUME_NONNULL_END
