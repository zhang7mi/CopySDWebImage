//
//  ViewController.m
//  03-仿SDWebImage
//
//  Created by Mac on 16/4/22.
//  Copyright © 2016年 www.ZXZ.com. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "ZXZCustomManager.h"

@interface ViewController ()
@property (strong, nonatomic)NSArray *dataSourceArr;
@property (strong, nonatomic)UIImageView *iconView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    // 1. 创建一个IconImageView
    UIImageView *iconView = [[UIImageView alloc] init];

    // 2. 设置颜色
    iconView.backgroundColor = [UIColor redColor];

    // 3. 添加到view上
    [self.view addSubview:iconView];

    // 4. 设置位置
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).dividedBy(1);
        make.centerY.equalTo(self.view).dividedBy(1);
        make.size.equalTo(CGSizeMake(200, 200));
    }];
    _iconView = iconView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{



    // 1. 设置一个随机数
    NSInteger num = arc4random_uniform((u_int32_t)self.dataSourceArr.count);
    // 2. 取出str
    AppInfo *app = self.dataSourceArr[num];
    NSString *str = app.icon;

     [[ZXZCustomManager shareCustomManager] managerCustomOperationByName:str WithBlock:^(UIImage *myImage) {
         self.iconView.image = myImage;
    }];

     







}



#pragma mark - 数组的懒加载方法
- (NSArray *)dataSourceArr{
    if (_dataSourceArr == nil) {
        _dataSourceArr = [AppInfo appInfos];
    }
    return _dataSourceArr;
}



@end
