//
//  SellersDetailView.m
//  越野e族
//
//  Created by gaomeng on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SellersDetailView.h"
#import "CustomShangpinCell.h"
#import "BtnF4.h"
#import "SellersDetailViewController.h"
#import "BBSViewController.h"
#import "MoreSPViewController.h"


@implementation SellersDetailView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//单例
+(id)shareView{
    static SellersDetailView *view = nil;
    if (view) {
        view.frame = CGRectMake(0, 0, 320, 568);
        return view;
        
    }
    view = [[SellersDetailView alloc]init];
    view.frame = CGRectMake(0, 0, 320, 568);
    
    return view;
}



-(void)classBtnClicked:(UIButton*)sender{
    NSLog(@"%d",sender.tag);
    
    switch (sender.tag) {
        case 50://首页
        {
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.frame = CGRectMake(0, 0, 320, 568-44);
            } completion:^(BOOL finished) {
                //设置tableview的frame
                _tableview.frame = shouyeTableivewFrame;
            }];
            
            
            
            
            
            _tableview.scrollEnabled=YES;
            
            
            btnClicked = 50;
            
            
            //隐藏对应的pointImageView
            UIImageView *p1 = self.pointImageArray[0];
            p1.hidden = NO;
            UIImageView *p2 = self.pointImageArray[1];
            p2.hidden = YES;
            
            [_tableview reloadData];
            
        }
            break;
        case 51://简介
        {
            
            [_searchTf resignFirstResponder];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.frame = CGRectMake(0, -44, 320, 568-44);
            } completion:^(BOOL finished) {
                //设置tableview的frame
                _tableview.frame = jianjieTableviewFrame;
            }];
            
            
            
            
            
            
            _tableview.scrollEnabled=NO;
            
            //隐藏对应的pointImageView
            UIImageView *p1 = self.pointImageArray[0];
            p1.hidden = YES;
            UIImageView *p2 = self.pointImageArray[1];
            p2.hidden = NO;
            
            btnClicked = 51;
            
            
            [_tableview reloadData];
            
        }
            break;
        case 52://电话
        {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:self.delegate.sellerModel.sellerName message:self.delegate.sellerModel.phoneNum delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
            UIAlertView *alertV1 = [[UIAlertView alloc]initWithTitle:self.delegate.sellerModel.sellerName message:@"暂无号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            
            if (self.delegate.sellerModel.phoneNum) {
                [alertView show];
            }else{
                [alertV1 show];
            }
            
            
            btnClicked = 50;
            
        }
            break;
        case 53://论坛
        {
            if (self.pushBbsBlock) {
                self.pushBbsBlock([self.delegate.sellerModel.sellerId integerValue]);
            }
            
            btnClicked = 50;
            
        }
            break;
            
        default:
            break;
    }
    
    
}






#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sectionNum = 0;
    switch (btnClicked) {
        case 50:
            sectionNum = 5;
            return sectionNum;
            break;
        case 51:
            sectionNum = 2;
            return sectionNum;
            break;
            
        default:
            break;
    }
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger CellNumber = 0;
    
    switch (btnClicked) {
        case 50:{
            switch (section) {
                case 0://商家信息view :self.topSellerView
                    CellNumber = 1;
                    return CellNumber;
                    break;
                case 1://滚动图片scrollView
                    CellNumber = 1;
                    return CellNumber;
                    break;
                case 2://推荐商品
                    CellNumber =2;
                    return CellNumber;
                    break;
                case 3://新品
                    CellNumber = 2;
                    return CellNumber;
                    break;
                case 4://所有商品
                    CellNumber = 2;
                    return CellNumber;
                    break;
                default:
                    break;
            }
        }
            break;
        case 51:
            switch (section) {
                case 0://商品信息view
                    CellNumber = 1;
                    return CellNumber;
                    break;
                case 1://商品简介 webView
                    CellNumber = 1;
                    return CellNumber;
                default:
                    break;
            }
            
        default:
            break;
    }
    
    return CellNumber;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = nil;
    if (btnClicked == 50) {
        switch (section) {
            case 0:
                str = @"商家信息view";
                return str;
                break;
            case 1:
                str = @"滚动视图";
                return str;
                break;
            case 2:
                str = @"推荐商品";
                return str;
                break;
            case 3:
                str = @"新品";
                return str;
                break;
            case 4:
                str = @"所有商品";
                return str;
                break;
                
            default:
                break;
        }
    }
    
    
    if (btnClicked == 51) {
        switch (section) {
            case 0:
                str = @"商家信息view";
                return str;
                break;
            case 1:
                str = @"店铺简介webview";
                return str;
                break;
                
                
            default:
                break;
        }
    }
    
    return str;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//单元格点击不高亮
    }
    
    
    switch (btnClicked) {
        case 50://商家首页
        {
            
            for (UIView *im in cell.contentView.subviews) {
                [im removeFromSuperview];
            }
            if (indexPath.section == 0 && indexPath.row == 0) {//商家信息view
                
                //添加视图
                [cell.contentView addSubview:self.topSellerView];
            }else if (indexPath.section == 1 && indexPath.row ==0){//滚动视图幻灯片
                    #pragma mark - 幻灯片视图在这里写
                
                
                
                
            }else{//商品信息view//CustomShangpinCell
                static NSString *shangpin = @"shangpin";
                CustomShangpinCell *cell1 = [tableView dequeueReusableCellWithIdentifier:shangpin];
                if (!cell1) {
                    cell1 = [[CustomShangpinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shangpin];
                }
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;//单元格点击不高亮
                cell1.contentView.backgroundColor = backGray;
                
                if (indexPath.section == 2) {
                    [cell1 cleanData];//单元格重用的时候清空数据
                    [cell1 configWithArray:self.delegate.sellerModel.tuijianSPArray indexPath:indexPath];
                }else if (indexPath.section == 3){
                    [cell1 cleanData];
                    [cell1 configWithArray:self.delegate.sellerModel.xinpinArray indexPath:indexPath];
                }else if (indexPath.section == 4){
                    [cell1 cleanData];
                    [cell1 configWithArray:self.delegate.sellerModel.suoyouSPArray indexPath:indexPath];
                }
                
                #pragma mark 这里写点击具体商品需要跳转的页面
                //设置具体点击商品跳转代码块
                [cell1 setSpChooseBlock:^(int tag) {
                    //tag是商品id  self.delegate是VC:SellersDetailViewController
                    NSLog(@"在SellersDetailView中跳转具体商品页面 商品id = %d",tag);
                   
                    
                    
                }];
                
                return cell1;
            }
            
        }
            break;
            
        case 51://店铺简介
        {
            _webView.hidden = NO;
            for (UIView *im in cell.contentView.subviews) {
                [im removeFromSuperview];
            }
            if (indexPath.section == 0 && indexPath.row == 0) {//商家信息view
                
                //添加视图
                [cell.contentView addSubview:self.topSellerView];
            }else if (indexPath.section == 1 && indexPath.row == 0){//店铺简介webview
               
                NSLog(@"添加webview");
                
                [cell.contentView addSubview:_webView];
                
                
                
                
                
                
                NSLog(@"xx=%@",self.delegate.sellerModel.webViewStr);
                [_webView loadHTMLString:self.delegate.sellerModel.webViewStr baseURL:nil];
                
                
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section = %d,row = %d",indexPath.section,indexPath.row);
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heightForHeader = 0;
    
    switch (btnClicked) {
        case 50:{//商家首页
            switch (section) {
                case 0://商家信息view
                    heightForHeader = 0;
                    return heightForHeader;
                    break;
                case 1://scrollview
                    heightForHeader = 0;
                    return heightForHeader;
                    
                default://自定义单元格
                    heightForHeader = 32;
                    if (section == 2) {
                        heightForHeader = 32;
                    }
                    return heightForHeader;
                    
                    break;
            }
        }
            break;
        case 51:{//店铺简介
            switch (section) {
                case 0:
                    heightForHeader = 0;
                    return heightForHeader;
                    break;
                case 1:
                    heightForHeader = 0;
                    return heightForHeader;
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    return heightForHeader;;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float rowHeight = 0;
    switch (btnClicked) {
        case 50:
        {
            if (indexPath.row==0 && indexPath.section == 0) {
                rowHeight = 132;//商家信息view
                return rowHeight;
            }else if (indexPath.row ==0 && indexPath.section == 1){
                rowHeight = 170;//scrollView
                return rowHeight;
            }else{
                rowHeight = 228;//商品view
                return rowHeight;
            }
        }
            break;
            
        case 51:
        {
            if (indexPath.row == 0 && indexPath.section == 0) {
                rowHeight = 132;//商家信息view
            }else if(indexPath.row ==0 && indexPath.section ==1){
                
                
                rowHeight = 375;//店铺简介webview
            }
        }
            break;
            
        default:
            break;
    }
    return rowHeight;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //标题
    NSString *titile = [[NSString alloc]init];
    switch (section) {
        case 2:
            titile = @"推荐商品";
            break;
        case 3:
            titile = @"新品";
            break;
        case 4:
            titile = @"所有商品";
            break;
            
        default:
            break;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 22)];
//    if (section == 2) {
//        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 22)];
//    }
    titleLabel.text = titile;
    
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.tag = 10+section;
    [btn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    #pragma mark 在这里写点击更多按钮需要跳转的页面
//    //设置更多按钮的跳转
//    
//    UIViewController *VC=(UIViewController *)self.delegate;
//    __weak typeof(VC) __weakVC = VC;
//     
//        
//    _moreSp=[[MoreSPViewController alloc]init];
//    __weak typeof(_moreSp) _weakmoresp=_moreSp;
//    
//    __block NSString *sellernum = self.delegate.sellerModel.sellerId;//属性传值 商家id
//    
//        
//    [self setMoreBtnBlock:^(int section) {
//        
//        //section : 推荐商品2  新品3 所有商品4
//        //sel.navigation是VC：SellersDetailViewController
//        NSLog(@"在SellersDetailView中设置点击更多按钮时跳转的页面 section = %d",section);
//        
//        _weakmoresp.sellerID = [NSString stringWithFormat:@"%@",sellernum];
//        _weakmoresp.spFenlei = section-1;
//        
//        [__weakVC.navigationController pushViewController:_weakmoresp animated:YES];
//        
//    }];
    
    
    
    
    
    
    
    btn.frame = CGRectMake(284, CGRectGetMinY(titleLabel.frame)-5, 30, 30);
    
    //整个view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 32)];
    [view addSubview:titleLabel];
    [view addSubview:btn];
    view.backgroundColor = backGray;
    
    
    
    return view;
    
}

#pragma mark - moreBtnClicked
-(void)moreBtnClicked:(UIButton *)sender{
//    if (self.moreBtnBlock) {
//        self.moreBtnBlock(sender.tag-10);
//    }
    
    #pragma mark - 在此处这是更多按钮点击需要跳转的页面
    _moreSp = [[MoreSPViewController alloc]init];
    _moreSp.sellerID = self.delegate.sellerModel.sellerId;
    _moreSp.spFenlei = sender.tag-10-1;
    
    [self.delegate.navigationController pushViewController:_moreSp animated:YES];
    
    
    
    
}



#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_searchTf resignFirstResponder];
    self.userSearString = textField.text;
    NSLog(@"self.userSearString = %@",self.userSearString);
    return YES;
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0) {
        NSLog(@"取消");
    }else if (buttonIndex == 1){
        #pragma mark - 设置拨打电话
        NSLog(@"在sellersDetailView里设置 拨打电话");
    }
}




#pragma mark - myMethod

-(void)setSpvBlock:(SpvBlock)spvBlock{
    _spvBlock = spvBlock;
}

-(void)setMoreBtnBlock:(MoreBtnBlock)moreBtnBlock{
    _moreBtnBlock = moreBtnBlock;
    
}

//重载主tableview数据
-(void)reloadTableViewData{
    [_tableview reloadData];
}

//重载topsellerView
-(void)reloadTopSellerView{
    [self.topImageV loadImageFromURL:self.delegate.sellerModel.topImgeUrl withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    [self.logoImageV loadImageFromURL:self.delegate.sellerModel.logoUrl withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    int starCount = [self.delegate.sellerModel.starsUrl intValue];
    for (int i = 0; i<starCount; i++) {
        UIImageView *starImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redxing_17x16@2x.png"]];
        [self.starArray addObject:starImageV];
    }
    
    //星星view
    int StarsCount = self.starArray.count>5?5:self.starArray.count;//最多5星
    for (int i = 0; i<StarsCount; i++) {
        UIImageView *imv = self.starArray[i];
        imv.frame = CGRectMake(i*11.8,0, 8, 8);
        [self.starsV addSubview:imv];
    }
    
    [self.topSellerView addSubview:self.topImageV];
    [self.topSellerView addSubview:self.logoImageV];
    [self.topSellerView addSubview:self.starsV];
    [self addSubview:self.topSellerView];
}


//布局整个view
-(void)configView{
    
    btnClicked = 50;
    
    //分配内存
    self.topImageV = [[AsyncImageView alloc]init];
    self.logoImageV = [[AsyncImageView alloc]init];
    self.starsV = [[UIView alloc]init];
    self.starArray = [[NSMutableArray alloc]init];
    self.classBtnArray = [NSMutableArray arrayWithCapacity:0];
    self.pointImageArray = [NSMutableArray arrayWithCapacity:0];
    self.backgroundImageVforBtn = [[UIImageView alloc]init];
    self.topSearchView = [[UIView alloc]init];
    self.topSellerView = [[UIView alloc]init];
    _imageScrollView = [[UIScrollView alloc]init];
    _searchTf = [[UITextField alloc]init];
    _searchTf.placeholder = @"请输入要搜索的商品";
    _webView = [[UIWebView alloc]init];
    
    
    
    
    //设置网络图片
    [self.topImageV loadImageFromURL:self.delegate.sellerModel.topImgeUrl withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    [self.logoImageV loadImageFromURL:self.delegate.sellerModel.logoUrl withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    
    //设置星星view(网络加本地)
    int starCount = [self.delegate.sellerModel.starsUrl intValue];
    for (int i = 0; i<starCount; i++) {
        UIImageView *starImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redxing_17x16@2x.png"]];
        [self.starArray addObject:starImageV];
    }
    
    
    //设置本地图片
    //btn
    BtnF4 *btnF4 = [BtnF4 shareBtnF4];
    
    for (UIButton *btn in btnF4.btnF4Array) {
        [self.classBtnArray addObject:btn];
    }
    
    //pointArray
    NSArray *pointImageArray = @[[UIImage imageNamed:@"yijiantou_640x14.png"],[UIImage imageNamed:@"erjiantou_640x14.png"]];
    for (int i = 0; i<2; i++) {
        UIImageView *imV = [[UIImageView alloc]initWithImage:pointImageArray[i]];
        //设置pointImageView的tag
        imV.tag = 54+i;
        [self.pointImageArray addObject:imV];
    }
    
    //backBtnImage
    self.backgroundImageVforBtn.backgroundColor = [UIColor whiteColor];
    
    
    //===================调整位置===================
    
    
    //顶部搜索栏
    //框
    UIImageView *kuangImv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ZMallsearch-kuang_592x56.png"]];
    kuangImv.center=CGPointMake(160, 22);
    //放大镜
    UIImageView *fangdajing=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ZMallsearch_26x26.png"]];
    fangdajing.center=CGPointMake(85, 22);
    //搜索条
    _searchTf=[[UITextField alloc]initWithFrame:CGRectMake(98, 14, 180, 16)];
    _searchTf.backgroundColor=[UIColor clearColor];
    _searchTf.font=[UIFont systemFontOfSize:14];
    _searchTf.placeholder=@"请输入要搜索的商品";
    _searchTf.delegate=self;
    _searchTf.returnKeyType=UIReturnKeySearch;
    //添加视图
    [self.topSearchView addSubview:kuangImv];
    [self.topSearchView addSubview:fangdajing];
    [self.topSearchView addSubview:_searchTf];
    
    self.topSearchView.frame = CGRectMake(0, 0, 320, 44);
    _searchTf.delegate = self;
    _searchTf.returnKeyType = UIReturnKeySearch;

    
    
    //搜索栏下面的商家信息view================
    self.topImageV.frame = CGRectMake(0, 0, 320, 70);
    self.backgroundImageVforBtn.frame = CGRectMake(0, CGRectGetMaxY(self.topImageV.frame), 320, 50);
    self.logoImageV.frame = CGRectMake(CGRectGetMinX(self.topImageV.frame)+10, CGRectGetMaxY(self.topImageV.frame)-25, 55, 55);
    self.starsV.frame = CGRectMake(CGRectGetMinX(self.logoImageV.frame), CGRectGetMaxY(self.logoImageV.frame)+5, self.logoImageV.frame.size.width, CGRectGetMaxY(self.backgroundImageVforBtn.frame)-10-CGRectGetMaxY(self.logoImageV.frame));
    //星星view
    int StarsCount = self.starArray.count>5?5:self.starArray.count;//最多5星
    for (int i = 0; i<StarsCount; i++) {
        UIImageView *imv = self.starArray[i];
        imv.frame = CGRectMake(i*14,0, 10, 10);
        [self.starsV addSubview:imv];
    }
    [self.topSellerView addSubview:self.starsV];
    
    
    //箭头imageview
    for (UIImageView *pointImagV in self.pointImageArray) {
        pointImagV.frame = CGRectMake(0, 120, 320, 7);
    }
    
    //添加控件
    [self.topSellerView addSubview:self.topImageV];
    [self.topSellerView addSubview:self.backgroundImageVforBtn];
    [self.topSellerView addSubview:self.logoImageV];
    [self.topSellerView addSubview:self.starsV];
    [self.topSellerView addSubview:self.pointImageArray[0]];
    [self.topSellerView addSubview:self.pointImageArray[1]];
    if (btnClicked == 50) {
        UIImageView *pi = self.pointImageArray[1];
        pi.hidden = YES;
    }
    
    
    
    //4个btn
    for (int i = 0; i<4; i++) {
        UIButton *btn = self.classBtnArray[i];
        //设置btn的坐标和间隔//间隔5 宽度45
        btn.frame = CGRectMake(CGRectGetMaxX(self.logoImageV.frame)+23+i*55+i*5, CGRectGetMinY(self.backgroundImageVforBtn.frame), 45, 50);
        //间隔竖条
        if (i<3) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+5, CGRectGetMinY(self.backgroundImageVforBtn.frame)+15, 1, 25)];
            view.backgroundColor = RGBCOLOR(222, 222, 222);
            [self.topSellerView addSubview:view];
        }
        btn.tag = 50+i;
        [btn addTarget:self action:@selector(classBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.topSellerView addSubview:btn];
    }
    
    //设置frame
    self.topSellerView.frame = CGRectMake(0, 0, 320, CGRectGetMaxY(self.backgroundImageVforBtn.frame)+12);//132
    self.topSellerView.backgroundColor = backGray;
    
    //商家信息view====================================
    
    
    
    
    //商家信息view下面的tableview
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSearchView.frame), 320, 568-64-45) style:UITableViewStylePlain];
    _tableviewFrame = _tableview.frame;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];//设置cell分割线
    
    
    //添加控件
    [self addSubview:self.topSearchView];
    [self addSubview:_tableview];
    
    
    
    //webView
    //创建UIWebView
    _webView.frame = CGRectMake(0,0, 320, 375);
    _webView.userInteractionEnabled = YES;
    _webView.backgroundColor = backGray;
    _webView.delegate = self;
    
    _webView.opaque = NO;
    
    
}


@end
