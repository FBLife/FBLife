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
#import "SellerInfo.h"

typedef enum
{
    ProductCellTypeDetail = 0,//商品详情
    ProductCellTypeEvaluation,//商品评价
    ProductCellTypeIntroduce//商品介绍
}ProductCellType;




@interface SellerInfoView : UIView
{
    AsyncImageView * headerImageView;
    UILabel * sellerName;
    UIButton * MessageButton;
    UIButton * telephoneButton;
}

-(SellerInfoView *)initWithFrame:(CGRect)frame;

-(void)SellerInfoViewData:(SellerInfo *)infomation;

@end





@interface ProductCustomCell : UITableViewCell
{
    
}

//商品详情

@property(nonatomic,strong)UIWebView * myWebView;

//商品评价

@property(nonatomic,strong)AsyncImageView * buyersHeaderImageView;

@property(nonatomic,strong)UILabel * buyersUserNameLabel;

@property(nonatomic,strong)UILabel * buyTimeLabel;

@property(nonatomic,strong)UILabel * commentsContentLabel;

@property(nonatomic,strong)EvaluationStars * commentsStarsImageView;

//商家介绍

@property(nonatomic,strong)NSString * SellerDescription;

@property(nonatomic,strong)SellerInfoView * myInfoView;



-(void)setAllViewsWithCellType:(ProductCellType)theType;

-(void)setInfoWithProductInfo:(ProductModel *)info WithType:(ProductCellType)theType;


@end



















