//
//  CYProgressHUD.m
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "CYProgressHUD.h"
#import "CYPrivateHUDProtocol.h"
#import "CYTextOnlyHUDView.h"
#import "CYImageOnlyHUDView.h"
#import "CYProgressHUDView.h"
#import "CYTextAndImageHUDView.h"

@implementation CYProgressHUD

+(instancetype)sharedInstance {
    static CYProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[CYProgressHUD alloc]init];
    });
    return hud;
}

-(instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)showWithTime:(CGFloat)time {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (self.superview == nil) {
        [window addSubview:self];
    }
    if (time > 0) {
        __weak typeof(self) weakSelf = self;
        dely(time, ^{
            __strong typeof(weakSelf) strongSelf = weakSelf; // 不理解😒
            if (strongSelf) {
                [strongSelf hide];
            }
        });
    }
}

-(void)hide {
    // 首先移除先添加的
    UIView *firstHud = [self.subviews firstObject];
    if (firstHud) {
        [firstHud removeFromSuperview];
        if (self.subviews.count == 0) {
            [self removeFromSuperview];
        }
    }else {
        [self removeFromSuperview];
    }
}

-(void)hideAllHUDs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {  // self.superview = window
        self.frame = self.superview.bounds;
        for (UIView *view in self.subviews) {
            if ([view conformsToProtocol:@protocol(CYPrivateHUDProtocol)]) {
                // 居中显示
                view.center = self.center;
            }else {
                // 自定义hudView
                CGRect frame = view.frame;
                view.frame = frame;
            }
        }
    }
}

//  这里直接使用了GCD, 当然推荐使用NSTimer
static void dely(CGFloat time,dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}

-(void)setHudView:(UIView *)hudView {
    [self addSubview:hudView];
}

@end


@implementation CYProgressHUD (public)

+(void)showMessage:(NSString *)message {
    [CYProgressHUD showMessage:message andAutoHideAfterTime:0.0f];
}
+(void)showMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime {
    CYProgressHUD *hudView = [CYProgressHUD sharedInstance];
    CYTextOnlyHUDView *textHud = [[CYTextOnlyHUDView alloc]init];
    
    textHud.text = message;
    [hudView addSubview:textHud];
    [hudView showWithTime:showTime];
}

+(void)showSuccess {
    [CYProgressHUD showSuccessAndAutoHideAfterTime:0.0f];
}
+(void)showSuccessAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [CYProgressHUD showImage:image andAutoHideAfterTime:showTime];
    
}

+(void)showSuccessWithMessage:(NSString *)message {
    [CYProgressHUD showSuccessWithMessage:message andAutoHideAfterTime:0.0f];
}
+(void)showSuccessWithMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"success"];
    [CYProgressHUD showImage:image withMessage:message andAutoHideAfterTime:showTime];
}

+(void)showFailure {
    [CYProgressHUD showFailureAndAutoHideAfterTime:0.0f];
}
+(void)showFailureAndAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [CYProgressHUD showImage:image andAutoHideAfterTime:showTime];
}

+(void)showFailureWithMessage:(NSString *)message {
    [CYProgressHUD showFailureWithMessage:message andAutoHideAfterTime:0.0f];
}
+(void)showFailureWithMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime {
    UIImage *image = [UIImage imageNamed:@"error"];
    [CYProgressHUD showImage:image withMessage:message andAutoHideAfterTime:showTime];
}

+(void)showProgress {
    [CYProgressHUD showProgressWithMessage:nil];
}
+(void)showProgressWithMessage:(NSString *)message {
    CYProgressHUD *hudView = [CYProgressHUD sharedInstance];
    CYProgressHUDView *progressView = [[CYProgressHUDView alloc]init];
    [progressView setText:message];
    [hudView setHudView:progressView];
    [hudView showWithTime:0.0f];
    [progressView startAnimation];
}

+(void)showCustomHUD:(UIView *)hudView {
    [CYProgressHUD showCustomHUD:hudView andAutoHideAfterTime:0.0f];
}
+(void)showCustomHUD:(UIView *)hudView andAutoHideAfterTime:(CGFloat)showTime {
    [[CYProgressHUD sharedInstance] setHudView:hudView];
    [[CYProgressHUD sharedInstance] showWithTime:showTime];
}



+ (void)showImage:(UIImage *)image andAutoHideAfterTime:(CGFloat)showTime {
    CYProgressHUD *hudView = [CYProgressHUD sharedInstance];
    CYImageOnlyHUDView *imageView = [[CYImageOnlyHUDView alloc]init];
    imageView.image = image;
    [hudView setHudView:imageView];
    [hudView showWithTime:showTime];
}
+ (void)showImage:(UIImage *)image withMessage:(NSString *)message andAutoHideAfterTime:(CGFloat)showTime {
    CYProgressHUD *hudView = [CYProgressHUD sharedInstance];
    CYTextAndImageHUDView *textAndImageView = [[CYTextAndImageHUDView alloc]init];
    [textAndImageView setText:message andImage:image];
    
    [hudView setHudView:textAndImageView];
    [hudView showWithTime:showTime];
    
}


+(void)hideHUD {
    [[CYProgressHUD sharedInstance] hide];
}

+(void)hideAllHUDs {
    [[CYProgressHUD sharedInstance] hideAllHUDs];
}


@end














