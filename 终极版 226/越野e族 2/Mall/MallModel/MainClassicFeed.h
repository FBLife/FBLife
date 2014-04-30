//
//  MainClassicFeed.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainClassicFeed : NSObject
/**
 *  img_type: "1",
 title: "越野e族超大容量移动便携充电宝 ",
 price: "78.00",
 link: "http://mall.fblife.com/index.php?app=goods&id=9695",
 cate1: "服饰鞋帽",
 cate2: "e族服饰",
 default_image: "http://mall.fblife.com/data/files/mallindex/goods_sort/20140418/20140418175344.jpg"
 */




@property(nonatomic,strong)NSString *img_type;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *cate1;
@property(nonatomic,strong)NSString *cate2;
@property(nonatomic,strong)NSString *default_image;
@property(nonatomic,strong)NSString *price;


-(void)setDic:(NSDictionary*)dicinfo;



@end
