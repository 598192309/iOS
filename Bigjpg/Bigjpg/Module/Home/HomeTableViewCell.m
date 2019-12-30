//
//  HomeTableViewCell.m
//  Bigjpg
//
//  Created by lqq on 2019/12/27.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "HomeTableViewCell.h"

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
}
- (IBAction)secondBtnEvent:(id)sender {
}

- (void)setUpload:(M_EnlargeUpload *)upload
{
    _upload = upload;
    _confImageView.image = [UIImage imageWithData:upload.imageData];
    self.imageDetailLabel.text = upload.imageSizeStr;
    if (upload.isOverSize) {
        self.statusBackView.hidden = NO;
        self.statusLabel.text = LanguageStrings(@"over");
        self.progressView.progress = 0;
    } else {
        
    }
}
@end
