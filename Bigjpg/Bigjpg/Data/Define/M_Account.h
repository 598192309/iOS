//
//  M_Account.h
//  Bigjpg
//
//  Created by lqq on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "M_Base.h"

NS_ASSUME_NONNULL_BEGIN

@interface M_Account : M_Base
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) BOOL is_expire;
@end

NS_ASSUME_NONNULL_END
