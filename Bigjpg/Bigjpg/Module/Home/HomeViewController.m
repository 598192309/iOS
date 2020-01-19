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

@property (nonatomic, strong) NSMutableArray *pollingFids;
@property (nonatomic, strong) NSTimer *timer;
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
    
    _pollingFids = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enlargeConfSuccess:) name:kEnlargeConfigarationFinishNoti object:nil];
    _dataSource = [NSMutableArray<M_EnlargeUpload *> array];
    //切换夜间模式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNight) name:kChangeNightNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_timer == nil) {
        self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(polling) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.timer setFireDate:[NSDate date]];
    }
    [self configUI];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI{
    _choiceImageBtn.layer.cornerRadius = 4;
    _choiceImageBtn.layer.masksToBounds = YES;
    [_choiceImageBtn setTitle:LanguageStrings(@"fileupload") forState:UIControlStateNormal];
    _describerLabel.text = LanguageStrings(@"limit");
    _describerLabel.adjustsFontSizeToFitWidth = YES;
    
    self.view.backgroundColor = BackGroundColor;
    self.tableView.backgroundColor = BackGroundColor;
    self.headerBackView.backgroundColor = RI.isNight ? RGB(31, 31, 31) : RGB(238, 238, 238);
    self.describerLabel.textColor = RI.isNight ? TitleGrayColor : [UIColor lq_colorWithHexString:@"9A9A9A"];
    
    ViewRadius(_headerBackView, 4);

}

- (void)polling
{
    if (self.pollingFids.count == 0) {
        [self.tableView reloadData];
        return;
   }
    if (self.isVisible) {
        __weak __typeof(self) weakSelf = self;
       
        [I_Enlarge getEnlargeTasksStatus:self.pollingFids success:^(NSMutableArray<M_Enlarge *> * _Nonnull taskList) {
            for (M_Enlarge *task in taskList) {
                for (M_EnlargeUpload *upload in self.dataSource) {
                    if ([task.fid isEqualToString:upload.fid]) {
                        upload.status = task.status;
                        if ([task.status isEqualToString:@"new"]) {
                            upload.uploadStep = EnlargeUploadStepEnlargeingNew;
                        } else if ([task.status isEqualToString:@"process"]) {
                            upload.uploadStep = EnlargeUploadStepEnlargeingProcess;
                        } else if ([task.status isEqualToString:@"error"]) {
                            upload.uploadStep = EnlargeUploadStepEnlargeError;
                        } else if ([task.status isEqualToString:@"success"]) {
                            upload.output = task.output;
                            upload.uploadStep = EnlargeUploadStepEnlargeSuccess;
                             [weakSelf.pollingFids removeObject:task.fid];
                            if (RI.autoDownImage) {
                                [I_Enlarge downloadPictureWithUrls:@[upload.output] isAutoDown:YES];
                            }
                        }

                    }
                }
            }
            
            [weakSelf.tableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }
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
    actionSheet.configuration.navBarColor=  RI.isNight ? RGB(31, 31, 31) : [UIColor whiteColor];
    actionSheet.configuration.navTitleColor =  RI.isNight ?[UIColor whiteColor]: RGB(31, 31, 31) ;
    actionSheet.configuration.bottomViewBgColor = RI.isNight ? RGB(31, 31, 31) : [UIColor whiteColor];
//    actionSheet.configuration.previewTextColor = [UIColor redColor];
    actionSheet.configuration.showSelectedMask = YES;
    actionSheet.configuration.bottomBtnsNormalTitleColor = [UIColor whiteColor];
    actionSheet.configuration.bottomBtnsDisableTitleColor =  [UIColor whiteColor];
    actionSheet.configuration.bottomBtnsNormalBgColor = LihgtGreenColor;
    actionSheet.configuration.bottomBtnsDisableBgColor = RGBA(30,161,20,0.5);
    actionSheet.configuration.indexLabelBgColor = LihgtGreenColor;
    actionSheet.configuration.maxPreviewCount = 0;
    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCancelText":LanguageStrings(@"cancel"),@"ZLPhotoBrowserSaveImageErrorText":LanguageStrings(@"error"),@"ZLPhotoBrowserNoCameraAuthorityText":LanguageStrings(@"error"),@"ZLPhotoBrowserNoAblumAuthorityText":LanguageStrings(@"error"),@""ZLPhotoBrowserSaveText:LanguageStrings(@"ok"),@"ZLPhotoBrowserPreviewText":@""};
    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
//    if ([ConfManager.shared.localLanguage isEqualToString:@"zh"]) {
//        actionSheet.configuration.languageType = ZLLanguageChineseSimplified;
//    } else if (actionSheet.configuration)
    actionSheet.sender = self;
            
    __weak typeof(self) weakSelf = self;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        for (PHAsset *ass in assets) {
            [[PHImageManager defaultManager] requestImageDataForAsset:ass options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                UIImage *image = [UIImage imageWithData:imageData];
                M_EnlargeUpload *upload =  [[M_EnlargeUpload alloc] init];
                upload.imageData = imageData;
                NSString *sizeStr = @"";
                if (imageData.length < 1024) {
                    sizeStr = [NSString stringWithFormat:@"%ldbytes",(long)imageData.length];
                } else if (imageData.length / 1024.0 < 1024) {
                    sizeStr = [NSString stringWithFormat:@"%.1fkb",imageData.length/1024.0];
                } else {
                    sizeStr = [NSString stringWithFormat:@"%.1fM",imageData.length/1024.0/1024.0];
                }
                CGFloat imageWidth = image.size.width;
                CGFloat imageHeight = image.size.height;
                upload.imageSizeStr = [NSString stringWithFormat:@"%@,%.0fx%.0fpx",sizeStr,imageWidth,imageHeight];
                if (imageData.length / 1024.0 / 1024.0 > 10 || image.size.width > 3000 || image.size.height > 3000) {
                    upload.uploadStep = EnlargeUploadStepOverSize;
                }
                M_EnlargeConf *conf = [[M_EnlargeConf alloc] init];
                conf.files_size = imageData.length;
                conf.file_width = imageWidth;
                conf.file_height = imageHeight;
                long nowTime = [[NSDate date] timeIntervalSince1970];;
                conf.file_name = [NSString stringWithFormat:@"upload/%@/%ld%@.png",[LqToolKit stringFromDate:[NSDate date] formatterString:@"yyyy-MM-dd"],nowTime,[NSUUID UUID]];
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


#pragma mark Noti
- (void)enlargeConfSuccess:(NSNotification *)noti
{
    NSDictionary *info = noti.object;
    BOOL enlargeAll = [[info safeObjectForKey:@"enlargeAll"]boolValue];
    M_EnlargeConf *conf = [info safeObjectForKey:@"conf"];
    
    NSMutableArray *list = [NSMutableArray array];
    if (enlargeAll) {
        for (M_EnlargeUpload *upload in self.dataSource) {
            if (upload.uploadStep == EnlargeUploadStepInitialize) {
                upload.conf.x2 = conf.x2;
                upload.conf.style = conf.style;
                upload.conf.noise = conf.noise;
                [list addObject:upload];
            }
        }
    } else {
        M_EnlargeUpload *upload = [info safeObjectForKey:@"upload"];
        upload.conf.x2 = conf.x2;
        upload.conf.style = conf.style;
        upload.conf.noise = conf.noise;
        [list addObject:upload];
    }
    __weak __typeof(self) weakSelf = self;
    for (M_EnlargeUpload *upload in list) {
        //OSS上传中
        upload.uploadStep = EnlargeUploadStepDataUploading;
        [weakSelf.tableView reloadData];
        [OSSManager asyncUploadData:upload.imageData objectKey:upload.conf.file_name progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
            
        } success:^(OSSTask * _Nonnull task) {
            if (task.error) {
                //OSS上传失败
                upload.uploadStep = EnlargeUploadStepDataUploadFail;
                [weakSelf.tableView reloadData];
            } else {
                NSString *input = [NSString stringWithFormat:@"%@/%@",[OSSManager  getOSSUrl],upload.conf.file_name];
                
                upload.conf.input = input;
                //放大数据上传中
                upload.uploadStep = EnlargeUploadStepDataUploading;
                [weakSelf.tableView reloadData];
                [I_Enlarge createEnlargeTaskWith:upload.conf success:^(NSString * _Nonnull fid, NSInteger time) {
                    //放大数据上传成功
                    upload.uploadStep = EnlargeUploadStepEnlargeingNew;
                    upload.fid = fid;
                    upload.conf.time = time;
                    upload.createTime = [NSDate date];
                    [weakSelf.pollingFids addObject:upload.fid];
                    [weakSelf.tableView reloadData];
                } failure:^(NSError *error) {
                    //放大数据上传失败
                    upload.uploadStep = EnlargeUploadStepDataUploadFail;
                    [weakSelf.tableView reloadData];
                    [LSVProgressHUD showError:error];
                }];
                
            }
        } failure:^(NSError * _Nonnull error) {
            //OSS上传失败
            upload.uploadStep = EnlargeUploadStepDataUploadFail;
            [weakSelf.tableView reloadData];
            [LSVProgressHUD showErrorWithStatus:LanguageStrings(@"upload_error")];
        }];
    }
    
}
- (void)changeNight{
    [self.tableView reloadData];
    self.tableView.backgroundColor = BackGroundColor;
    self.headerBackView.backgroundColor = RI.isNight ? RGB(31, 31, 31) : RGB(238, 238, 238);
    self.describerLabel.textColor = RI.isNight ? TitleGrayColor : [UIColor lq_colorWithHexString:@"9A9A9A"];
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
    return 110;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LanguageStrings(@"del");
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof(self) weakSelf = self;
    [SystemAlertViewController alertViewControllerWithTitle:nil message:LanguageStrings(@"sure") cancleButtonTitle:LanguageStrings(@"cancel") commitButtonTitle:LanguageStrings(@"ok") cancleBlock:^{
          
      } commitBlock:^{
          [weakSelf.dataSource removeObject:weakSelf.dataSource[indexPath.row]];
          [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
@end
