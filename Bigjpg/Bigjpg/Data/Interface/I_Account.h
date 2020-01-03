//
//  I_Account.h
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Base.h"
#import "M_User.h"

NS_ASSUME_NONNULL_BEGIN

@interface I_Account : I_Base


/// 登录h/创建用户
/// @param userName 用户名
/// @param pwd 密码
/// @param notReg 是否注册新用户
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (NetworkTask *)loginOrRegistWithUserName:(NSString *)userName pwd:(NSString *)pwd notReg:(BOOL)notReg success:(void(^)(M_User *userInfo))successBlock failure:(ErrorBlock)failureBlock;


/// 用户信息查询
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (NetworkTask *)getUserInfoOnSuccess:(void(^)(M_User *userInfo))successBlock failure:(ErrorBlock)failureBlock;


/// 用户登录密码d更新
/// @param password 新密码
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (NetworkTask *)updatePassword:(NSString *)password success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock;

/// 获取语言配置、oss配置
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (NetworkTask *)requestConfOnSuccess:(void(^)(NSDictionary *confDic))successBlock failure:(ErrorBlock)failureBlock;


/// 登出
/// @param successBlock 登出必然成功
+ (void)loginOutOnSuccessOnSuccess:(void(^)(void))successBlock;
@end

NS_ASSUME_NONNULL_END
