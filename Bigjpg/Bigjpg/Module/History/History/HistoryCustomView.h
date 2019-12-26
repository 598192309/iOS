//
//  HistoryCustomView.h
//  Bigjpg
//
//  Created by rabi on 2019/12/25.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCustomView : UIView
/**点击升级*/
@property(nonatomic,copy)void(^historyCustomViewConfirmBtnClickBlock)(NSDictionary *dict,UIButton *sender);

@end

NS_ASSUME_NONNULL_END
