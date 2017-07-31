//
//  CYProgressHUD.h
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYProgressHUD : UIView

// 单例方法
+(instancetype)sharedInstance;
// 初始化方法
-(instancetype)init;
// 设置/添加hudView的方法
-(void)setHudView:(UIView *)hudView;
// 被window弹出的方法, 同时设置显示的时间, 当设置的时间小于等于0的时候将不会自动移除
-(void)showWithTime:(CGFloat)time;
// 移除hud的方法
- (void)hide;
// 移除所有hud的方法
- (void)hideAllHUDs;


@end


@interface CYProgressHUD (public)
/** 提示文字, 不会自动隐藏*/
+(void)showMessage:(NSString *)message;
/** 提示文字, 会自动隐藏*/
+(void)showMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime;

/** 提示成功 显示默认的图片, 不会自动隐藏*/
+(void)showSuccess;
/** 提示成功 显示默认的图片, 会自动隐藏*/
+(void)showSuccessAndAutoHideAfterTime:(CGFloat)showTime;

/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+(void)showSuccessWithMessage:(NSString *)message;
/** 提示成功 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+(void)showSuccessWithMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime;

/** 提示失败 显示默认的图片, 不会自动隐藏*/
+(void)showFailure;
/** 提示失败 显示默认的图片, 会自动隐藏*/
+(void)showFailureAndAutoHideAfterTime:(CGFloat)showTime;

/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 不会自动隐藏*/
+(void)showFailureWithMessage:(NSString *)message;
/** 提示失败 显示默认的图片, 同时显示设定的文字提示, 会自动隐藏*/
+(void)showFailureWithMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime;

/** 提示正在加载 显示默认的图片 不会自动隐藏*/
+(void)showProgress;
/** 提示正在加载 显示默认的图片, 同时显示设定的文字提示 不会自动隐藏*/
+ (void)showProgressWithMessage:(NSString *)message;

/** 弹出自定义的提示框 不会自动隐藏*/
+(void)showCustomHUD:(UIView *)hudView;
/** 弹出自定义的提示框 会自动隐藏*/
+(void)showCustomHUD:(UIView *)hudView andAutoHideAfterTime:(CGFloat)showTime;

/** 移除提示框*/
+ (void)hideHUD;
/** 移除所有提示框*/
+ (void)hideAllHUDs;
@end





