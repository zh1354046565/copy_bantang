//
//  CategoryController.m
//  runtime练习
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "CategoryController.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "ZLTableViewCell.h"
#import "ZLModel.h"


@interface CategoryController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.table];
    
    [self addheaderRefresh];
    
    
}
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = @[].mutableCopy;
    }
    return _modelArray;
}

- (void)prepareForReuse {
    
    //清空原来的数据
    [self.modelArray removeAllObjects];
    [self.table reloadData];
}

- (void)dealloc {
    
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}


#pragma mark - Data
-(void)loadData{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSArray * dataArray = [[dic objectForKey:@"data"] objectForKey:@"topic"];
    [self.modelArray removeAllObjects];
    for (int i = 0; i<dataArray.count; i++) {
        ZLModel *model = [ZLModel new];
        NSString *string = [NSString stringWithFormat:@"recomand_%02d%@",i+1,@".jpg"];
        UIImage *image  = [UIImage imageNamed:string];
        
        model.placeholderImage = image;
        
        NSDictionary *itemDic = dataArray[i];
        model.picUrl = [itemDic objectForKey:@"pic"];
        model.title = [itemDic objectForKey:@"title"];
        model.views = [itemDic objectForKey:@"views"];
        model.likes = [itemDic objectForKey:@"likes"];
        
        NSDictionary *userDic = [itemDic objectForKey:@"user"];
        model.author = [userDic objectForKey:@"nickname"];
        
        [self.modelArray addObject:model];
    }
    [self.table.mj_header endRefreshing];
    [self.table reloadData];
}

-(void)reloadDatas{
    //这里，比较好的处理方式是：优先加载本地缓存数据，无缓存数据时再请求服务端数据
    [self addheaderRefresh];

    //ZLBlock(self.table.contentOffset.y);

}

- (void)addheaderRefresh{
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
        
    }];
    [self.table.mj_header beginRefreshing];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZLTableViewCell class])];
    
    cell.model = self.modelArray[indexPath.row];
    
    return cell;
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[ZLTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ZLTableViewCell class])];
//        _table.contentInset = UIEdgeInsetsMake(242, 0, 0, 0);
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 242)];
//        headerView.backgroundColor = [UIColor whiteColor];
//        [_table addSubview:headerView];
//        _table.scrollIndicatorInsets = UIEdgeInsetsMake(182, 0, 0, 0);
//        _table.tableHeaderView = headerView;
    }
    return _table;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
