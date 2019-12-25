//
//  I_Account.h
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Base.h"
#import "M_Account.h"
NS_ASSUME_NONNULL_BEGIN

@interface I_Account : I_Base
+ (NetworkTask *)loginOrRegistWithUserName:(NSString *)userName pwd:(NSString *)pwd notReg:(BOOL)notReg success:(void(^)(M_Account *account))successBlock failure:(ErrorBlock)failureBlock;

+ (NetworkTask *)getUserInfoOnSuccess:(void(^)(NSDictionary *result))successBlock failure:(ErrorBlock)failureBlock;

+ (NetworkTask *)updatePassword:(NSString *)password success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock;

+ (NetworkTask *)retryEnlargeTasks:(NSArray*)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock;

+ (NetworkTask *)getEnlargeTasksStatus:(NSArray *)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock;

+ (NetworkTask *)deleteEnlargeTasks:(NSArray *)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock;


@end

NS_ASSUME_NONNULL_END
