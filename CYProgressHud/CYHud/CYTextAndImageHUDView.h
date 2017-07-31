//
//  CYTextAndImageHUDView.h
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTextAndImageHUDView : UIView
/** 设置文字颜色 */
@property (nonatomic,strong)UIColor *textColor;
/** 设置提示文字和图片*/
-(void)setText:(NSString *)text andImage:(UIImage *)image;

@end
