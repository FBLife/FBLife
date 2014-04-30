//
//  shouyehuandengfeed.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "shouyehuandengfeed.h"


@implementation shouyehuandengfeed

-(void)setDic:(NSDictionary *)dicinfoofmodel{
    self.type=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"type"]];
    self.link=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"link"]];
    self.slide_img=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"slide_img"]];
}

@end
