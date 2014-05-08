//
//  SellersDetailViewController.m
//  越野e族
//
//  Created by gaomeng on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//
#import "bbsdetailViewController.h"
#import "SellersDetailViewController.h"
#import "BtnF4.h"
#import "SellerGoodsView.h"
#import "BBSViewController.h"
#import "ProductDetailViewController.h"



@interface SellersDetailViewController ()
{
    SellerGoodsView * slideSellerGoodsView;//分类view
}

@end

@implementation SellersDetailViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //商家实例
    SellersModel * sellerModel = [[SellersModel alloc]init];
    
    //设置商家实例属性
    self.sellerModel = sellerModel;
    
    //准备网络数据
    self.sellerId = @"99899";
    sellerModel.sellerId = self.sellerId;//点击论坛按钮跳转需要商家id
    
    [self prepareData];
    
    
    
    
    
    //实例化商家详细页view
    SellersDetailView *sellersDetailView = [SellersDetailView shareView];
    sellersDetailView.delegate = self;
    
    
    
    //布局界面view
    [sellersDetailView configView];
    
    //收键盘 滑动分类tableview
    
    UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightBtn2)];
    pan.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(rightBtn2)];
    
    UIControl *control = [[UIControl alloc]initWithFrame:sellersDetailView.frame];
    [control addGestureRecognizer:pan];
    [control addGestureRecognizer:lp];
    
    [control addSubview:sellersDetailView];
    [self.view addSubview:control];
    
    
    
    
    
    
    //添加view到controller
    //[self.view addSubview:sellersDetailView];
    
    
    //把v设置成属性
    self.sellerDtV = sellersDetailView;
    
    
    //设置商家论坛跳转block

   // __weak typeof(detal_bbsVC) _weakBbsVC=detal_bbsVC;
    #pragma mark 在这些跳转商家论坛的block
    [sellersDetailView setPushBbsBlock:^(int num) {
        bbsdetailViewController *detal_bbsVC=[[bbsdetailViewController alloc]init];

        
        detal_bbsVC.bbsdetail_tid=[NSString stringWithFormat:@"%d",num];
        
        [self.navigationController pushViewController:detal_bbsVC animated:YES];
        
        //num为商家id
        NSLog(@"在SellersDetailViewController中跳转商家id:%d",num);
    }];
    
    
    //test
    
    UIView *aview;
    aview.tag=10;
    
    //设置navigation
    [self navigationbar];
    
    
}





#pragma mark - myMethod
-(void)prepareData{
    //商家id 99899
    
    //请求地址
    //商家信息 http://malltest.fblife.com/api.php?app=store&id=%@&formattype=json
    //推荐商品 http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=1&formattype=json
    //新品  http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=2&formattype=json&formattype=json
    //所有商品 http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&formattype=json
    //右出分类 http://mall.fblife.com/api.php?app=store&id=%@&formattype=json
    
    
    //商家信息
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=store&id=%@&formattype=json",self.sellerId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *detainfo = [dic objectForKey:@"datainfo"];
            
            //logo
            self.sellerModel.logoUrl = [detainfo objectForKey:@"store_logo"];
            
            //商家名称
            self.sellerModel.sellerName = [detainfo objectForKey:@"store_name"];
            NSLog(@"%@",self.sellerModel.sellerName);
            
            //顶部横条图
            self.sellerModel.topImgeUrl = [detainfo objectForKey:@"store_banner"];
            NSLog(@"self.sellerModel.topImgeUrl = %@",self.sellerModel.topImgeUrl);
            
            //星级
            self.sellerModel.starsUrl = [detainfo objectForKey:@"store_star"];
            NSLog(@"self.sellerModel.starsUrl = %@",self.sellerModel.starsUrl);
            
            
            //电话
            self.sellerModel.phoneNum = [detainfo objectForKey:@"tel"];
            NSLog(@"%@",self.sellerModel.phoneNum);
            
            
            //商家店铺简介
            self.sellerModel.webViewStr = [NSString stringWithFormat:@"<body style=\"background-color: transparent\">%@",[detainfo objectForKey:@"description"]];
            NSLog(@"%@",self.sellerModel.webViewStr);
        }
        
        
        

        
        
        
        //拿到v的单例
        SellersDetailView *v = [SellersDetailView shareView];
        
        //重载数据;
        [v reloadTopSellerView];
        [v reloadTableViewData];
        
        
    }];
    
    
    
    
    //推荐商品
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=1&formattype=json",self.sellerId]];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            //商品数组
            NSMutableArray *spArray = (NSMutableArray*)[dic objectForKey:@"datainfo"];
            
            //给model的推荐商品数组赋值
            self.sellerModel.tuijianSPArray = spArray;
        }
        
        
        //拿到v的单例
        SellersDetailView *v = [SellersDetailView shareView];
        
        //重载v里的tableview
        [v reloadTableViewData];
        
    }];
    
    //新品
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=2&formattype=json&formattype=json",self.sellerId]];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (!connectionError){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            
            //商品数组
            NSMutableArray *spArray = (NSMutableArray*)[dic objectForKey:@"datainfo"];
            
            //给model的推荐商品数组赋值
            self.sellerModel.xinpinArray = spArray;
        }
        
        //拿到v的单例
        SellersDetailView *v = [SellersDetailView shareView];
        
        //重载v里的tableview
        [v reloadTableViewData];
        
    }];
    
    
    //所有商品
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&formattype=json",self.sellerId]];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:url3];
    [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //商品字典
            NSMutableArray *spArray = (NSMutableArray*)[dic objectForKey:@"datainfo"];
            
            //给model的推荐商品数组赋值
            self.sellerModel.suoyouSPArray = spArray;
        }
        
        //拿到v的单例
        SellersDetailView *v = [SellersDetailView shareView];
        
        //重载v里的tableview
        [v reloadTableViewData];
        
    }];
    
    
    //右出分类
    NSURL *url4 = [NSURL URLWithString:[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=store&id=%@&formattype=json",self.sellerId]];
    NSURLRequest *request4 = [NSURLRequest requestWithURL:url4];
    [NSURLConnection sendAsynchronousRequest:request4 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *datainfoDic = [dic objectForKey:@"datainfo"];
            NSArray *store_gcatesArray = [datainfoDic objectForKey:@"store_gcates"];
            
            self.sectionTitleArray = [NSMutableArray arrayWithCapacity:1];
            self.childrensArray = [NSMutableArray arrayWithCapacity:1];
            for (NSDictionary *dic in store_gcatesArray) {
                [self.sectionTitleArray addObject:[dic objectForKey:@"value"]];
                NSLog(@"%@",[dic objectForKey:@"children"]);
                
                if ([dic objectForKey:@"children"]== NULL) {
                    [self.childrensArray addObject:[NSNull null]];
                }else{
                    [self.childrensArray addObject:[dic objectForKey:@"children"]];
                }
                
            }
            
        }
    }];
    
    
    
}


-(void)navigationbar{
    //星星
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"collect-1_42x387.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtn1)];
    
    //更多
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"MallLeft40_32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtn2)];
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypeNull];
    self.navigationItem.rightBarButtonItems = @[right2,right1];
}


-(void)rightBtn1{
    //星星
}

-(void)rightBtn2{
    NSLog(@"%s",__FUNCTION__);
    
    //分类
    if (!slideSellerGoodsView)
    {
        slideSellerGoodsView = [[SellerGoodsView alloc]init];
        slideSellerGoodsView.frame = CGRectMake(320,20,557/2,568);
        [[UIApplication sharedApplication].keyWindow addSubview:slideSellerGoodsView];
    }
    
    
    [slideSellerGoodsView loadViewWithContent:self.childrensArray NameArray:self.sectionTitleArray];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        BOOL isShow = slideSellerGoodsView.frame.origin.x==320;
        
        slideSellerGoodsView.frame = CGRectMake(isShow?320-557/2:320,20,557/2,568);
        CGRect rect = self.navigationController.view.frame;
        rect.origin.x = isShow?-557/2:0;
        self.navigationController.view.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
    [slideSellerGoodsView setCellClickedBlock:^(NSString* classId){
        NSLog(@"在SellersDetailViewController.m中设置跳转 id为:%@",classId);
    }];
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
