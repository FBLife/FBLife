//
//  SixClassicFeed.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-29.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SixClassicFeed : NSObject
@property(nonatomic,strong)NSString *default_cate;
@property(nonatomic,strong)NSString *default_image;
@property(nonatomic,strong)NSString *cate_id;
@property(nonatomic,strong)NSString *cates;

-(void)SixClassicFeedSetDic:(NSDictionary *)dic;

@end
