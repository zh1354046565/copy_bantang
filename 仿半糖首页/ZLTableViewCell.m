//
//  ZLTableViewCell.m
//  仿半糖首页
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 张磊. All rights reserved.
//

#import "ZLTableViewCell.h"
#import "Masonry.h"
#import "ZLModel.h"
#import "UIImageView+WebCache.h"

@interface ZLTableViewCell ()

@property (nonatomic, strong) UIImageView *topicimageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *pvImageView;
@property (nonatomic, strong) UILabel *pvLabel;//浏览量
@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIView *bottomView;//用于使下面的控件整体居中

@end

@implementation ZLTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.topicimageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.pvImageView];
        [self.contentView addSubview:self.pvLabel];
        [self.contentView addSubview:self.likeImageView];
        [self.contentView addSubview:self.likeLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_topicimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_topicimageView.mas_bottom).offset(20);
    }];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bottomView.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(15);
    }];
    [_pvImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_authorLabel.mas_right).offset(10);
        make.top.mas_equalTo(_authorLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    
    [_pvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pvImageView.mas_right).offset(5);
        make.top.mas_equalTo(_authorLabel.mas_top);
    }];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pvLabel.mas_right).offset(10);
        make.top.mas_equalTo(_authorLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_likeImageView.mas_right).offset(5);
        make.top.mas_equalTo(_authorLabel.mas_top);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_authorLabel.mas_left);
        make.right.mas_equalTo(_likeLabel.mas_right);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(_authorLabel.mas_height);
    }];
}

-(void)setModel:(ZLModel *)model{
    [self.topicimageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:model.placeholderImage];
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author;
    self.pvLabel.text = model.views;
    self.likeLabel.text = model.likes;
}

-(UIImageView *)topicimageView{
    if (!_topicimageView) {
        _topicimageView = [[UIImageView alloc]init];
        _topicimageView.image = [UIImage imageNamed:@"recomand_01.jpg"];
    }
    return _topicimageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
    }
    return _bottomView;
}

-(UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _authorLabel.font = [UIFont systemFontOfSize:11];
    }
    return _authorLabel;
}

-(UIImageView *)pvImageView{
    if (!_pvImageView) {
        _pvImageView = [UIImageView new];
        _pvImageView.image = [UIImage imageNamed:@"home_watch"];
    }
    return _pvImageView;
}
-(UILabel *)pvLabel{
    if (!_pvLabel) {
        _pvLabel = [[UILabel alloc] init];
        _pvLabel.textColor = [UIColor grayColor];
        _pvLabel.font = [UIFont systemFontOfSize:11];
    }
    return _pvLabel;
}
-(UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [UIImageView new];
        _likeImageView.image = [UIImage imageNamed:@"home_like"];
    }
    return _likeImageView;
}
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [UILabel new];
        _likeLabel.textColor = [UIColor grayColor];
        _likeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _likeLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
