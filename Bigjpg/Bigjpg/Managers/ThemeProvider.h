//
//  ThemeProvider.h
//  stock
//
//  Created by Lqq on 14-4-3.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TP ([ThemeProvider sharedInstance])


@interface ThemeProvider : NSObject

+ (ThemeProvider *)sharedInstance;

@property (nonatomic, strong) UIColor *controllerBackColor;

@end
