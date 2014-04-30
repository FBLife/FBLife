//
//  MainMagiClanternModel.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

typedef void(^myBlock)(NSArray *arrayinfo,NSString *errorindo);


//@interface model : NSObject
//
//-(void)setDic:(NSDictionary *)dicinfoofmodel;
//
//@property(nonatomic,strong)NSString *type;
//
//@property(nonatomic,strong)NSString *link;
//@property(nonatomic,strong)NSString *slide_img;
//
//
//@end
//
//
//@implementation model
//
//-(void)setDic:(NSDictionary *)dicinfoofmodel{
//    self.type=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"type"]];
//    self.link=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"link"]];
//    self.slide_img=[NSString stringWithFormat:@"%@",[dicinfoofmodel objectForKey:@"slide_img"]];
//}
//
//@end



@interface MainMagiClanternModel : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSString *string_url;

-(void)SeturlStr:(NSString *)str block:(myBlock)block;
@property(nonatomic,copy)myBlock testBlocksbl;
@property(nonatomic,strong)NSDictionary *mydicinfo;
//@property(nonatomic,strong)model *yyyyy;

@end
