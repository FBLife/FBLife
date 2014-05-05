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
#import "SellerInfo.h"
#import "DetailRecommendGoodsView.h"
#import "LoadingIndicatorView.h"
#import "MyChatViewController.h"
#import "MessageInfo.h"
#import "SMPageControl.h"

@class SellerInfoView;

@interface ProductDetailViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LoopScrollviewDelegate,UIWebViewDelegate,DetailRecommendGoodsViewDelegate,SellerInfoViewDelegate>
{
    UIView * tableHeaderView;
    
    ProductCellType theType;
    
    float postionState[4];
    
    UIView * aView;
    
    NSMutableArray * productComments_array;
    
    NSMutableDictionary * recommendGoods_dictionary;
    
    LoadingIndicatorView * loadMoreView;
    
    ASIHTTPRequest * productDetail_request;
    
    ASIHTTPRequest * productComments_request;
    
    int CommentsPageCount;
    
    SMPageControl * _pageControl;
}


@property(nonatomic,strong)UITableView * myTableView;

@property(nonatomic,strong)NSMutableArray * slide_array;//幻灯数据

@property(nonatomic,strong)ProductModel * ProductInfo;

@property(nonatomic,strong)SellerInfo * SellerInfo;

@property(nonatomic,strong)NSString * GoodsId;





@end
