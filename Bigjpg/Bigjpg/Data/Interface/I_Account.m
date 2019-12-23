//
//  I_Account.m
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Account.h"

@implementation I_Account
+ (NetworkTask *)loginOrRegistWithUserName:(NSString *)userName pwd:(NSString *)pwd notReg:(BOOL)notReg success:(void(^)(M_Account *account)) failure:(ErrorBlock)failureBlock
{
    NSDictionary *param = @{@"username":SAFE_NIL_STRING(userName),@"password":SAFE_NIL_STRING(pwd)};
    return [NET POST:@"/login" parameters:param criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}
@end
