//
//  I_Account.m
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Account.h"

@implementation I_Account
+ (NetworkTask *)loginOrRegistWithUserName:(NSString *)userName pwd:(NSString *)pwd notReg:(BOOL)notReg success:(void(^)(M_Account *account))successBlock failure:(ErrorBlock)failureBlock
{
    NSDictionary *param = @{@"username":SAFE_NIL_STRING(userName),@"password":SAFE_NIL_STRING(pwd),@"not_reg":@(1)};
    return [NET POST:@"/login" parameters:param criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

+ (NetworkTask *)getUserInfoOnSuccess:(void(^)(NSDictionary *result))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET GET:@"user" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

+ (NetworkTask *)updatePassword:(NSString *)password success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    return [NET POST:@"user" parameters:@{@"new":SAFE_NIL_STRING(password)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

+ (NetworkTask *)retryEnlargeTasks:(NSArray*)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
    NSDictionary *params = @{@"fids":value};
    return [NET GET:@"retry" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
           
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           
    }];
}

+ (NetworkTask *)getEnlargeTasksStatus:(NSArray *)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
    NSDictionary *params = @{@"fids":value};
   return [NET GET:@"free" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
          
   } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
          
   }];
}

+ (NetworkTask *)deleteEnlargeTasks:(NSArray *)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
     NSDictionary *params = @{@"fids":value};
    return [NET DELETE:@"free" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
           
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           
    }];
}
@end
