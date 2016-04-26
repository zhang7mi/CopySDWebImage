//
//  ZXZCustomOperation.h
//  03-仿SDWebImage
//
//  Created by Mac on 16/4/22.
//  Copyright © 2016年 www.ZXZ.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXZCustomOperation : NSOperation

+ (instancetype)customOperationWithName:(NSString *)name andBlock: (void (^)(UIImage *myImage))myBlock;

@end
