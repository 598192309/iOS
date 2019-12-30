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
#import "HomeTableViewCell.h"
@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerBackView;
@property (weak, nonatomic) IBOutlet UIButton *choiceImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *describerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<M_EnlargeUpload *> *dataSource;
@end

@implementation HomeViewController

#pragma mark ClassMethod
+ (instancetype)controller
{
    HomeViewController *vc = [UIStoryboard lq_controllerWithStoryBoardIdentify:@"HomeViewController" inStoryBoard:@"Home"];
    return vc;
}

#pragma mark LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray<M_EnlargeUpload *> array];
    

}

#pragma mark Action
- (IBAction)choiceImageEvent:(id)sender {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.allowSelectLivePhoto = NO;
    actionSheet.configuration.allowEditImage = NO;
    actionSheet.configuration.allowTakePhotoInLibrary = NO;
    actionSheet.configuration.allowSelectOriginal = NO;
    actionSheet.configuration.shouldAnialysisAsset = NO;
    actionSheet.configuration.maxSelectCount = 10;
    actionSheet.configuration.navBarColor= [UIColor whiteColor];
    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    actionSheet.configuration.bottomBtnsNormalTitleColor = [UIColor whiteColor];
    actionSheet.configuration.bottomBtnsDisableBgColor = RGBA(58, 167, 255, 0.5);
    actionSheet.sender = self;
            
    __weak typeof(self) weakSelf = self;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        for (PHAsset *ass in assets) {
            [[PHImageManager defaultManager] requestImageDataForAsset:ass options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                UIImage *image = [UIImage imageWithData:imageData];
                NSURL *fileUrl = [info safeObjectForKey:@"PHImageFileURLKey"];
                NSString *name = [fileUrl.absoluteString componentsSeparatedByString:@"/"].lastObject;
                M_EnlargeUpload *upload =  [[M_EnlargeUpload alloc] init];
                upload.imageData = imageData;
                NSString *sizeStr = @"";
                if (imageData.length < 1024) {
                    sizeStr = [NSString stringWithFormat:@"%dbytes",imageData.length];
                } else if (imageData.length / 1024.0 < 1024) {
                    sizeStr = [NSString stringWithFormat:@"%.1fkb",imageData.length/1024.0];
                } else {
                    sizeStr = [NSString stringWithFormat:@"%.1fM",imageData.length/1024.0/1024.0];
                }
                upload.imageSizeStr = [NSString stringWithFormat:@"%@,%dx%dpx",sizeStr,image.size.width,image.size.height];
                if (imageData.length / 1024.0 / 1024.0 > 10 || image.size.width > 3000 || image.size.height > 3000) {
                    upload.isOverSize = YES;
                }
                M_EnlargeConf *conf = [[M_EnlargeConf alloc] init];
                conf.files_size = imageData.length;
                conf.file_width = image.size.width;
                conf.file_height = image.size.height;
                conf.file_name = [NSString stringWithFormat:@"ios/%@/%@",[LqToolKit stringFromDate:[NSDate date] formatterString:@"yyyy-MM-dd/hh-mm-ss"],name];
                conf.x2 = 3;
                conf.noise =3;
                conf.style = @"art";
                upload.conf = conf;
                
                [weakSelf.dataSource insertObject:upload atIndex:0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }];
            
            
        }

    }];
    [actionSheet showPhotoLibrary];
}


#pragma mark UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableViewCell class])];
    cell.upload = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
