//
//  CustomCollectionViewCell.h
//  GridTurnToListDemo
//
//  Created by 刘星星 on 16/10/20.
//  Copyright © 2016年 刘星星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;
@interface CustomCollectionViewCell : UICollectionViewCell
@property (assign, nonatomic, getter=isCollectionStyleList) BOOL collectionStyleList;///< 默认是列表
@property (strong, nonatomic) Model *model;
@end
