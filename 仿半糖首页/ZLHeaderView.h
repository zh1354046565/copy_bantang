//
//  ZLHeaderView.h
//  仿半糖首页
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZLHeaderViewDelegate <NSObject>

-(void)goToSearch;

@end

@interface ZLHeaderView : UIView

@property (nonatomic, weak) UITableView *tableView;

@property(nonatomic,copy)NSMutableArray *tableViews;

@property (nonatomic, assign)CGFloat tableOffSet;

@property (nonatomic, assign)<ZLHeaderViewDelegate>delegate;

@end
