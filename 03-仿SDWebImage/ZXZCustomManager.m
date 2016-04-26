//
//  ZXZCustomManager.m
//  03-仿SDWebImage
//
//  Created by Mac on 16/4/22.
//  Copyright © 2016年 www.ZXZ.com. All rights reserved.
//

#import "ZXZCustomManager.h"

#import "ZXZCustomOperation.h"

@interface ZXZCustomManager ()

// 创建一个队列用于保存operation的行为
@property (strong, nonatomic)NSOperationQueue *queue;
@property (copy, nonatomic)NSString * lastName;

// 设置字典用于保存我们上一次的任务
@property (strong, nonatomic)NSMutableDictionary *lastOperationArr;

// 保存数据
@property (strong, nonatomic)NSMutableDictionary *downloadArr;

@property (strong, nonatomic)UIImage  *myImage;
@end

@implementation ZXZCustomManager

// 创建一个单例的cell方法
+ (instancetype)shareCustomManager{
    static ZXZCustomManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZXZCustomManager alloc] init];
    });
    return manager;
}

// 常见一个op
- (void)managerCustomOperationByName: (NSString *)name WithBlock:(void (^)(UIImage *myImage))myBlock{


    // 1. 判断是否是与上次的是相同的  如果相同我们就停止  如果不同的话 结束上一次的操作. 开启这次操作
    if ([name isEqualToString:self.lastName]) {
        // 如果相同直接返回  不在执行
        return;

    }else{
        // 如果不相同 我们就继续进行 但是要干掉上次的操作
        ZXZCustomOperation *lastOp = [self.lastOperationArr objectForKey:self.lastName];
        [lastOp cancel];
        NSLog(@"传入------");
    }

//    // 2. 判断我们总的缓存是否存在这个操作
//    if ( [self.downloadArr objectForKey:name] != nil) {
//        myBlock([self.downloadArr objectForKey:name]);
//        return ;
//    }

    void (^block) (UIImage *) = ^(UIImage *myImage){
        self.myImage = myImage;
        [self.downloadArr setObject:myImage forKey:name];
    };

    myBlock = block;

    // 3. 传入到NSOperation
    ZXZCustomOperation *op = [ZXZCustomOperation customOperationWithName:name andBlock:block];

 

    self.lastName = name;
    [self.lastOperationArr setObject:op forKey:name];

    [self.queue  addOperation:op];
}


#pragma mark - 下载数据
- (NSMutableDictionary *)downloadArr{
    if (_downloadArr == nil) {
        _downloadArr = [[NSMutableDictionary alloc ]init];
    }
    return  _downloadArr;
}


#pragma mark - 懒加载队列
-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue  alloc] init];
    }
    return _queue;
}

#pragma mark - 懒加载 上一次的操作字典
- (NSMutableDictionary *)lastOperationArr{
    if (_lastOperationArr == nil) {
        _lastOperationArr = [[NSMutableDictionary alloc] init];
    }
    return _lastOperationArr;
}
@end
