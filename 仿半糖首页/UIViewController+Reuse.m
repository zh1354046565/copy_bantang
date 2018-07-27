//
//  UIViewController+Reuse.m
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "UIViewController+Reuse.h"
#import <objc/runtime.h>

static char reuseKeyKey;
static char isReuseKey;

@implementation UIViewController (Reuse)

-(void)setReuseKey:(NSString *)reuseKey{
    objc_setAssociatedObject(self, &reuseKeyKey, reuseKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)reuseKey{
    return objc_getAssociatedObject(self, &reuseKeyKey);
}


-(void)setIsReuse:(BOOL)isReuse{
    objc_setAssociatedObject(self, &isReuseKey, @(isReuse), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isReuse{
    NSNumber *v = objc_getAssociatedObject(self, &isReuseKey);
    
    return [v boolValue];
}

+(instancetype)reuseInstance{
    return [[self alloc]init];
}

-(void)prepareForReuse{
    NSLog(@"VC将要被复用");
}

@end
