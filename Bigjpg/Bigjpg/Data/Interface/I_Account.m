//
//  I_Account.m
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Account.h"

@implementation I_Account
+ (NetworkTask *)loginOrRegistWithUserName:(NSString *)userName pwd:(NSString *)pwd notReg:(BOOL)notReg success:(void(^)(M_User *userInfo))successBlock failure:(ErrorBlock)failureBlock
{
    NSDictionary *param;
    if (notReg) {
        param = @{@"username":SAFE_NIL_STRING(userName),@"password":SAFE_NIL_STRING(pwd)};
    } else {
        param = @{@"username":SAFE_NIL_STRING(userName),@"password":SAFE_NIL_STRING(pwd),@"not_reg":@(1)};
    }
    
    return [NET POST:@"/login" parameters:param criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
         if([status isEqualToString:@"ok"]){
             M_User *account = [M_User mj_objectWithKeyValues:resultObject];
             RI.userInfo = account;
             RI.is_logined = YES;
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignIn object:nil];
             successBlock(account);
         }else{
             failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
         }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (NetworkTask *)getUserInfoOnSuccess:(void(^)(M_User *userInfo))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET GET:@"user" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        if([status isEqualToString:@"ok"]){
            M_User *account = [M_User mj_objectWithKeyValues:[resultObject safeObjectForKey:@"user"]];
            NSMutableArray *historyList = [NSMutableArray array];
            NSArray *logs = [resultObject safeObjectForKey:@"logs"];
            for (int i = 0 ; i < logs.count; i++) {
                M_EnlargeHistory *history = [[M_EnlargeHistory alloc] init];
                NSArray *log = logs[i];
                NSDictionary *confDic = [log safeObjectAtIndex:0];
                M_EnlargeConf *conf = [M_EnlargeConf mj_objectWithKeyValues:confDic];
                history.conf = conf;
                history.output = [log safeObjectAtIndex:1];
                history.createTime = [log safeObjectAtIndex:2];
                history.status =  [log safeObjectAtIndex:3];
                history.fid =  [log safeObjectAtIndex:4];
                
                [historyList safeAddObject:history];
            }
            account.historyList = historyList;
            RI.userInfo = account;
            successBlock(account);
        }else{
            failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (NetworkTask *)updatePassword:(NSString *)password success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET POST:@"user" parameters:@{@"new":SAFE_NIL_STRING(password)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        if([status isEqualToString:@"ok"]){
            successBlock();
        }else{
            failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (NetworkTask *)resetPwd:(NSString *)userName success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET POST:@"reset" parameters:@{@"username":SAFE_NIL_STRING(userName)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        if([status isEqualToString:@"ok"]){
            successBlock();
        }else{
            failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (NetworkTask *)requestConfOnSuccess:(void(^)(NSDictionary *confDic))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET GET:@"conf" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [ConfManager.shared updateConf:resultObject];
        successBlock(resultObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)loginOutOnSuccessOnSuccess:(void(^)(void))successBlock
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tmpArrey = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in tmpArrey) {
        [cookieJar deleteCookie:obj];
    }
    RI.is_logined = NO;
    RI.userInfo = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSignOut object:nil];

    successBlock();

}


/// 内购
/// @param userName 用户名
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
+ (NetworkTask *)authWithUserName:(NSString *)userName product_id:(NSString *)product_id transaction_id:(NSString *)transaction_id receipt_data:(NSString *)receipt_data success:(void(^)(NSDictionary *response))successBlock failure:(ErrorBlock)failureBlock{
//    @"username":SAFE_NIL_STRING(userName),

    NSDictionary *param = @{@"receipt-data":SAFE_NIL_STRING(receipt_data),@"product_id":SAFE_NIL_STRING(product_id),@"transaction_id":SAFE_NIL_STRING(transaction_id)} ;
    return [NET POST:@"/apple_verify" parameters:param criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        successBlock(resultObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end
