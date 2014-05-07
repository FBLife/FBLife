//
//  MallTypeClassifyViewController.h
//  越野e族
//
//  Created by soulnear on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//商品分类

#import <UIKit/UIKit.h>
#import "SellerGoodsView.h"
#import "DetailClassifyModel.h"

@interface ClassifyPopView :UIView
{
    
}


-(void)setAllViewsWithContent:(NSArray *)theContent;


@end




@interface MallTypeClassifyViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,SellerGoodsViewDelegate>
{
    int identifierHidden[255];
    
    int history_index;
}


@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)DetailClassifyModel * theModel;

@property(nonatomic,strong)NSMutableArray * data_array;


@end
