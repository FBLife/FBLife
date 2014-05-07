//
//  SellerInfo.m
//  越野e族
//
//  Created by soulnear on 14-4-25.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SellerInfo.h"

@implementation SellerInfo
@synthesize SDescription = _SDescription;
@synthesize SRegionName = _SRegionName;
@synthesize SStoreLogo = _SStoreLogo;
@synthesize SStoreName = _SStoreName;
@synthesize STelephone = _STelephone;
@synthesize SStoreUid = _SStoreUid;
//推荐商品
@synthesize GoodsImage = _GoodsImage;
@synthesize GoodsId = _GoodsId;
@synthesize GoodsName = _GoodsName;
@synthesize GoodsPrice = _GoodsPrice;



-(SellerInfo *)initWithDic:(NSDictionary *)myDic
{
    self = [super init];
    
    if (self) {
        self.SStoreName = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"store_name"]];
        
        self.SStoreUid = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"store_id"]];
        
        self.SDescription = [NSString stringWithFormat:@"%@",[[myDic objectForKey:@"description"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        self.SStoreLogo = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"store_logo"]];
        
        self.SRegionName = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"region_name"]];
        
        self.STelephone = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"tel"]];
        
        self.GoodsPrice = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"price"]];
        
        self.GoodsId = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"goods_id"]];
        
        self.GoodsImage = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"default_image"]];
        
        self.GoodsName = [NSString stringWithFormat:@"%@",[myDic objectForKey:@"goods_name"]];
        
        
        
    }
    
    return self;
}

-(void)loadInfomationWithUrl:(NSString *)theUrl WithBlock:(SellersBlock)theBlock
{
    sellerBlock = theBlock;
    
    loadRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:theUrl]];
    
    loadRequest.delegate = self;
    
    
    __block ASIHTTPRequest * request = loadRequest;
    
    [request setCompletionBlock:^{
        
        @try {
            NSDictionary * totalDic = [loadRequest.responseData objectFromJSONData];
            
            if ([[totalDic objectForKey:@"errcode"] intValue]==0) {
                SellerInfo * info = [[SellerInfo alloc] initWithDic:[totalDic objectForKey:@"datainfo"]];
                
                if (sellerBlock) {
                    sellerBlock(info);
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    [loadRequest startAsynchronous];
}



-(void)loadRecommendGoodsWithUrl:(NSString *)theUrl WithBlock:(goodsBlock)theBlock
{
    myGoodsBlock = theBlock;
    goods_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:theUrl]];
    
    goods_request.delegate = self;
    
    __block ASIHTTPRequest * request = goods_request;
    
    [request setCompletionBlock:^{
        
        @try {
            NSDictionary * totalDic = [goods_request.responseData objectFromJSONData];
            if ([[totalDic objectForKey:@"errcode"] intValue]==0) {
                
                if ([[totalDic objectForKey:@"allnumbers"] intValue]==0) {
                    myGoodsBlock([NSMutableArray array]);
                }else
                {
                    NSMutableArray * data = [[NSMutableArray alloc] init];
                    
                    NSArray * key_array = [totalDic objectForKey:@"datainfo"];
                    
                    for (NSDictionary * aDic in key_array) {
                        
                        SellerInfo * info = [[SellerInfo alloc] initWithDic:aDic];
                                                
                        [data addObject:info];
                    }
                    myGoodsBlock(data);
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
       
    }];
    
    [request setFailedBlock:^{
        
    }];
    
    [goods_request startAsynchronous];
}


-(void)dealloc
{
    [loadRequest cancel];
    loadRequest.delegate = nil;
    loadRequest = nil;
    
    [goods_request cancel];
    goods_request.delegate = nil;
    goods_request = nil;
}




@end
































