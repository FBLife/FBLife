//
//  DetailClassifyModel.m
//  越野e族
//
//  Created by soulnear on 14-5-5.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailClassifyModel.h"

@implementation DetailClassifyModel
@synthesize ClassChildren = _ClassChildren;
@synthesize ClassId = _ClassId;
@synthesize ClassValue = _ClassValue;



-(DetailClassifyModel *)initWithDic:(NSDictionary *)theDic
{
    self = [super init];
    
    if (self) {
        
        self.ClassId = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"id"]];
        
        self.ClassValue = [NSString stringWithFormat:@"%@",[theDic objectForKey:@"value"]];
        
        
        NSArray * tempArray = [NSArray arrayWithArray:[theDic objectForKey:@"children"]];
        
        self.ClassChildren = [NSMutableArray array];
        
        
        for (NSDictionary * dic in tempArray) {
            DetailClassifyModel * model = [[DetailClassifyModel alloc] init];
            
            model.ClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            
            model.ClassValue = [NSString stringWithFormat:@"%@",[dic objectForKey:@"value"]];
            
            model.ClassChildren = [NSMutableArray arrayWithArray:[dic objectForKey:@"children"]];
            
            [self.ClassChildren addObject:model];
        }
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
            
            NSMutableArray * total_array = [NSMutableArray array];
            
            if ([errcode intValue]==0)
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



-(void)dealloc
{
    [ClassifyRequest cancel];
    
    ClassifyRequest.delegate = nil;
    
    ClassifyRequest = nil;
    
    _ClassChildren = nil;
    
    _ClassId = nil;
    
    _ClassValue = nil;
}


@end





















