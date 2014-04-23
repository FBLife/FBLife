//
//  ProductCunstomTableViewCell.h
//  越野e族
//
//  Created by soulnear on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "ProductModel.h"
#import "EvaluationStars.h"

typedef enum
{
    ProductCellTypeDetail = 0,//商品详情
    ProductCellTypeEvaluation,//商品评价
    ProductCellTypeIntroduce//商品介绍
}ProductCellType;

@interface ProductCustomCell : UITableViewCell
{
    
}

@property(nonatomic,strong)AsyncImageView * buyersHeaderImageView;

@property(nonatomic,strong)UILabel * buyersUserNameLabel;

@property(nonatomic,strong)UILabel * buyTimeLabel;

@property(nonatomic,strong)UILabel * commentsContentLabel;

@property(nonatomic,strong)EvaluationStars * commentsStarsImageView;



-(void)setAllViewsWithCellType:(ProductCellType)theType;

-(void)setInfoWithProductInfo:(ProductModel *)info;


@end
