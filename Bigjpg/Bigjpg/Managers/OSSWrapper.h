////
////  OSSWrapper.h
////  Bigjpg
////
////  Created by JS on 2019/12/26.
////  Copyright © 2019 lqq. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface OSSWrapper : NSObject
//
///**
// upload image asynchronously
// @param objectKey object's key
// @param filePath local file's path
// @param success success block
// @param failure failure block
// */
//- (void)asyncPutImage:(NSString *)objectKey
//        localFilePath:(NSString *)filePath
//              success:(void (^_Nullable)(id))success
//              failure:(void (^_Nullable)(NSError*))failure;
//
//
///**
// get image data asynchronously
// @param objectKey object's key
// @param success success block
// @param failure failure block
// */
//- (void)asyncGetImage:(NSString *)objectKey
//              success:(void (^_Nullable)(id))success
//              failure:(void (^_Nullable)(NSError*))failure;
//
//
///**
// cancel normal upload/download request.
// */
//- (void)normalRequestCancel;
//
//
///**
// trigger callback to business server.
// @param objectKey object's key
// @param success success block
// @param failure failure block
// */
//- (void)triggerCallbackWithObjectKey:(NSString *)objectKey success:(void (^_Nullable)(id))success failure:(void (^_Nullable)(NSError*))failure;
//
//
///**
// use API which named multipartUpload to upload big file.
// @param success success block
// @param failure failure block
// */
//- (void)multipartUploadWithSuccess:(void (^_Nullable)(id))success failure:(void (^_Nullable)(NSError*))failure;
//
//// ==========================image process===============================//
///**
// *    @brief    watermark
// *
// *    @param     object  object's key
// *    @param     text     text
// *    @param     size     font size
// */
//- (void)textWaterMark:(NSString *)object
//            waterText:(NSString *)text
//           objectSize:(int)size
//              success:(void (^_Nullable)(id))success
//              failure:(void (^_Nullable)(NSError*))failure;
//
///**
// *    @brief    zoom process
// *
// *    @param     object    object's key
// *    @param     width     width
// *    @param     height    height
// */
//- (void)reSize:(NSString *) object
//      picWidth:(int) width
//     picHeight:(int) height
//       success:(void (^_Nullable)(id))success
//       failure:(void (^_Nullable)(NSError*))failure;
//@end
//
//NS_ASSUME_NONNULL_END
