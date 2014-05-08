//
//  SellersModel.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellersModel : NSObject
//商家主页需要的属性===============
@property(nonatomic,strong)NSString *sellerName;//商家名称
@property(nonatomic,strong)NSString *sellerId;//商家id
@property(nonatomic,strong)NSString *phoneNum;//商家联系电话
@property(nonatomic,strong)NSString *topImgeUrl;//logo上的横版图片
@property(nonatomic,strong)NSString *logoUrl;//logo图
@property(nonatomic,strong)NSString *starsUrl;//星星个数


@property(nonatomic,strong)NSString *webViewURL;//webview的请求地址
@property(nonatomic,strong)NSString *webViewStr;//商家店铺简介string

@property(nonatomic,strong)NSMutableArray *tuijianSPArray;//推荐商品数组
@property(nonatomic,strong)NSMutableArray *xinpinArray;//新品数组
@property(nonatomic,strong)NSMutableArray *suoyouSPArray;//所有商品数组
//商家主页需要的属性===============
@end
