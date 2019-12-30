//
//  EnlargeConfViewController.m
//  Bigjpg
//
//  Created by lqq on 2019/12/30.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "EnlargeConfViewController.h"

@interface EnlargeConfViewController ()
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeSegment;

@property (strong, nonatomic) IBOutlet UILabel *enlargeFactorLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *ennargeFactorSegment;

@property (strong, nonatomic) IBOutlet UILabel *denoiseLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *denoiseSegment;

@property (strong, nonatomic) IBOutlet UIButton *comfirBtn;
@property (strong, nonatomic) IBOutlet UIButton *confimAllBtn;


@property (nonatomic, strong) M_EnlargeUpload *enlargeUpload;
@end

@implementation EnlargeConfViewController

+ (instancetype)controllerWithEnlargeUpload:(M_EnlargeUpload *)enlargeUpload
{
    EnlargeConfViewController *vc = [UIStoryboard lq_controllerWithStoryBoardIdentify:@"EnlargeConfViewController" inStoryBoard:@"Home"];
    vc.enlargeUpload = enlargeUpload;
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationView];
    self.navigationTextLabel.text = LanguageStrings(@"configure");
    
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *selectColor = [UIColor whiteColor];
    UIColor *normalColor = [UIColor blackColor];
    [_typeSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:font} forState:UIControlStateSelected];
    [_typeSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:font} forState:UIControlStateNormal];
    [_ennargeFactorSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:font} forState:UIControlStateSelected];
    [_ennargeFactorSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:font} forState:UIControlStateNormal];
    [_denoiseSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:font} forState:UIControlStateSelected];
    [_denoiseSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:font} forState:UIControlStateNormal];
    
    _typeLabel.text = LanguageStrings(@"pic_type");
    [_typeSegment setTitle:LanguageStrings(@"carton") forSegmentAtIndex:0];
    [_typeSegment setTitle:LanguageStrings(@"photo") forSegmentAtIndex:1];

    
    
    _enlargeFactorLabel.text = LanguageStrings(@"upscaling");
    
    _denoiseLabel.text = LanguageStrings(@"noise");
    [_denoiseSegment setTitle:LanguageStrings(@"none") forSegmentAtIndex:0];
    [_denoiseSegment setTitle:LanguageStrings(@"low") forSegmentAtIndex:1];
    [_denoiseSegment setTitle:LanguageStrings(@"mid") forSegmentAtIndex:2];
    [_denoiseSegment setTitle:LanguageStrings(@"high") forSegmentAtIndex:3];
    [_denoiseSegment setTitle:LanguageStrings(@"highest") forSegmentAtIndex:4];
    
    [_comfirBtn setTitle:LanguageStrings(@"ok") forState:UIControlStateNormal];
    [_confimAllBtn setTitle:LanguageStrings(@"batch_btn") forState:UIControlStateNormal];
    
    _comfirBtn.layer.cornerRadius = 4;
    _comfirBtn.layer.masksToBounds = YES;
    _confimAllBtn.layer.cornerRadius = 4;
    _confimAllBtn.layer.masksToBounds = YES;
    
}

//确定//批量放大
- (IBAction)confimEvent:(UIButton *)sender {
    M_EnlargeConf *conf = [[M_EnlargeConf alloc] init];
    if (_typeSegment.selectedSegmentIndex == 0) {
        conf.style = @"art";
    } else {
        conf.style = @"photo";
    }
    conf.x2 = _ennargeFactorSegment.selectedSegmentIndex + 1;
    conf.noise = _denoiseSegment.selectedSegmentIndex - 1;
    
    NSDictionary *dic = @{@"conf":conf,
                          @"enlargeAll":@(sender.tag),
                          @"upload":_enlargeUpload
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kEnlargeConfigarationFinishNoti object:dic];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
