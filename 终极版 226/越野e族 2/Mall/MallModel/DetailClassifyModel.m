//
//  DetailClassifyModel.m
//  越野e族
//
//  Created by soulnear on 14-5-5.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailClassifyModel.h"

@implementation DetailClassifyModel

@synthesize ClassCateId = _ClassCateId;
@synthesize ClassCates = _ClassCates;
@synthesize ClassDefaultCate = _ClassDefaultCate;
@synthesize ClassDefaultImage = _ClassDefaultImage;


@synthesize TClassChildren = _TClassChildren;
@synthesize TClassID = _TClassID;
@synthesize TClassValue = _TClassValue;



-(DetailClassifyModel *)initWithDic:(NSDictionary *)theDic
{
    self = [super init];
    
    if (self) {
        
        self.ClassDefaultCate = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"default_cate"]];
        
        self.ClassDefaultImage = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"default_image"]];
        
        self.ClassCateId = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"cate_id"]];
        
        self.ClassCates = [NSMutableArray arrayWithArray:[theDic objectForKey:@"cates"]];
        
        }
    return self;
}



-(DetailClassifyModel *)initWithTwoDic:(NSDictionary *)theDic
{
    self = [super init];

    if (self) {
        
        self.TClassID = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"id"]];
        
        self.TClassValue = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"value"]];
        
        self.TClassChildren = [NSMutableArray arrayWithArray:[theDic objectForKey:@"children"]];
    }
    
    return self;
}



-(void)initHttpRequestWithUrl:(NSString *)theUrl WithBlock:(DetailClassifModelBlock)theBlock
{
    myBlock = theBlock;
    
    ClassifyRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:theUrl]];
    
    __weak ASIHTTPRequest * request = ClassifyRequest;
    
    [request setCompletionBlock:^{
        @try {
            NSDictionary * jsonDic = [ClassifyRequest.responseData objectFromJSONData];
            
            NSString * errcode = [jsonDic objectForKey:@"errcode"];
            
            NSString * errorinfo = [jsonDic objectForKey:@"errorinfo"];
            
            NSMutableArray * total_array = [NSMutableArray array];
            
            if ([errcode intValue]==0 && [errorinfo isEqualToString:@"noerror"])
            {
                NSArray * data_array = [jsonDic objectForKey:@"datainfo"];
                
                for (NSDictionary * subDic in data_array) {
                    
                    DetailClassifyModel * model = [[DetailClassifyModel alloc] initWithDic:subDic];
                    
                    [total_array addObject:model];
                }
            }
            
            if (myBlock) {
                myBlock(total_array);
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [ClassifyRequest startAsynchronous];
    
}


-(void)initHttpRequestTwoWithUrl:(NSString *)theUrl WithBlock:(DetailClassifModelBlock)theBlock
{
    myBlock = theBlock;
    
    ClassifyRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:theUrl]];
    
    __weak ASIHTTPRequest * request = ClassifyRequest;
    
    [request setCompletionBlock:^{
        @try {
            NSDictionary * jsonDic = [ClassifyRequest.responseData objectFromJSONData];
            
            NSString * errcode = [jsonDic objectForKey:@"errcode"];
            
            NSMutableArray * total_array = [NSMutableArray array];
            
            if ([errcode intValue]==0)
            {
                NSArray * data_array = [[jsonDic objectForKey:@"datainfo"] objectForKey:@"children"];
                
                for (NSDictionary * subDic in data_array) {
                    
                    DetailClassifyModel * model = [[DetailClassifyModel alloc] initWithTwoDic:subDic];
                    
                    [total_array addObject:model];
                }
            }
            
            if (myBlock) {
                myBlock(total_array);
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [request setFailedBlock:^{
        
    }];
    
    [ClassifyRequest startAsynchronous];
}



-(void)dealloc
{
    [ClassifyRequest cancel];
    
    ClassifyRequest.delegate = nil;
    
    ClassifyRequest = nil;
    
    _ClassDefaultImage = nil;
    
    _ClassDefaultCate = nil;
    
    _ClassCates = nil;
    
    _ClassCateId = nil;
    
    _TClassValue = nil;
    
    _TClassID = nil;
    
    _TClassChildren = nil;
}


@end





















