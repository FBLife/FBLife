//
//  SellerInfo.h
//  越野e族
//
//  Created by soulnear on 14-4-25.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SellerInfo;

typedef void(^SellersBlock)(SellerInfo * theInfo);

typedef void(^goodsBlock)(NSMutableArray * dataArray);

@interface SellerInfo : NSObject<ASIHTTPRequestDelegate>
{
    SellersBlock sellerBlock;
    
    goodsBlock myGoodsBlock;
    
    ASIHTTPRequest * loadRequest;
    
    ASIHTTPRequest * goods_request;
}


//商家信息

@property(nonatomic,strong)NSString * SStoreUid;//商家id
@property(nonatomic,strong)NSString * SStoreName;//商家名称
@property(nonatomic,strong)NSString * SRegionName;//商家所在地区
@property(nonatomic,strong)NSString * SDescription;//商家介绍
@property(nonatomic,strong)NSString * SStoreLogo;//商家logo
@property(nonatomic,strong)NSString * STelephone;//商家所在地区

//商家推荐商品

@property(nonatomic,strong)NSString * GoodsId;
@property(nonatomic,strong)NSString * GoodsName;
@property(nonatomic,strong)NSString * GoodsImage;
@property(nonatomic,strong)NSString * GoodsPrice;


-(SellerInfo *)initWithDic:(NSDictionary *)myDic;

-(void)loadInfomationWithUrl:(NSString *)theUrl WithBlock:(SellersBlock)theBlock;

-(void)loadRecommendGoodsWithUrl:(NSString *)theUrl WithBlock:(goodsBlock)theBlock;


@end
