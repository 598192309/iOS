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
    _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",nil];
    //超时
    _manager.requestSerializer.timeoutInterval = 15;

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

    URLString=[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
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
