//
//  RunInfo.h
//  stock
//
//  Created by Lqq on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//




#define RI ([RunInfo sharedInstance])


#import <UIKit/UIKit.h>

@interface RunInfo : NSObject

+ (RunInfo *)sharedInstance;

@end
