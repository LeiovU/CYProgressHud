//
//  CYTextOnlyHUDView.h
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTextOnlyHUDView : UIView
/** 设置提示文字*/
@property (nonatomic,strong)NSString *text;
/** 设置文字颜色 */
@property (nonatomic,strong)UIColor *textColor;

@end
