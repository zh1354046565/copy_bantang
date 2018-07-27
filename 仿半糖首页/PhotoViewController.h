//
//  PhotoViewController.h
//  runtime练习
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
-(void)reloadDatas;
@property (nonatomic, strong)UICollectionView *collectionV;
//And:(void(^)(CGFloat offSet))PhotoBlock;

@property (nonatomic, copy)void(^PhotoBlock)(CGFloat offsetY);

@end
