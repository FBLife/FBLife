//
//  MainMallFeed.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainMallFeed : NSObject
/**
 *  {
 link: "http://mall.fblife.com/index.php?app=store&id=62215",
 title: "威曼改装",
 default_image: "http://mall.fblife.com/data/files/mallindex/commend_store/20140416/20140416162222.jpg"
 },
 */

@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *default_image;

-(void)setDic:(NSDictionary*)dicinfo;
@end
