//
//  UIViewController+Reuse.h
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Reuse)


//指定ViewController的复用Key，根据Key可以获取复用池子里是否已经有此ViewController，如果有则直接取出来使用
@property (nonatomic, copy) NSString *reuseKey;


//指定ViewController是否是被复用的，被复用的ViewController可能需要进行其他处理，比如重新加载新数据等
@property (nonatomic, assign)BOOL isReuse;

/**
 *  提供复用时实例化方法
 *  可以是基本的[[self alloc] init]，也可以通过storyboard实例化
 */
+ (instancetype)reuseInstance;

- (void)prepareForReuse;
@end
