//
//  RunInfo.m
//  stock
//
//  Created by Lqq on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//


#define ACCOUNT_KEY  @"ACCOUNT_KEY"

#import "RunInfo.h"



@implementation RunInfo{
    
}

+ (RunInfo *)sharedInstance
{
    static dispatch_once_t t;
    static RunInfo *sharedInstance = nil;
    dispatch_once(&t, ^{
        sharedInstance = [[RunInfo alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self){
        _is_logined = [[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] boolValue] : false;
        _isNight = [[NSUserDefaults standardUserDefaults ] objectForKey:kIsNight] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:kIsNight] boolValue] : false;


    }
    return self;
}



-(void)setIs_logined:(BOOL)is_logined{
    _is_logined = is_logined;
    [[NSUserDefaults standardUserDefaults] setBool:is_logined forKey:kUserSignIn];
}

- (void)setIsNight:(BOOL)isNight{
    _isNight = isNight;
    [[NSUserDefaults standardUserDefaults] setBool:isNight forKey:kIsNight];

}
@end
