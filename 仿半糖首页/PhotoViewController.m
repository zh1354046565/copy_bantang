//
//  PhotoViewController.m
//  runtime练习
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "PhotoViewController.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "PhotoCell.h"
#import "CollectionReusableView.h"

static NSString *photoCell;
@interface PhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.datas = [NSMutableArray array];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionV];
    
//    _collectionV.scrollIndicatorInsets = UIEdgeInsetsMake(182, 0, 0, 0);
    
    [_collectionV registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
//    [_collectionV registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    [self addheaderRefresh];
}

//#pragma mark 每个sectionHeader的大小 若想显示Header 必须返回Header高度
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    
//    if (section == 0) {
//        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 242);
//    }else{
//        
//        return CGSizeZero;
//    }
//    
//}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
//        CollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
//        
//        return header;
//    }
//    
//    return nil;
//}


#pragma mark - 复用viewController时 清空原来数据
- (void)prepareForReuse {
    //清空原来的数据
    [self.datas removeAllObjects];
    [self.collectionV reloadData];
}

-(void)loadPhotoData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.datas removeAllObjects];
        int count = (arc4random()%40)+1;
        for (int i = 0; i<count; i++) {
            [self.datas addObject:[NSNumber numberWithInt:i]];
        }
        [_collectionV.mj_header endRefreshing];
        [_collectionV reloadData];
        
    });
}

- (void)addheaderRefresh{
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadPhotoData];
        
    }];
    [self.collectionV.mj_header beginRefreshing];
}

-(void)reloadDatas{
    //这里，比较好的处理方式是：优先加载本地缓存数据，无缓存数据时再请求服务端数据
    [self addheaderRefresh];
    //PhotoBlock(self.collectionV.contentOffset.y);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"manji.png"];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-22)/3, (self.view.frame.size.width-22)/3);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
