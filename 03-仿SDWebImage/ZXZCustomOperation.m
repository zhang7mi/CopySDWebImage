
//
//  ZXZCustomOperation.m
//  03-仿SDWebImage
//
//  Created by Mac on 16/4/22.
//  Copyright © 2016年 www.ZXZ.com. All rights reserved.
//

#import "ZXZCustomOperation.h"

@interface ZXZCustomOperation ()

@property (copy, nonatomic)NSString * name;
@property (copy, nonatomic)void (^myBlock)(UIImage *image);

@end
@implementation ZXZCustomOperation

+ (instancetype)customOperationWithName:(NSString *)name andBlock: (void (^)(UIImage *myImage))myBlock{

    // 1. 创建一个自定义Operation
    ZXZCustomOperation *op = [[ZXZCustomOperation alloc] init];

    // 2. 赋值到成员属性
    op.name = name;
    op.myBlock = myBlock;

    // 3. 返回数据
    return op;
}

#pragma mark - 因为main方法可以拦截数据
- (void)main{

    [NSThread sleepForTimeInterval:2];
    if (self.cancelled == YES) {
        [self cancel];
        NSLog(@"取消------");
        return ;
    }
    // 1. 下载数据
    NSURL *myUrl = [NSURL URLWithString:self.name];
    NSData *myData = [NSData dataWithContentsOfURL:myUrl];
    UIImage *myImage = [UIImage imageWithData:myData];

    // 2. 切换到主线程去实现刷新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.myBlock(myImage);
        NSLog(@"完成=======");
    }];
}
@end
