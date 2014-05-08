//
//  SellersDetailView.h
//  越野e族
//
//  Created by gaomeng on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//
#import "MoreSPViewController.h"
#import <UIKit/UIKit.h>
#import "SellersModel.h"
@class SellersDetailViewController;

#define backGray (RGBCOLOR(236, 236, 236))
#define shouyeTableivewFrame (CGRectMake(0, 44, 320, 568-64-45))
#define jianjieTableviewFrame (CGRectMake(0, 44, 320, 504))

typedef void (^PushBbsBlock)(int num);//bbs按钮
typedef void (^MoreBtnBlock)(int section);//商品section上更多按钮
typedef void (^SpvBlock)(int tag);//点击的具体商品



@interface SellersDetailView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIWebViewDelegate>
{
    UIScrollView *_imageScrollView;//滚动视图
    UITableView *_tableview;//主tableview
    UITextField *_searchTf;//搜索tf
    UIWebView *_webView;//店铺简介
    int btnClicked;
    CGRect _tableviewFrame;//tableview大小
}
@property(nonatomic,strong)UIView *topSearchView;//顶部搜索条
@property(nonatomic,strong)NSString *userSearString;//用户搜索关键字


@property(nonatomic,strong)UIView *topSellerView;//商家信息view // tag:1000
@property(nonatomic,strong)AsyncImageView *topImageV;//商家topView
@property(nonatomic,strong)AsyncImageView *logoImageV;//商家logo
@property(nonatomic,strong)UIView *starsV;//星星view
@property(nonatomic,strong)NSMutableArray *starArray;//星星数组 里面装imageview
@property(nonatomic,strong)NSMutableArray *classBtnArray;//分类按钮数组 //tag:50 51 52 53
@property(nonatomic,strong)UIImageView *backgroundImageVforBtn;//分类按钮下图片
@property(nonatomic,strong)NSMutableArray *pointImageArray;//箭头图片数组 //tag:54 55






//代理
@property(nonatomic,assign)SellersDetailViewController *delegate;//把vc设置为delegate 数据源为self.delegate.sellerModel

//block
@property(nonatomic,strong)PushBbsBlock pushBbsBlock;//跳转商家论坛
@property(nonatomic,strong)MoreBtnBlock moreBtnBlock;//跳转更多
@property(nonatomic,strong)SpvBlock spvBlock;//跳转具体商品

//设置block
-(void)setPushBbsBlock:(PushBbsBlock)pushBbsBlock;//跳转论坛页面block
-(void)setMoreBtnBlock:(MoreBtnBlock)moreBtnBlock;//根据section 跳转更多商品界面 推荐商品section=2 新品section=3 全部商品section=3

//-(void)setSpvBlock:(SpvBlock)spvBlock;



//单例
+(id)shareView;



//使用一个sellersModel对象初始化商城商家首页
-(void)configView;


//刷新数据
-(void)reloadTableViewData;//整个tableview

-(void)reloadTopSellerView;//商家topview


@property(nonatomic,strong)MoreSPViewController *moreSp;


@end
