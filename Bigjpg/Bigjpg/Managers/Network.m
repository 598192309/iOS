//
//  Network.m
//  fullsharetop
//
//  Created by lqq on 16/9/13.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import "Network.h"
#import "AFHTTPSessionManager.h"
#import "Network.h"
#import<CommonCrypto/CommonDigest.h>




#define SignAPPID   @"123456"
#define SignAppSecurityKey   @"d67266586dffe8085126f3383afe8e3c"


@implementation NetworkTask{
    NSURLSessionDataTask *_sessionDatatask;
}

+ (instancetype)netWorkWithSessionDataTask:(NSURLSessionDataTask*)task{
    NetworkTask *atask=[[NetworkTask alloc] init];
    atask->_sessionDatatask=task;
    return atask;
}

- (void)cancel{
    [_sessionDatatask cancel];
}

- (void)suspend{
    [_sessionDatatask suspend];
}

- (void)resume{
    [_sessionDatatask resume];
}
@end







@implementation Network{
    AFHTTPSessionManager *_manager;
    NSString *_appVersion;
    NSString *_clientType;
    BOOL      _isTest;
}

+(instancetype)shareInstance{
    static Network *network=nil;
    static dispatch_once_t singlet;
    dispatch_once(&singlet, ^{
        network=[[Network alloc] init];
    });
    return network;
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self instannceManagerWithHost:KHOST];
    }
    return self;
}

-(void)instannceManagerWithHost:(NSString*)host{
    _manager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:host]];
    
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _manager.securityPolicy.allowInvalidCertificates = YES;
    [_manager.securityPolicy setValidatesDomainName:NO];
    // 二进制格式
    _manager.requestSerializer=[AFJSONRequestSerializer serializer];
    // 设置接受文本类型
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // 设置接受文本类型
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    // 二进制格式
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置接受文本类型
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json",nil];

    //客户端类型
    [_manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
    //客户端版本
//    [_manager.requestSerializer setValue:[LqToolKit appVersionNo] forHTTPHeaderField:@"appVersion"];
    //操作系统版本
    [_manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"osVersion"];
    //手机型号
//    [_manager.requestSerializer setValue:[KKUUID getDeviceModel] forHTTPHeaderField:@"mode"];
    //渠道
    [_manager.requestSerializer setValue:@"appstore" forHTTPHeaderField:@"channel"];
    //手机品牌
    [_manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"brand"];
    //deviceID
//    [_manager.requestSerializer setValue:[KKUUID getUUID] forHTTPHeaderField:@"deviceId"];
    
    //超时
    _manager.requestSerializer.timeoutInterval = 15;
    //idfa
//
//    [_manager.requestSerializer setValue:[KKUUID getIDFA] forHTTPHeaderField:@"idfa"];
    
    //appid
    [_manager.requestSerializer setValue:SignAPPID forHTTPHeaderField:@"appid"];
}

- (void)changeHost:(NSNotification *)noti
{
    NSString *host = [noti.object safeObjectForKey:@"host"];
    if (host) {
        [self instannceManagerWithHost:host];
    }
    
}


- (nullable NetworkTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                 criticalValue:(nullable NSDictionary*)criticalValue
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure{
//    if (![Toolkit isNetworkConnect]) {
//        NSError *netError = [NSError errorWithMsg:@"网络不给力，点击重试" domain:@"" code:NetErrorCode];
//        failure(nil,netError);
//        return nil;
//    }
    
//    if ([KHOST isEqualToString:@"https://api.donkeyplay.com"]) {
//        URLString = [@"/test" stringByAppendingString:URLString];
//    }
    URLString=[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self signHeaderWithParams:parameters];
    [self _refreshHeaderWithCriticalValue:criticalValue];

    NSURLSessionDataTask *t = [_manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self _handdleSuccessWithTask:task responseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self _handdleFailureWithTask:task error:error failure:failure];
    }];
    
    return [NetworkTask netWorkWithSessionDataTask:t];
}


- (nullable NetworkTask *)GET:(NSString *)URLString
                   parameters:(nullable id)parameters
                criticalValue:(nullable NSDictionary*)criticalValue
                      success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

    URLString=[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self signHeaderWithParams:parameters];
    [self _refreshHeaderWithCriticalValue:criticalValue];
    
    NSURLSessionDataTask *t = [_manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self _handdleSuccessWithTask:task responseObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self _handdleFailureWithTask:task error:error failure:failure];
    }];
    
    return [NetworkTask netWorkWithSessionDataTask:t];
}


#pragma mark -Pravite
/**
 *  刷新请求头
 *
 *  @param criticalValue 放到加密的内容（防止篡改）
 */
-(void)_refreshHeaderWithCriticalValue:(NSDictionary*)criticalValue
{
   
    
}


- (void)signHeaderWithParams:(id)parameters
{
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",time] forHTTPHeaderField:@"clienttime"];
    
    NSString *body = @"";
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = parameters;
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
        
        NSRange range = {0,jsonStr.length};
        //去掉字符串中的空格
        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        
        body = mutStr;
    } else if ([parameters isKindOfClass:[NSString class]]) {
        body = parameters;
    }
    
    
    
    NSString *sign = [NSString stringWithFormat:@"%@%@fullshare%lld%@",body,SignAPPID,time*10,SignAppSecurityKey];
    NSString *md5sign = [RSAEncryptor MD5WithString:sign];
    [_manager.requestSerializer setValue:md5sign forHTTPHeaderField:@"requestsign"];
}

/**
 *  处理成功请求
 */
-(void)_handdleSuccessWithTask:(NSURLSessionDataTask*)task
                responseObject:(id)responseObject
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    if (![responseObject isKindOfClass:[NSDictionary class]] ) {
//        failure(task,[NSError errorWithMsg:@"服务器在开小差，请稍后再试。" domain:@"Server Error" code:505]);
    }else{
        
        NSInteger resCode = [SAFE_VALUE_FOR_KEY(responseObject, @"code") integerValue];//200代表成功
        if(resCode != 200){
            NSString *errorMsgString=SAFE_VALUE_FOR_KEY(responseObject, @"msg");
            if([errorMsgString length]==0){
                errorMsgString  =@"未知错误";
                resCode = -100;
            }
            
      
//            failure(task,[NSError errorWithMsg:errorMsgString domain:@"Request Error" code:resCode]);
            
        }else{
            success(task,responseObject);
        }
    }
}

/**
 *  处理失败请求
 */
-(void)_handdleFailureWithTask:(NSURLSessionDataTask*)task
                         error:(NSError*)error
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString *errorMsgString=nil;
    NSData *errorData=SAFE_VALUE_FOR_KEY(error.userInfo, AFNetworkingOperationFailingURLResponseDataErrorKey);
    NSInteger errorCode=-99999;
    if([errorData isKindOfClass:[NSData class]]){
        id errorMsg=[NSJSONSerialization JSONObjectWithData:SAFE_VALUE_FOR_KEY(error.userInfo, AFNetworkingOperationFailingURLResponseDataErrorKey) options:NSJSONReadingAllowFragments error:&error];
        if([errorMsg isKindOfClass:[NSDictionary class]]){
            errorMsgString=SAFE_VALUE_FOR_KEY(errorMsg, @"message");
            errorCode=[SAFE_VALUE_FOR_KEY(errorMsg, @"status") integerValue];
        }else if ([errorMsg isKindOfClass:[NSString class]]){
            errorMsgString=errorMsg;
        }
    }else{
        errorMsgString=[error localizedDescription];
    }
    if(![errorMsgString isKindOfClass:[NSString class]]||[errorMsgString length]==0){
        errorMsgString=@"网络不给力，点击重试";
    }
    if ([errorMsgString containsString:@"似乎已断开与互联网的连接"] || [errorMsgString containsString:@"未能读取数据"]) {
        errorMsgString = @"网络不给力，点击重试";
    }
//    failure(task,[NSError errorWithMsg:errorMsgString domain:error.domain code:errorCode==-99999?error.code:errorCode]);
}

-(void)setCookie:(NSString*)key
           value:(NSString*)value{

    NSString *cookiestring=nil;
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([cookie.name isEqualToString:key]) {
            continue;
        }
        if (cookiestring) {
            cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,cookie.name,cookie.value];
        }else{
            cookiestring=[NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
        }
    }
    if (cookiestring) {
        cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,key,value];
    }else{
        cookiestring=[NSString stringWithFormat:@"%@=%@",key,value];
    }
    [_manager.requestSerializer setValue:cookiestring forHTTPHeaderField:@"Cookie"];
}


- (NSString *)h5host
{
    if ([KHOST isEqualToString:@"https://api.cloudfighting.com"]) {
        return @"http://m.cloudfighting.com";
    }
    return @"http://m.donkeyplay.com";
}


@end
