//
//  CYProgressHUDView.h
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYProgressHUDView : UIView

/** 设置颜色 */
@property (nonatomic,strong)UIColor *indicatorColor;
/** 开始动画 */
-(void)startAnimation;
/** 设置文字提示 */
-(void)setText:(NSString *)text;


@end
