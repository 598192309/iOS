//
//  HomeTableViewCell.m
//  Bigjpg
//
//  Created by lqq on 2019/12/27.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "EnlargeConfViewController.h"
@interface HomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *confImageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *imageDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIView *statusBackView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _confImageView.layer.cornerRadius = 4;
    _confImageView.layer.masksToBounds = YES;
    _statusBackView.layer.cornerRadius = 4;
    _statusBackView.layer.cornerRadius = 4;
    _firstBtn.layer.cornerRadius = 4;
    _firstBtn.layer.masksToBounds  = YES;
    _secondBtn.layer.cornerRadius = 4;
    _secondBtn.layer.masksToBounds = YES;
}
- (IBAction)firstBtnEvent:(id)sender {
    switch (self.upload.uploadStep) {
           case EnlargeUploadStepInitialize:
           {
               EnlargeConfViewController *confVC = [EnlargeConfViewController controllerWithEnlargeUpload:self.upload];
               [[self lq_getCurrentViewController].navigationController pushViewController:confVC animated:YES];
           }
               break;
           case EnlargeUploadStepOverSize:
           {
               
           }
               break;
        case EnlargeUploadStepDataUploading:
           {
               
           }
               break;
        case EnlargeUploadStepDataUploadFail:
           {
               
           }
               break;
           case EnlargeUploadStepEnlargeingNew:
           {
               
           }
               break;
           case EnlargeUploadStepEnlargeingProcess:
           {
               
           }
               break;
           case EnlargeUploadStepEnlargeSuccess:
           {
               
           }
               break;
           case EnlargeUploadStepEnlargeError:
           {
               
           }
               break;
               
           default:
               break;
       }
    
}
- (IBAction)secondBtnEvent:(id)sender {
}

- (void)setUpload:(M_EnlargeUpload *)upload
{
    _upload = upload;
    _confImageView.image = [UIImage imageWithData:upload.imageData];
    self.imageDetailLabel.text = upload.imageSizeStr;
    switch (upload.uploadStep) {
        case EnlargeUploadStepInitialize:
        {
            self.statusBackView.hidden = YES;
            self.progressView.progress = 0;
            [_firstBtn setTitle:LanguageStrings(@"begin") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.greenColor];
            
            _secondBtn.hidden = NO;
            [_secondBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_secondBtn setBackgroundColor:TP.redColor];
        }
            break;
        case EnlargeUploadStepOverSize:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"over");
            self.progressView.progress = 0;
            
            [_firstBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.redColor];
            
            _secondBtn.hidden = YES;
        }
            break;
        case EnlargeUploadStepDataUploading:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"process");
            self.progressView.progress = 0.1;
            [_firstBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.redColor];
            
            _secondBtn.hidden = YES;
        }
            break;
        case EnlargeUploadStepDataUploadFail:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"fail");
            self.progressView.progress = 0;
            [_firstBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.yellowColor];
            
            _secondBtn.hidden = NO;
            [_secondBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_secondBtn setBackgroundColor:TP.redColor];
        }
            break;
        case EnlargeUploadStepEnlargeingNew:
        case EnlargeUploadStepEnlargeingProcess:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"process");
            self.progressView.progress = 0.1;
            [_firstBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.redColor];
            _secondBtn.hidden = YES;
            
            NSTimeInterval nowInte = [[NSDate date] timeIntervalSince1970];
             NSTimeInterval createInte = [upload.createTime timeIntervalSince1970];
             NSInteger seconds = upload.conf.time * 60;
            
            CGFloat progress = (nowInte - createInte) / seconds;
            
            if (progress < 0.1) {
                progress = 0.1;
            }else if (progress > 0.9) {
                progress = 0.9;
            }
            _progressView.progress = progress;
            
        }
            break;
        case EnlargeUploadStepEnlargeSuccess:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"succ");
            self.progressView.progress = 1;
            [_firstBtn setTitle:LanguageStrings(@"download") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.greenColor];
            
            _secondBtn.hidden = NO;
            [_secondBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_secondBtn setBackgroundColor:TP.redColor];
        }
            break;
        case EnlargeUploadStepEnlargeError:
        {
            self.statusBackView.hidden = NO;
            self.statusLabel.text = LanguageStrings(@"fail");
            self.progressView.progress = 0;
            [_firstBtn setTitle:LanguageStrings(@"retry") forState:UIControlStateNormal];
            [_firstBtn setBackgroundColor:TP.yellowColor];
            
            _secondBtn.hidden = NO;
            [_secondBtn setTitle:LanguageStrings(@"del") forState:UIControlStateNormal];
            [_secondBtn setBackgroundColor:TP.redColor];
        }
            break;
            
        default:
            break;
    }
}
@end
