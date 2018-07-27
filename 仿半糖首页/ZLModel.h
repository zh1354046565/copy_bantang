//
//  ZLModel.h
//  仿半糖首页
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLModel : NSObject

@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *likes;


@end
