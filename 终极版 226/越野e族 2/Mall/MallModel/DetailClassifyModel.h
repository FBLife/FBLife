//
//  DetailClassifyModel.h
//  越野e族
//
//  Created by soulnear on 14-5-5.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DetailClassifModelBlock)(NSMutableArray * theArray);


@interface DetailClassifyModel : NSObject
{
    DetailClassifModelBlock myBlock;
    
    ASIHTTPRequest * ClassifyRequest;
}

@property(nonatomic,strong)NSString * ClassId;
@property(nonatomic,strong)NSString * ClassValue;
@property(nonatomic,strong)NSMutableArray * ClassChildren;


-(void)initHttpRequestWithUrl:(NSString *)theUrl WithBlock:(DetailClassifModelBlock)theBlock;


-(DetailClassifyModel *)initWithDic:(NSDictionary *)theDic;



@end
