//
//  PhotoCell.m
//  runtime练习
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
