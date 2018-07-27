//
//  ViewController.m
//  仿半糖首页
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"
#import "UIView+Extension.h"
#import "ZLHeaderView.h"
//#import "ZLTableViewController.h"
#import "HMSegmentedControl.h"
#import "ZLSliderPageReuseManager.h"
#import "PhotoViewController.h"
#import "CategoryController.h"


#define CATEGORY  @[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物",@"阅读",@"运动健身",@"旅行户外"]

#define NAVBARHEIGHT 64.0f

#define FONTMAX 15.0
#define FONTMIN 14.0
#define PADDING 15.0

@interface ViewController ()<UIScrollViewDelegate,ZLHeaderViewDelegate>
@property (nonatomic, strong)ZLHeaderView *headerView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;//轮播图
/*
 *  滑动相关事件
 */
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *bottomScrollView;

//记录上一个偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;
@property (nonatomic, strong) ZLSliderPageReuseManager *reuseManager;

@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, copy)NSString *indexStr;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _reuseManager = [[ZLSliderPageReuseManager alloc]initWith:CATEGORY.count];
//    _reuseManager.capacity = CATEGORY.count;
    [_reuseManager registerClass:[CategoryController class] forReuseIdentifier:@"category"];
    [_reuseManager registerClass:[PhotoViewController class] forReuseIdentifier:@"photo"];
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.headerView];
    [self sliderToViewAtIndex:0];
}

-(void)sliderToViewAtIndex:(NSInteger)index{
    self.indexStr =  [NSString stringWithFormat:@"%ld",index];
    if (index%2 == 0) {
        NSInteger categoryId = index;
        CategoryController *cateVc = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:@"category" forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        if (!cateVc.parentViewController) {
            [self addChildViewController:cateVc];
        }
        cateVc.categoryId = categoryId;
        //如果是复用的ViewController，则加载新数据
        if (cateVc.isReuse) {
            [cateVc reloadDatas];
        }
        [_bottomScrollView layoutIfNeeded];
        cateVc.view.frame = CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame));
        [cateVc.table setContentOffset:CGPointMake(0, [[self.dic objectForKey:self.indexStr] floatValue])];
        /**/
        cateVc.table.contentInset = UIEdgeInsetsMake(242, 0, 0, 0);
        [ZLSliderPageReuseManager observeController:^(NSKeyValueObservingOptions options, NSString *keyPathStr) {
            [cateVc.table addObserver:self forKeyPath:keyPathStr options:options context:nil];
        }];
        [_bottomScrollView addSubview:cateVc.view];
    }else{
        NSInteger categoryId = index;
        PhotoViewController *photoVC = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:@"photo" forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        if (!photoVC.parentViewController) {
            [self addChildViewController:photoVC];
        }
        //如果是复用的ViewController，则加载新数据
        if (photoVC.isReuse) {
            [photoVC reloadDatas];
        }
        [_bottomScrollView layoutIfNeeded];
        photoVC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame));
        [photoVC.collectionV setContentOffset:CGPointMake(0, [[self.dic objectForKey:self.indexStr] floatValue])];
        /**/
        photoVC.collectionV.contentInset = UIEdgeInsetsMake(242, 0, 0, 0);
        
        [ZLSliderPageReuseManager observeController:^(NSKeyValueObservingOptions options, NSString *keyPathStr) {
            
            [photoVC.collectionV addObserver:self forKeyPath:keyPathStr options:options context:nil];
        }];
        [_bottomScrollView addSubview:photoVC.view];
    }
    if (self.segmentControl.selectedSegmentIndex != index) {
        [self.segmentControl setSelectedSegmentIndex:index animated:YES];
    }
    [_bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0)];
    
}

#pragma mark - kvo监听偏移量
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if ([object isKindOfClass:[UITableView class]]) {
        
        self.lastTableViewOffsetY = [(UITableView *)object contentOffset].y;
    }else{
        self.lastTableViewOffsetY = [(UICollectionView *)object contentOffset].y;
    }
    [self.dic setValue:[NSString stringWithFormat:@"%f",self.lastTableViewOffsetY] forKey:self.indexStr];
    NSLog(@"=====%@",self.dic);
    
    
    self.headerView.tableOffSet = [[self.dic objectForKey:self.indexStr]floatValue];
//    NSLog(@"%f",self.lastTableViewOffsetY);
    if (self.lastTableViewOffsetY > -242 && self.lastTableViewOffsetY<=-105) {
        self.segmentControl.frame = CGRectMake(0, 200-(242 + self.lastTableViewOffsetY), SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, -242-self.lastTableViewOffsetY, SCREEN_WIDTH, 200);
    }else if (self.lastTableViewOffsetY <= -242){
        self.segmentControl.frame = CGRectMake(0, 200, SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }else if (self.lastTableViewOffsetY > -105){
        self.segmentControl.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, -136, SCREEN_WIDTH, 200);
    }
}


#pragma mark - 懒加载
-(NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = @{}.mutableCopy;
    }
    return _dic;
}

-(UIScrollView *)bottomScrollView{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.bounces = NO;
        _bottomScrollView.backgroundColor = [UIColor whiteColor];
        self.bottomScrollView.contentSize = CGSizeMake(CATEGORY.count * SCREEN_WIDTH, 0);
        
    }
    return _bottomScrollView;
}

-(HMSegmentedControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
        _segmentControl.sectionTitles = CATEGORY;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectionIndicatorHeight = 1;
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
        _segmentControl.selectionIndicatorColor = [UIColor redColor];
        _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        
        [_segmentControl setSelectedTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        [_segmentControl addTarget:self action:@selector(titleSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        NSMutableArray *imageMutableArray = @[].mutableCopy;
        for (int i = 0; i<9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imageMutableArray addObject:imageName];
        }
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageNamesGroup:imageMutableArray];
    }
    return _cycleScrollView;
}
-(ZLHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ZLHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.delegate = self;
    }
    return _headerView;
}
#pragma mark - ZLHeaderViewDelegate
-(void)goToSearch{
    Class vc = NSClassFromString(@"ZLSearchViewController");
    [self.navigationController pushViewController:[vc new] animated:YES];
}

#pragma mark - scrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double dindex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger index = (NSInteger)(dindex+0.5);
    if (index == self.segmentControl.selectedSegmentIndex) {
        return;
    }
    [self sliderToViewAtIndex:index];
}
#pragma mark - 点击选项卡方法
-(void)titleSegmentControlChanged:(HMSegmentedControl *)segmentedControl{
    [self sliderToViewAtIndex:segmentedControl.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
