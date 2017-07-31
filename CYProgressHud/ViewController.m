//
//  ViewController.m
//  CYProgressHud
//
//  Created by Fangcy on 2017/4/11.
//  Copyright © 2017年 AsiaInfo. All rights reserved.
//

#import "ViewController.h"
#import "CYProgressHUD.h"
#import "CYTextOnlyHUDView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titlesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}


-(UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

-(NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"提示文字, 不会自动隐藏", @"提示文字, 会自动隐藏", @"提示成功 显示默认的图片, 不会自动隐藏", @"提示成功 显示默认的图片, 会自动隐藏", @"提示成功 显示默认的图片和设定的文字提示, 不会自动隐藏", @"提示成功 显示默认的图片和设定的文字提示, 会自动隐藏", @"提示正在加载 显示默认的图片 不会自动隐藏", @"提示正在加载 显示默认的图片和文字提示 不会自动隐藏", @"弹出自定义的提示框 不会自动隐藏", @"弹出自定义的提示框 会自动隐藏"];
    }
    return _titlesArray;
}


#pragma mark -- 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [CYProgressHUD showMessage:@"拼命加载中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [CYProgressHUD hideHUD];
            });
            break;
        case 1:
            [CYProgressHUD showMessage:@"拼命加载中..." andAutoHideAfterTime:2.f];
            break;
        case 2:
            [CYProgressHUD showSuccess];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载完后 移除提示框
                [CYProgressHUD hideHUD];
            });
            break;
        case 3:
            [CYProgressHUD showSuccessAndAutoHideAfterTime:1.0f];
            break;
        case 4:
            [CYProgressHUD showSuccessWithMessage:@"加载成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载完后 移除提示框
                [CYProgressHUD hideHUD];
            });
            break;
        case 5:
            [CYProgressHUD showSuccessWithMessage:@"加载成功" andAutoHideAfterTime:1.0f];
            break;
        case 6:
            [CYProgressHUD showProgress];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载完后 移除提示框
                [CYProgressHUD hideHUD];
            });
            break;
        case 7:
            // 显示加载动画, 需要加载完成后调用hideHUD隐藏
            [CYProgressHUD showProgressWithMessage:@"加载中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载完后 移除提示框
                [CYProgressHUD hideHUD];
            });
            break;
        case 8:
//            CYTextOnlyHUDView *custom = [[CYTextOnlyHUDView alloc] init];
        {
            // 内部的HUDView是遵守ZJPrivateHUDProtocol的, 在显示的时候会被调整为居中显示
            CYTextOnlyHUDView *custom = [[CYTextOnlyHUDView alloc]init];
            
            custom.text = @"自定义";
            custom.textColor = [UIColor redColor];
            
            [CYProgressHUD showCustomHUD:custom andAutoHideAfterTime:1.0f];
        }
            break;
        case 9:
        {
            // 不遵守ZJPrivateHUDProtocol的, 在显示的时候会使用这里设置的frame
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
            label.text = @"自定义2";
            label.textColor = [UIColor redColor];
            label.backgroundColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius = 10;
            label.layer.masksToBounds = YES;
            [CYProgressHUD showCustomHUD:label andAutoHideAfterTime:1.0f];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
