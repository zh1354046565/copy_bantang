//
//  ZLSliderPageReuseManager.m
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "ZLSliderPageReuseManager.h"

@interface ZLSliderPageReuseManager ()

@property (nonatomic, strong) NSMutableDictionary *reuseClasses;

@property (nonatomic, strong) NSMutableDictionary *reusePool;

@end

@implementation ZLSliderPageReuseManager


-(instancetype)initWith:(NSInteger)capacity{
    self = [super init];
    if (self) {
        _capacity = capacity;
        _reusePool = [NSMutableDictionary dictionary];
        _reuseClasses = [NSMutableDictionary dictionary];
        
    }
    return self;
}


-(void)registerClass:(Class)someClass forReuseIdentifier:(NSString *)identifier{
    [_reuseClasses setObject:someClass forKey:identifier];
    [_reusePool setObject:[NSMutableArray arrayWithCapacity:_capacity] forKey:identifier];
}

-(UIViewController *)dequeueReuseableViewControllerWithIdentifier:(NSString *)identifier forKey:(NSString *)key{
    Class cla = [_reuseClasses objectForKey:identifier];
    NSAssert1(cla, @"没有找到注册类标识: %@", identifier);
    
    NSMutableArray *pool = [_reusePool objectForKey:identifier];
    
    __block UIViewController *controller;
    [pool enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vc.reuseKey isEqualToString:key]) {
            controller = vc;
            *stop = YES;
        }
        
    }];
    
    //复用队列里没有找到
    if (!controller) {
        
        //复用队列超过最大容量,取第一个进行复用
        if (pool.count>self.capacity) {
            NSLog(@"复用VC");
            controller = [pool firstObject];
            [controller prepareForReuse];
            
            controller.reuseKey = key;
            controller.isReuse = YES;
            [pool removeObjectAtIndex:0];
        }
        //没有超过最大容量,实例化一个新的
        else{
            
            controller = [cla reuseInstance];
            controller.reuseKey = key;
            controller.isReuse = NO;
        }
        
        [pool addObject:controller];
        
    }else{
        [pool removeObject:controller];
        [pool addObject:controller];
        controller.isReuse = NO;
    }
    
    return controller;
}


+(void)observeController:(void(^)(NSKeyValueObservingOptions options,NSString *keyPathStr))zlSliderPageReuseManageBlock{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    //[controller.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    zlSliderPageReuseManageBlock(options,@"contentOffset");
}












@end
