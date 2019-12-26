//
//  HomeViewController.m
//  Bigjpg
//
//  Created by rabi on 2019/12/23.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HomeViewController.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser.h>
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
            [ZLPhotoManager anialysisAssets:assets original:YES completion:^(NSArray<UIImage *> * _Nonnull images) {
                
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
