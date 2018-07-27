//
//  CategoryController.h
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define SCALE_6                                                   (SCREEN_WIDTH / 375)

@interface CategoryController : UIViewController

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) UITableView *table;
-(void)reloadDatas;

//And:(void(^)(CGFloat offSet))ZLBlock

@end
