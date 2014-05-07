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

//一级分类

@property(nonatomic,strong)NSString * ClassDefaultCate;//分类名称
@property(nonatomic,strong)NSString * ClassDefaultImage;//分类头像
@property(nonatomic,strong)NSString * ClassCateId;//分类ID
@property(nonatomic,strong)NSMutableArray * ClassCates;//分类内容(里边存放字典包含cate_name(名称) link（数字）两个字段)


//二级三级分类

@property(nonatomic,strong)NSString * TClassID;
@property(nonatomic,strong)NSString * TClassValue;
@property(nonatomic,strong)NSMutableArray * TClassChildren;



-(DetailClassifyModel *)initWithDic:(NSDictionary *)theDic;

-(void)initHttpRequestWithUrl:(NSString *)theUrl WithBlock:(DetailClassifModelBlock)theBlock;

-(DetailClassifyModel *)initWithTwoDic:(NSDictionary *)theDic;

-(void)initHttpRequestTwoWithUrl:(NSString *)theUrl WithBlock:(DetailClassifModelBlock)theBlock;



@end
















