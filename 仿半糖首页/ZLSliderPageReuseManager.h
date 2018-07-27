//
//  ZLSliderPageReuseManager.h
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Reuse.h"


@interface ZLSliderPageReuseManager : NSObject

//缓存最大容量
@property (nonatomic, assign) NSInteger capacity;

-(__kindof UIViewController *)dequeueReuseableViewControllerWithIdentifier:(NSString *)identifier forKey:(NSString *)key;

-(void)registerClass:(Class)someClass forReuseIdentifier:(NSString *)identifier;


+(void)observeController:(void(^)(NSKeyValueObservingOptions options,NSString *keyPathStr))zlSliderPageReuseManageBlock;


-(instancetype)initWith:(NSInteger)capacity;
@end
