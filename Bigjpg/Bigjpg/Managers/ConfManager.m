//
//  ConfManager.m
//  Bigjpg
//
//  Created by 黎芹 on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "ConfManager.h"

@implementation ConfManager

+ (ConfManager *)shared
{
    static dispatch_once_t t;
    static ConfManager *sharedInstance = nil;
    dispatch_once(&t, ^{
        sharedInstance = [[ConfManager alloc] init];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSDictionary *conf = [def objectForKey:@"Conf"];
        if (conf == nil) {
            NSDictionary *defaultDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Conf" ofType:@"plist"]];
            conf = [defaultDic safeObjectForKey:@"Conf"];
            
        }
        //初始化设置conf
        sharedInstance.conf = conf;
        //初始化设置localLanguage
        sharedInstance.localLanguage = [ConfManager defaultLocalLanguage];
        
    });
    return sharedInstance;
}
//更新配置
- (void)updateConf:(NSDictionary *)conf
{
    if (conf == nil) {
        return;
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:conf forKey:@"Conf"];
    [def synchronize];
    self.conf = conf;
}




/// OSS配置
- (NSDictionary *)app_oss_conf
{
    return [self.conf safeObjectForKey:@"app_oss_conf"];
}

- (NSString *)oss_endpoint{
    return [[self app_oss_conf] safeObjectForKey:@"endpoint"];
}

- (NSString *)oss_accesskeysecret {
    return [[self app_oss_conf] safeObjectForKey:@"accesskeysecret"];
}

- (NSString *)oss_bucket {
    return [[self app_oss_conf] safeObjectForKey:@"bucket"];
}

-(NSString *)oss_accesskeyid {
    return [[self app_oss_conf] safeObjectForKey:@"accesskeyid"];
}



/// 语言
- (NSDictionary *)lng_dict
{
     return [self.conf safeObjectForKey:@"lng_dict"];
}

//根据key获取对应的字符串
- (id)contentWith:(NSString *)key
{
    NSDictionary *valueDic = [[self lng_dict] safeObjectForKey:key];
    if (valueDic == nil) {
        return key;
    }
    id value = [valueDic safeObjectForKey:_localLanguage];
    return value;
}
//确定是字符串时可以使用此方法
- (NSString *)strContentWith:(NSString *)key
{
    NSDictionary *valueDic = [[self lng_dict] safeObjectForKey:key];
    if (valueDic == nil) {
        return key;
    }
    NSString *value = [valueDic safeObjectForKey:_localLanguage];
    return value;
}

-(void)setLocalLanguage:(NSString *)localLanguage
{
    _localLanguage = localLanguage;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:localLanguage forKey:@"localLanguage"];
    [def synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeLanguageNotification object:nil];
}

+ (NSString *)defaultLocalLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def objectForKey:@"localLanguage"];
    if (language == nil) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if ([currentLanguage containsString:@"zh"]) {
            return @"zh";
        } else if ([currentLanguage containsString:@"en"]) {
            return @"en";
        } else if ([currentLanguage containsString:@"tw"]) {
            return @"tw";
        } else if ([currentLanguage containsString:@"tr"]) {
            return @"tr";
        } else if ([currentLanguage containsString:@"jp"]) {
            return @"jp";
        } else if ([currentLanguage containsString:@"de"]) {
            return @"de";
        } else if ([currentLanguage containsString:@"ru"]) {
            return @"ru";
        } else {
            return @"en";
        }
    }
    return language;
}


@end
