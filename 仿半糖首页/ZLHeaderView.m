//
//  ZLHeaderView.m
//  仿半糖首页
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "ZLHeaderView.h"
#import "UIView+Extension.h"
#import "UIImage+JQImage.h"

@interface ZLHeaderView ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *emailButton;

@end

@implementation ZLHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchBar];
        [self addSubview:self.searchButton];
        [self addSubview:self.emailButton];
    }
    return self;
}

-(void)setTableOffSet:(CGFloat)tableOffSet{
    //设置背景色渐变 关联tableView的偏移量
    UIColor *color = [UIColor whiteColor];
    CGFloat alpha = MIN(1, (tableOffSet + 242)/140);
    self.backgroundColor = [color colorWithAlphaComponent:alpha];
    
    if (tableOffSet < -110) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.searchButton.hidden = NO;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
            self.searchBar.frame = CGRectMake(-(self.width-60), 30, self.width-80, 30);
            self.emailButton.alpha = 1-alpha;
            self.searchButton.alpha = 1-alpha;
        }];
    }else if (tableOffSet >= -110){
        [UIView animateWithDuration:0.25 animations:^{
            
            self.searchBar.frame = CGRectMake(20, 30, self.width-80, 30);
            self.searchButton.hidden = YES;
            self.emailButton.alpha = 1;
            [self.emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_red"] forState:UIControlStateNormal];
        }];
    }
    
}


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(-(self.width - 60), 30, self.width - 80, 30)];
        _searchBar.placeholder = @"搜索值得买的好物";
        _searchBar.layer.cornerRadius = 15;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.delegate = self;
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:_searchBar.size] forState:UIControlStateNormal];
        
        [_searchBar setBackgroundImage:[UIImage imageWithColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] size:_searchBar.size]];
        
        UITextField *textField = [_searchBar valueForKey:@"_searchField"];
        textField.textColor = [UIColor whiteColor];
        [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        textField.tintColor = [UIColor whiteColor];
    }
    return _searchBar;
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 30, 30)];
        
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _searchButton;
}

-(UIButton *)emailButton{
    if (!_emailButton) {
        _emailButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width-45, 30, 30, 30)];
        [_emailButton setBackgroundImage:[UIImage imageNamed:@"home_email_black"] forState:UIControlStateNormal];
        
    }
    return _emailButton;

}

-(void)searchBtnAction:(UIButton *)btn{
    //if ([self respondsToSelector:@selector(goToSearch)]) {
        [self.delegate goToSearch];
    //}
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.delegate goToSearch];
    return NO;
}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //[self.delegate goToSearch];
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
