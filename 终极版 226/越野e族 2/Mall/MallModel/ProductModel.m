//
//  ProductModel.m
//  越野e族
//
//  Created by soulnear on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ProductModel.h"


@implementation ProductImageModel
@synthesize IFileId = _IFileId;
@synthesize IGoodsId = _IGoodsId;
@synthesize IImageId = _IImageId;
@synthesize IImageUrl = _IImageUrl;
@synthesize ISortOrder = _ISortOrder;
@synthesize IThumbnail = _IThumbnail;


-(ProductImageModel *)initWithDic:(NSDictionary *)theDic
{
    self = [super init];
    
    if (self) {
        
        self.IFileId = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"file_id"]];
        
        self.IGoodsId = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"goods_id"]];
        
        self.IImageId = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"image_id"]];
        
        self.IImageUrl = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"image_url"]];
        
        self.ISortOrder = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"sort_order"]];
        
        self.IThumbnail = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"thumbnail"]];
    }
    
    return self;
}


@end



@implementation ProductModel
@synthesize PName = _PName;
@synthesize PArea = _PArea;
@synthesize PBrand = _PBrand;
@synthesize PBrwoseCount = _PBrwoseCount;
@synthesize PDetails = _PDetails;
@synthesize PIntroduce = _PIntroduce;
@synthesize PMark = _PMark;
@synthesize PMerchantsImage = _PMerchantsImage;
@synthesize PMerchantsName = _PMerchantsName;
@synthesize PTopCount = _PTopCount;
@synthesize PPrice = _PPrice;
@synthesize PImages = _PImages;
@synthesize PCateId = _PCateId;
@synthesize PCateName = _PCateName;
@synthesize PGoodsId = _PGoodsId;
@synthesize PSales = _PSales;
@synthesize PStock = _PStock;
@synthesize PStoreId = _PStoreId;




-(ProductModel *)initWithDictionary:(NSDictionary *)theDictionary
{
    self = [super init];
    if (self) {
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PBrand = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
    }
    return self;
}


@end



















































