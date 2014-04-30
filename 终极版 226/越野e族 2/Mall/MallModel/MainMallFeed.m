//
//  MainMallFeed.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainMallFeed.h"

@implementation MainMallFeed


-(void)setDic:(NSDictionary*)dicinfo{
    self.link=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"link"]];
    self.title=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"title"]];
    self.default_image=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"default_image"]];
}


@end
