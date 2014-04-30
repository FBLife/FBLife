//
//  MainClassicFeed.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainClassicFeed.h"

@implementation MainClassicFeed
 /**
 *  img_type: "1",
 title: "越野e族超大容量移动便携充电宝 ",
 price: "78.00",
 link: "http://mall.fblife.com/index.php?app=goods&id=9695",
 cate1: "服饰鞋帽",
 cate2: "e族服饰",
 default_image: "http://mall.fblife.com/data/files/mallindex/goods_sort/20140418/20140418175344.jpg"
 */

-(void)setDic:(NSDictionary*)dicinfo{
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"img_type"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"title"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"price"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"link"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"cate1"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"cate2"]];
    self.img_type=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"default_image"]];

    
}


@end
