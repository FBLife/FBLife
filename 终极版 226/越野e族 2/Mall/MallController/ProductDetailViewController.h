//
//  ProductDetailViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoopScrollview.h"
#import "ProductModel.h"
#import "ProductCustomCell.h"


@interface ProductDetailViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LoopScrollviewDelegate>
{
    UIView * tableHeaderView;
    
    ProductCellType theType;
    
    float postionState[4];
}


@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)NSMutableArray * slide_array;//幻灯数据

@property(nonatomic,strong)ProductModel * ProductInfo;

@end
