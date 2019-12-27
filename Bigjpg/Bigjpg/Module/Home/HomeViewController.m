//
//  HomeViewController.m
//  Bigjpg
//
//  Created by rabi on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HomeViewController.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser.h>
#import "I_Enlarge.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //test
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"添加图片" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)addPic
{
       ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
        actionSheet.configuration.allowSelectGif = NO;
        actionSheet.configuration.allowSelectVideo = NO;
        actionSheet.configuration.allowSelectLivePhoto = NO;
        actionSheet.configuration.allowEditImage = NO;
        actionSheet.configuration.allowTakePhotoInLibrary = NO;
        actionSheet.configuration.allowSelectOriginal = NO;
    actionSheet.configuration.shouldAnialysisAsset = NO;
        actionSheet.configuration.maxSelectCount = 10;
//        actionSheet.configuration.navBarColor= HEXColor(@"#3AA7FF");
        actionSheet.configuration.navTitleColor = [UIColor whiteColor];
//        actionSheet.configuration.bottomBtnsNormalTitleColor = HEXColor(@"3AA7FF");
        actionSheet.configuration.bottomBtnsDisableBgColor = RGBA(58, 167, 255, 0.5);
        actionSheet.sender = self;
        
        __weak typeof(self) weakSelf = self;
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            
            
            for (PHAsset *ass in assets) {
                [[PHImageManager defaultManager] requestImageDataForAsset:ass options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                    
                }];
            }
            
            return ;
            [ZLPhotoManager anialysisAssets:assets original:YES completion:^(NSArray<UIImage *> * _Nonnull images) {
                NSMutableArray *arr = [NSMutableArray array];
                for (UIImage * img in images) {
                    M_EnlargeConf *conf = [[M_EnlargeConf alloc] init];
                    NSData *data = UIImagePNGRepresentation(img);
                    conf.files_size = data.length;
                    conf.file_width = img.size.width;
                    conf.file_height = img.size.height;
                    conf.file_name = [NSString stringWithFormat:@"ios-%@",[NSDate date].description];
                    conf.x2 = 3;
                    conf.noise =3;
                    conf.style = @"art";
                    
                    
                }
                
                
                NSString *objectKey = @"afsa";
                [OSSManager asyncUploadImage:images[0] objectKey:objectKey progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                    
                } success:^(OSSTask * _Nonnull task) {
//                    OSSPutObjectResult *result = task.result;
                    NSString *input = [NSString stringWithFormat:@"%@/%@",[OSSManager getOSSUrl],objectKey];
                    
//                    [I_Enlarge createEnlargeTask:1 style:@"art" noise:4 fileName:@"" fileSize:<#(long)#> fileHeight:<#(long)#> fileWidth:<#(long)#> input:<#(nonnull NSString *)#> success:<#^(NSString * _Nonnull fid, NSInteger time)successBlock#> failure:<#^(NSError *error)failureBlock#>]
                    
                    
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }];
            
//            [AV showLoading:@"正在上传"];
//            [I_Media upLoadImages:images success:^(NSArray *urls) {
//                [I_Media saveMediaWithMediaUrls:urls objectId:weakSelf.trainId success:^(NSMutableArray *mediaList) {
//                    [AV hideen];
//                    [weakSelf requestTrainDetail];
//                } failure:^(NSError *error) {
//                    [AV showError:error];
//                }];
//            } failure:^(NSError *error) {
//                [AV showErrorMessage:@"照片上传失败"];
//            }];
        }];
        [actionSheet showPhotoLibrary];
}

@end
