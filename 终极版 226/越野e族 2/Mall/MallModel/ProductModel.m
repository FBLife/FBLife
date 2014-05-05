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
@synthesize PCommentsCount = _PCommentsCount;
@synthesize BuyerId = _BuyerId;
@synthesize BuyerName = _BuyerName;
@synthesize CommentsContent = _CommentsContent;
@synthesize CommentsEvaluation = _CommentsEvaluation;
@synthesize CommentsTime = _CommentsTime;





-(ProductModel *)initWithDictionary:(NSDictionary *)theDictionary
{
    self = [super init];
    if (self) {
        self.PName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"goods_name"]];
        
        self.PPrice = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"price"]];

        self.PMark = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"cate_name"]];

        self.PBrwoseCount = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"views"]];
        
        self.PBrand = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"brand"]];
        
        self.PCommentsCount = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"comments"]];
        
        self.PDetails = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"description"]];
        
        self.PArea = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"region_name"]];
        
        self.PStoreId = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"store_id"]];
        
        
        NSArray * imageArray = [theDictionary objectForKey:@"_images"];
        
        _PImages = [[NSMutableArray alloc] init];
        
        for (NSDictionary * imgDic in imageArray) {
            ProductImageModel * imageModel = [[ProductImageModel alloc] initWithDic:imgDic];
            
            [_PImages addObject:imageModel];
        }
        
        //评论
        
        self.BuyerId = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"buyer_id"]];
        
        self.BuyerName = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"buyer_name"]];
        
        self.CommentsContent = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"comment"]];
        
        self.CommentsEvaluation = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"evaluation"]];
        
        self.CommentsTime = [NSString stringWithFormat:@"%@",[theDictionary objectForKey:@"evaluation_time"]];
        
        
    }
    return self;
}


@end



















































