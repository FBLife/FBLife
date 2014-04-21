//
//  ProductModel.h
//  越野e族
//
//  Created by soulnear on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProductImageModel : NSObject
{
    
}

@property(nonatomic,strong)NSString * IFileId;
@property(nonatomic,strong)NSString * IGoodsId;
@property(nonatomic,strong)NSString * IImageId;
@property(nonatomic,strong)NSString * IImageUrl;
@property(nonatomic,strong)NSString * ISortOrder;
@property(nonatomic,strong)NSString * IThumbnail;


-(ProductImageModel *)initWithDic:(NSDictionary *)theDic;

@end


@interface ProductModel : NSObject
{
    
}

@property(nonatomic,strong)NSString * PName;//商品名称
@property(nonatomic,strong)NSString * PTopCount;//商品赞数
@property(nonatomic,strong)NSString * PPrice;//商品价格
@property(nonatomic,strong)NSString * PBrand;//商品所属品牌
@property(nonatomic,strong)NSString * PMark;//商品标签
@property(nonatomic,strong)NSString * PBrwoseCount;//商品浏览次数
@property(nonatomic,strong)NSString * PArea;//所在地区
@property(nonatomic,strong)NSString * PDetails;//商品详情
@property(nonatomic,strong)NSString * PIntroduce;//商品介绍
@property(nonatomic,strong)NSString * PMerchantsName;//商家名字
@property(nonatomic,strong)NSString * PMerchantsImage;//商家头像
@property(nonatomic,strong)NSArray * PImages;//商品图片
@property(nonatomic,strong)NSString * PGoodsId;//商品ID
@property(nonatomic,strong)NSString * PStoreId;//店铺ID
@property(nonatomic,strong)NSString * PCateId;//商品分类ID
@property(nonatomic,strong)NSString * PCateName;//商品所属分类名称
@property(nonatomic,strong)NSString * PStock;//库存
@property(nonatomic,strong)NSString * PSales;//已售商品数



-(ProductModel *)initWithDictionary:(NSDictionary *)theDictionary;


@end










