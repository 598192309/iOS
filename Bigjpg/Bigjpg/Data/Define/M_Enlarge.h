//
//  M_Enlarge.h
//  Bigjpg
//
//  Created by lqq on 2019/12/26.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "M_Base.h"

NS_ASSUME_NONNULL_BEGIN
/// 放大任务参数模型
@interface M_EnlargeConf : M_Base
//放大倍数 1 两倍, 2 四倍, 3 八倍, 4 十六倍
@property (nonatomic, assign) int x2;
//art 卡通图片, photo 照片
@property (nonatomic, copy) NSString *style;
//噪点 -1 无, 0 低, 1 中, 2 高, 3 最高
@property (nonatomic, assign) int noise;
//图片名
@property (nonatomic, copy) NSString *file_name;
//图片字节大小
@property (nonatomic, assign) long files_size;
//图片高度
@property (nonatomic, assign) NSInteger file_height;
//图片宽度
@property (nonatomic, assign) NSInteger file_width;
//图片oss地址
@property (nonatomic, copy) NSString *input;
//消耗时间 （放大完成后历史l记录会有)
@property (nonatomic, assign) NSInteger time;
@end


/// 放大任务模型
@interface M_Enlarge : M_Base
//fid
@property (nonatomic, copy) NSString *fid;
//状态 new process success error
@property (nonatomic, copy) NSString *status;
/// output放大后地址 status为success时有值
@property (nonatomic, copy) NSString *output;
@end


/// 放大任务历史模型
@interface M_EnlargeHistory : M_Enlarge
//放大参数
@property (nonatomic, strong) M_EnlargeConf *conf;
//创建时间
@property (nonatomic, copy) NSString *createTime;
@end

@interface M_EnlargeUpload : M_EnlargeHistory
//上传图片数据
@property (nonatomic, strong) NSData *imageData;
//size是否超出限制
@property (nonatomic, assign) BOOL isOverSize;
//图片尺寸
@property (nonatomic, strong) NSString *imageSizeStr;
@end

NS_ASSUME_NONNULL_END
