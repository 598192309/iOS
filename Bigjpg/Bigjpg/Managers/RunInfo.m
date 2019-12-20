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

    }
    return self;
}






@end
