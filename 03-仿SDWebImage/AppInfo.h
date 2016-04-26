//
//  AppInfo.h
//  07-列表异步加载网络图片
//
//  Created by HM on 16/4/17.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

/// APP名称
@property (nonatomic, copy) NSString *name;
/// APP图标
@property (nonatomic, copy) NSString *icon;
/// APP下载量
@property (nonatomic, copy) NSString *download;

/// 实现字典转模型
+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

/// 模型类自己加载模型数组,返回给VC
+ (NSArray *)appInfos;

@end
