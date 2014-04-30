//
//  SixClassicFeed.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-29.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SixClassicFeed.h"

@implementation SixClassicFeed

-(void)SixClassicFeedSetDic:(NSDictionary *)dic{
    self.default_image=[NSString stringWithFormat:@"%@",[dic objectForKey:@"default_image"]];
    self.default_cate=[NSString stringWithFormat:@"%@",[dic objectForKey:@"default_cate"]];
    self.cate_id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"cate_id"]];
    
    NSArray *array_cates=[NSArray array];
    array_cates=[dic objectForKey:@"cates"];
    
    for (int i=0; i<array_cates.count; i++) {
        NSDictionary *dic_cates=[array_cates objectAtIndex:i];
        NSString *str_cates=[dic_cates objectForKey:@"cate_name"];
        if (str_cates.length==4) {
            str_cates=[NSString stringWithFormat:@"%@ \n",str_cates];
        }
        
        if (i==0) {
            self.cates=[NSString stringWithFormat:@"%@",[dic_cates objectForKey:@"cate_name"]];
        }else{
            self.cates=[NSString stringWithFormat:@"%@    %@",self.cates,str_cates];

        }
        
    }
 
}


@end
