//
//  I_Enlarge.m
//  Bigjpg
//
//  Created by lqq on 2019/12/26.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "I_Enlarge.h"

@implementation I_Enlarge
+ (NetworkTask *)retryEnlargeTasks:(NSArray*)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
    NSDictionary *params = @{@"fids":value};
    return [NET GET:@"retry" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
           NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
           if([status isEqualToString:@"ok"]){
               successBlock();
           }else{
               failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
           }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           failureBlock(error);
    }];
}

+ (NetworkTask *)getEnlargeTasksStatus:(NSArray<NSString *> *)fids success:(void(^)(NSMutableArray<M_Enlarge *> *taskList))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
    NSDictionary *params = @{@"fids":value};
   return [NET GET:@"free" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
       NSDictionary *result = resultObject;
       NSArray *fids = result.allKeys;
       NSMutableArray<M_Enlarge *>* list = [NSMutableArray<M_Enlarge *> array];
       for (NSString *key in fids) {
           M_Enlarge *task = [[M_Enlarge alloc] init];
           task.fid = key;
           NSArray *value = [result safeObjectForKey:key];
           task.status = [value safeObjectAtIndex:0];
           task.output = [value safeObjectAtIndex:1];
           [list addObject:task];
       }
       successBlock(list);
   } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
          failureBlock(error);
   }];
}

+ (NetworkTask *)deleteEnlargeTasks:(NSArray *)fids success:(void(^)(void))successBlock failure:(ErrorBlock)failureBlock
{
    NSString *value = [fids mj_JSONString];
     NSDictionary *params = @{@"fids":value};
    return [NET DELETE:@"free" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
           if([status isEqualToString:@"ok"]){
               successBlock();
           }else{
               failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
           }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           failureBlock(error);
    }];
}


+ (NetworkTask *)createEnlargeTask:(int )x2
     style:(NSString *)style
     noise:(int)noise
  fileName:(NSString *)fileName
  fileSize:(long)fileSize
fileHeight:(long)fileHeight
 fileWidth:(long)filetWidth
     input:(NSString *)input
   success:(void(^)(NSString *fid, NSInteger time))successBlock
   failure:(ErrorBlock)failureBlock {
    
    NSDictionary *jsonDic = @{@"x2":@(x2),@"style":SAFE_NIL_STRING(style),@"noise":@(noise),@"file_name":SAFE_NIL_STRING(fileName),@"files_size":@(fileSize),@"file_height":@(fileHeight),@"file_width":@(filetWidth),@"input":SAFE_NIL_STRING(input)};
    
    NSString *value = [jsonDic mj_JSONString];
    NSDictionary *params = @{@"conf":SAFE_NIL_STRING(value)};
    return [NET POST:@"task" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        if([status isEqualToString:@"ok"]){
            NSString *fid = SAFE_VALUE_FOR_KEY(resultObject, @"info");
            NSInteger time = [SAFE_VALUE_FOR_KEY(resultObject, @"time") integerValue];
            successBlock(fid,time);
        }else{
            failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}


+ (NetworkTask *)createEnlargeTaskWith:(M_EnlargeConf *)conf
success:(void(^)(NSString *fid, NSInteger time))successBlock
failure:(ErrorBlock)failureBlock
{
    NSString *value = [conf mj_JSONString];
    NSDictionary *params = @{@"conf":SAFE_NIL_STRING(value)};
    return [NET POST:@"task" parameters:params criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSString *status = SAFE_VALUE_FOR_KEY(resultObject, @"status");//ok代表成功
        if([status isEqualToString:@"ok"]){
            NSString *fid = SAFE_VALUE_FOR_KEY(resultObject, @"info");
            NSInteger time = [SAFE_VALUE_FOR_KEY(resultObject, @"time") integerValue];
            successBlock(fid,time);
        }else{
            failureBlock([NSError lq_errorWithMsg:status domain:@"Response Error" code:10000]);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end
