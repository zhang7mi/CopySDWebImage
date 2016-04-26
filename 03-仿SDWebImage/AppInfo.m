//
//  AppInfo.m
//  07-列表异步加载网络图片
//
//  Created by HM on 16/4/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    // 创建模型对象
    AppInfo *app = [[AppInfo alloc] init];
    // KVC实现字典转模型
    [app setValuesForKeysWithDictionary:dict];
    // 返回模型对象
    return app;
}

+ (NSArray *)appInfos
{
    // 获取plist文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    // 通过路径加载字典数组
    NSArray *rootArr = [NSArray arrayWithContentsOfFile:path];
    // 定义临时的可变数组保存模型
    NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:rootArr.count];
    // 遍历字典数组,实现字典转模型
    [rootArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 取出字典,实现字典转模型
        AppInfo *app = [AppInfo appInfoWithDict:obj];
        // 将模型添加到可变的临时数组
        [tmpM addObject:app];
    }];
    
    // 把可变的数组拷贝成不可变的,线程安全.不希望外界修改我的模型数组
    return tmpM.copy;
}

@end
