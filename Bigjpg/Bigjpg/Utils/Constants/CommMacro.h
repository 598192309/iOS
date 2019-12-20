//
//  CommMacro.h
//  FullShareTop
//
//  Created by lqq on 17/3/21.
//  Copyright © 2017年 FSB. All rights reserved.
//

#ifndef CommMacro_h
#define CommMacro_h



/**
 *  非DEBUG模式，禁用NSLog();
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif



/**
 *  发送通知
 */
#define POST_NOTIFY(_name_,_content_) ([[NSNotificationCenter defaultCenter] postNotificationName:_name_ object:_content_])

/**
 *  系统版本
 */
#define SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]


/**
 *  屏幕尺寸
 */
#define kDeviceWidth        [UIScreen mainScreen].bounds.size.width

#define kDeviceHeight        [UIScreen mainScreen].bounds.size.height

#define kNavigationH      64

/**
 *  真1像素
 */
#define kOnePX            1/[[UIScreen mainScreen] scale]


// 颜色
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]


// 生成颜色支持透明度
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



// 加载图片
#define IMG_NAME(name)   [UIImage imageNamed:name]

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//强引用
#define StrongSelf(type)  __strong typeof(type) type = weak##type;






#endif
