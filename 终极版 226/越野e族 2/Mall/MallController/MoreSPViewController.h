//
//  MoreSPViewController.h
//  越野e族
//
//  Created by gaomeng on 14-5-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingIndicatorView.h"

#define backGray (RGBCOLOR(236, 236, 236))

@interface MoreSPViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,CustomSegmentViewDelegate>
{
    
    
    NSMutableArray *_spArray;//默认商品数组
    
    
    UITableView *_tableview;//主tableview
    NSString *_headerTitle;//商品分类
    NSInteger _count;//请求到的商品总数
    
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;//刷新的view
    BOOL _reloading;
    int _segmentChoose;
    LoadingIndicatorView *_upMoreView;//上提加载更多
    int _page;//上拉加载时的页码
    BOOL _isUpMore;//是否为上提加载更多
    BOOL _isUpMoreSuccess;//上提加载成功
    
    
    NSString *sortstring;//类别切换
    
    BOOL _priceClicked;//价格升序或降序
    
    
}

@property(nonatomic,assign)int spFenlei;//推荐商品2 新品3 全部商品4
@property(nonatomic,strong)NSString *sellerID;//商家id
@property(nonatomic,strong) UISegmentedControl *mySegmentedControl;//segmentedcontrol






@end
