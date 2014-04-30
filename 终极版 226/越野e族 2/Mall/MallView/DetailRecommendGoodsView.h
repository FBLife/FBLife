//
//  DetailRecommendGoodsView.h
//  越野e族
//
//  Created by soulnear on 14-4-25.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewController.h"
#import "SellerInfo.h"


@protocol DetailRecommendGoodsViewDelegate <NSObject>

-(void)ClickToProductDetailsWith:(SellerInfo *)info;

@end


@interface DetailRecommendGoodsView : UIView
{
    NSMutableArray * temp_array;
}

@property(nonatomic,assign)id<DetailRecommendGoodsViewDelegate>delegate;

-(void)loadViewWithDataArray:(NSArray *)dataArray;

@end
