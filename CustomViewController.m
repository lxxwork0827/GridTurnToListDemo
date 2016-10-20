//
//  CustomViewController.m
//  GridTurnToListDemo
//
//  Created by 刘星星 on 16/10/20.
//  Copyright © 2016年 刘星星. All rights reserved.
//

#import "CustomViewController.h"
#import "CustomCollectionViewCell.h"
#import "Model.h"
#import "NSObject+Property.h"
@interface CustomViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (assign, nonatomic, getter=isCollectionStyleList) BOOL collectionStyleList;///< 默认是列表
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UIButton *switchBtn;
@end
static NSString *const ID = @"CustomCollectionViewCell";
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
@implementation CustomViewController
#pragma mark - getter method
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//default
        flowLayout.minimumInteritemSpacing = 4;//水平间距
        flowLayout.minimumLineSpacing = 2;//竖直间距
//        NSLog(@"-----%@",NSStringFromCGRect(self.view.bounds));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, self.view.bounds.size.width - 10, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(2, 0, 2, -3);
//        _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - viewLife
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表切换";
    self.navigationController.navigationBar.translucent = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"product_list_list_btn"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(gotoChangeStyle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
    self.collectionStyleList = YES;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
    [self.view addSubview:self.collectionView];
    NSArray *dataArr = jsonDict[@"wareInfo"];
    for (NSDictionary *dict in dataArr) {
        [self.dataSource addObject:[Model modelWithDictionary:dict]];
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));
//    NSLog(@"+++++%@",NSStringFromCGRect(self.view.bounds));
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.collectionStyleList = self.collectionStyleList;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCollectionStyleList) {
         return CGSizeMake(ScreenWidth - 4, (ScreenWidth - 6) / 4 + 20);
    } else {
        return CGSizeMake((ScreenWidth - 15) / 2, (ScreenWidth - 6) / 2 + 40);
    }
}
- (void)gotoChangeStyle:(UIButton *)button{
    _collectionStyleList = !_collectionStyleList;
    [self.collectionView reloadData];
    
    if (!_collectionStyleList) {
        [button setImage:[UIImage imageNamed:@"product_list_grid_btn"] forState:0];
    } else {
        [button setImage:[UIImage imageNamed:@"product_list_list_btn"] forState:0];
    }
}
@end
