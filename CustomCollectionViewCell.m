//
//  CustomCollectionViewCell.m
//  GridTurnToListDemo
//
//  Created by 刘星星 on 16/10/20.
//  Copyright © 2016年 刘星星. All rights reserved.
//
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#import "CustomCollectionViewCell.h"
#import "Model.h"
#import "UIImageView+WebCache.h"
@interface CustomCollectionViewCell()
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@end
@implementation CustomCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    self.backgroundColor = [UIColor whiteColor];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageV];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_priceLabel];
}
- (void)setCollectionStyleList:(BOOL)collectionStyleList {
    _collectionStyleList = collectionStyleList;
    if (_collectionStyleList) {
        _imageV.frame = CGRectMake(5, 5, self.bounds.size.height - 10, self.bounds.size.height - 10);
        _titleLabel.frame = CGRectMake(self.bounds.size.height + 10, 0, ScreenWidth/2, self.bounds.size.height - 20);;
        _priceLabel.frame = CGRectMake(self.bounds.size.height + 10, self.bounds.size.height - 30, ScreenWidth/2, 20);;
    }else {
        _imageV.frame = CGRectMake(5, 5, self.bounds.size.width - 60, self.bounds.size.width - 60);
        _titleLabel.frame = CGRectMake(5, self.bounds.size.width - 45, ScreenWidth/2 - 5, 80);
        _priceLabel.frame = CGRectMake(5, self.bounds.size.height - 20, ScreenWidth/2, 20);
    }
}
- (void)setModel:(Model *)model {
    _model = model;
//    NSLog(@"%@",model.imageurl);
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    _titleLabel.text = model.wname;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.jdPrice];
}
@end
