//
//  SellersDetailViewController.h
//  越野e族
//
//  Created by gaomeng on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MyViewController.h"
#import "SellersModel.h"
#import "CustomShangpinCell.h"
#import "SellersDetailView.h"


@interface SellersDetailViewController : MyViewController<NSURLConnectionDataDelegate>

@property(nonatomic,strong)SellersModel *sellerModel;//商家实例
@property(nonatomic,strong)NSString *sellerId;//上个页面传过来的商家id
@property(nonatomic,strong)SellersDetailView *sellerDtV;//页面

//右出分类
@property(nonatomic,strong)NSMutableArray *sectionTitleArray;//里面装的是字符串 section标题
@property(nonatomic,strong)NSMutableArray *childrensArray;//里面装的是array array里面是dic


@end
