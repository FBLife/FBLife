//
//  ProductDetailViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "rtLabel.h"

@class RTLabelComponent;
@class RTLabelExtractedComponent;



#define TEXTCLOLOR [UIColor colorWithRed:115/255.0f green:115/255.0f blue:115/255.0f alpha:1];

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize myTableView = _myTableView;
@synthesize slide_array = _slide_array;
@synthesize ProductInfo = _ProductInfo;
@synthesize SellerInfo = _SellerInfo;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



-(void)loadProductDetailInfo
{
    NSString * full_url = [NSString stringWithFormat:MALLPRODUCTDETAIL_URL,@"8680"];
    
    
    productDetail_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:full_url]];
    
    productDetail_request.delegate = self;
    
    __weak ASIHTTPRequest * request = productDetail_request;
    
    __weak typeof(self) _weakself=self;
    
    [productDetail_request setCompletionBlock:^{
        
        NSDictionary * totalDictionary = [request.responseData objectFromJSONData];
        
        NSString * errcode = [totalDictionary objectForKey:@"errcode"];
        
        NSLog(@"totalDictionary ------    %@",totalDictionary);
        
        if ([errcode intValue] == 0)
        {
            NSDictionary * data_dictionary = [totalDictionary objectForKey:@"datainfo"];
    
            _weakself.ProductInfo = [[ProductModel alloc] initWithDictionary:data_dictionary];
            
            UIWebView * theWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-35.5-44-(MY_MACRO_NAME?20:0))];
            
            theWebView.delegate = _weakself;
            
            theWebView.hidden = YES;
            
            theWebView.userInteractionEnabled = NO;
            
            [theWebView loadHTMLString:_weakself.ProductInfo.PDetails baseURL:[[NSBundle mainBundle] resourceURL]];
            
            [_weakself.view addSubview:theWebView];
            
        }
        
        [_weakself loadSlideViewAndContentView];
        
        [_weakself loadTableHeaderViewTwo];
    }];
    
    [productDetail_request setFailedBlock:^{
        
    }];
    

    [productDetail_request startAsynchronous];
}


-(void)loadProductCommentsData
{
    if (productComments_request && CommentsPageCount==1) {
        return;
    }
    
    
    [loadMoreView startLoading];
    
    NSString * fullUrl = [NSString stringWithFormat:MALLPRODUCTDCOMMENTS_URL,@"8680",CommentsPageCount];
    
    NSLog(@"fullUrl------%@",fullUrl);
    productComments_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    productComments_request.delegate = self;
    
    __weak ASIHTTPRequest * request = productComments_request;
    
    [request setCompletionBlock:^{
        
        __weak typeof(self) bself = self;
        
        [loadMoreView stopLoading:1];
        
        @try {
            NSDictionary * totalDictionary = [productComments_request.responseData objectFromJSONData];
            
            NSLog(@"评论数据 ----  %@",totalDictionary);
            
            NSString * errcode = [totalDictionary objectForKey:@"errcode"];
            
            if ([errcode intValue] == 0) {
                
                NSDictionary * dataDictionary = [totalDictionary objectForKey:@"datainfo"];
                
                NSArray * commentsArray = [dataDictionary objectForKey:@"comments"];
                
                for (NSDictionary * dic in commentsArray) {
                    ProductModel * model = [[ProductModel alloc] initWithDictionary:dic];
                    [productComments_array addObject:model];
                }
                
                
                [bself.myTableView reloadData];
            }else
            {
                loadMoreView.normalLabel.text = @"没有更多了";
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    [productComments_request startAsynchronous];
}


-(void)loadSellerInfomationAndRecommendGoods
{
    __weak typeof(self) bself = self;
    
    if(![recommendGoods_dictionary objectForKey:@"sellerDescription"])
    {
        NSString * sellerInfo_url = [NSString stringWithFormat:MALLSELLERINFO_URL,@"99899"];
        
        _SellerInfo = [[SellerInfo alloc] init];
        
        [bself.SellerInfo loadInfomationWithUrl:sellerInfo_url WithBlock:^(SellerInfo *theInfo) {
            
            bself.SellerInfo = theInfo;
            
            SellerInfoView * sellerView = [[SellerInfoView alloc] initWithFrame:CGRectMake(0,0,320,93)];
            
            [sellerView SellerInfoViewData:bself.SellerInfo];
            
            [recommendGoods_dictionary setObject:sellerView forKey:@"sellerInfo"];
            
            if (bself.SellerInfo.SDescription.length !=0 && ![bself.SellerInfo.SDescription isEqualToString:@""]) {
                [recommendGoods_dictionary setObject:bself.SellerInfo.SDescription forKey:@"sellerDescription"];
            }
            
            [_myTableView reloadData];
        }];
    }
    
    
    if(![recommendGoods_dictionary objectForKey:@"recommendGoods"])
    {
        NSString * recommendGoods_url = [NSString stringWithFormat:MALL_RECOMMEND_GOODS_URL,@"377284"];
        
        [bself.SellerInfo loadRecommendGoodsWithUrl:recommendGoods_url WithBlock:^(NSMutableArray *dataArray) {
            
            int row = (dataArray.count%2?1:0)+dataArray.count/2;
            
            float height = 95/2+227.5*row;
            
            DetailRecommendGoodsView * recommendGoodsView = [[DetailRecommendGoodsView alloc] initWithFrame:CGRectMake(0,0,320,height)];
            
            recommendGoodsView.delegate = bself;
            
            [recommendGoodsView loadViewWithDataArray:dataArray];
            
            [recommendGoods_dictionary setObject:recommendGoodsView forKey:@"recommendGoods"];
            
            [bself.myTableView reloadData];
        }];
    }
}


-(void)back
{
    [productDetail_request cancel];
    productDetail_request.delegate = nil;
    productDetail_request = nil;
    
    [productComments_request cancel];
    productComments_request.delegate = nil;
    productComments_request = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadProductDetailInfo];
    
    self.view.backgroundColor = RGBCOLOR(243,243,243);
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    CommentsPageCount = 1;
    
    _ProductInfo = [[ProductModel alloc] init];
        
    productComments_array = [[NSMutableArray alloc] init];
    
    recommendGoods_dictionary = [[NSMutableDictionary alloc] init];

    self.title = @"商品详情";
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource =self;
    
    if (MY_MACRO_NAME) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}


#pragma mark-幻灯+详情

-(UIView *)loadSlideViewAndContentView
{
    tableHeaderView = [[UIView alloc] init];
    int length = _ProductInfo.PImages.count;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0 ; i < length; i++)
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[[_ProductInfo.PImages objectAtIndex:i] IThumbnail] forKey:@"link"];
        [tempArray addObject:dict];
    }
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
    if (length > 1)
    {
        NSDictionary *dict = [tempArray objectAtIndex:length-1];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1] ;
        [itemArray addObject:item];
    }
    for (int i = 0; i < length; i++)
    {
        NSDictionary *dict = [tempArray objectAtIndex:i];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i] ;
        [itemArray addObject:item];
        
    }
    //添加第一张图 用于循环
    if (length >1)
    {
        NSDictionary *dict = [tempArray objectAtIndex:0];
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length];
        [itemArray addObject:item];
    }
    LoopScrollview *bannerView = [[LoopScrollview alloc] initWithFrame:CGRectMake(0, 0, 320,320) delegate:self imageItems:itemArray isAuto:NO];
    [bannerView scrollToIndex:0];
    [tableHeaderView addSubview:bannerView];
    
    
    

    float content_imageView_height = 0;
    
    UIImageView * content_imageView = [[UIImageView alloc] init];
    
    content_imageView.backgroundColor = [UIColor whiteColor];
    
    content_imageView.userInteractionEnabled = YES;
    
    [tableHeaderView addSubview:content_imageView];
    
    
    content_imageView_height += 14;
    
    UILabel * name_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,14,255-23,15)];
    
    name_label.text = _ProductInfo.PName;
    
    name_label.font = [UIFont systemFontOfSize:14];
    
    name_label.textAlignment = NSTextAlignmentLeft;
    
    name_label.textColor = [UIColor blackColor];
    
    name_label.backgroundColor = [UIColor clearColor];
    
    [content_imageView addSubview:name_label];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(509/2,14,0.5,15)];
    
    lineView.backgroundColor = RGBCOLOR(201,201,201);
    
    [content_imageView addSubview:lineView];
    
    
    UIButton * top_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    top_button.frame = CGRectMake(265,14,45,15);
    
    [top_button setTitle:@"17" forState:UIControlStateNormal];
    
    top_button.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    top_button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [top_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [top_button setImage:[UIImage imageNamed:@"ZMallgood_26x29.png"] forState:UIControlStateNormal];
    
    [top_button setTitleEdgeInsets:UIEdgeInsetsMake(0,5,0,0)];
    
    [top_button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,15)];
    
    [top_button addTarget:self action:@selector(TopOnce:) forControlEvents:UIControlEventTouchUpInside];
    
    [content_imageView addSubview:top_button];
    
    
    content_imageView_height += 27.5;
    
    UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,content_imageView_height+1,38,15)];
    
    price_label.textColor = TEXTCLOLOR;
    
    price_label.font = [UIFont systemFontOfSize:15];
    
    price_label.textAlignment = NSTextAlignmentLeft;
    
    price_label.backgroundColor = [UIColor clearColor];
    
    price_label.text = @"价格:";
    
    [content_imageView addSubview:price_label];
    
    
    UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(price_label.frame.origin.x+40,content_imageView_height,250,16)];
    
    price.text = [NSString stringWithFormat:@"¥ %@",_ProductInfo.PPrice];
    
    price.textAlignment = NSTextAlignmentLeft;
    
    price.textColor = RGBCOLOR(195,0,0);
    
    price.font = [UIFont systemFontOfSize:17];
    
    price.backgroundColor = [UIColor clearColor];
    
    [content_imageView addSubview:price];
    
    
    if (![_ProductInfo.PBrand isEqualToString:@""] && !_ProductInfo.PBrand.length == 0) {
        
        content_imageView_height += 25.5;
        
        //品牌
        UILabel * brand_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,price_label.frame.origin.y+price_label.frame.size.height+23/2,597/2,15)];
        
        brand_label.text = [NSString stringWithFormat:@"品牌:%@",_ProductInfo.PBrand];
        
        brand_label.textAlignment = NSTextAlignmentLeft;
        
        brand_label.textColor = TEXTCLOLOR;
        
        brand_label.font = [UIFont systemFontOfSize:15];
        
        brand_label.backgroundColor = [UIColor clearColor];
        
        [content_imageView addSubview:brand_label];
    }
    
    if (![_ProductInfo.PMark isEqualToString:@""] && !_ProductInfo.PMark.length == 0) {
        
        content_imageView_height += 25.5;
        
        //标签
        UILabel * mark_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,content_imageView_height,597/2,15)];
        
        mark_label.textColor = TEXTCLOLOR;
        
        mark_label.textAlignment = NSTextAlignmentLeft;
        
        mark_label.font = [UIFont systemFontOfSize:15];
        
        mark_label.text = [NSString stringWithFormat:@"标签(TAG) : %@",_ProductInfo.PMark];
        
        mark_label.backgroundColor = [UIColor clearColor];
        
        [content_imageView addSubview:mark_label];
    }

    content_imageView_height +=25.5;
    
    //浏览次数
    UILabel * browse_label = [[UILabel alloc] initWithFrame:CGRectMake(23/2,content_imageView_height,150,15)];
    
    browse_label.text = [NSString stringWithFormat:@"浏览次数: %@",_ProductInfo.PBrwoseCount];
    
    browse_label.textAlignment = NSTextAlignmentLeft;
    
    browse_label.textColor = TEXTCLOLOR;
    
    browse_label.font = [UIFont systemFontOfSize:15];
    
    browse_label.backgroundColor = [UIColor clearColor];
    
    [content_imageView addSubview:browse_label];
    
    
    
    UILabel * area_label = [[UILabel alloc] initWithFrame:CGRectMake(browse_label.frame.origin.x+browse_label.frame.size.width+10,browse_label.frame.origin.y,320-(browse_label.frame.origin.x+browse_label.frame.size.width+20),15)];
    
    area_label.textColor = TEXTCLOLOR;
    
    area_label.font = [UIFont systemFontOfSize:15];
    
    area_label.textAlignment = NSTextAlignmentLeft;
    
    area_label.text = [NSString stringWithFormat:@"所在地区: %@",_ProductInfo.PArea];
    
    area_label.backgroundColor = [UIColor clearColor];

    [content_imageView addSubview:area_label];
    
    
    content_imageView.frame = CGRectMake(0,320,320,content_imageView_height+23/2+14);
    
    UIView * theview = [[UIView alloc] initWithFrame:CGRectMake(0,content_imageView.frame.size.height + 320,320,23/2)];
    
    theview.backgroundColor = RGBCOLOR(243,243,243);
    
    [tableHeaderView addSubview:theview];
    
    tableHeaderView.frame = CGRectMake(0,0,320,content_imageView.frame.size.height + 320 + 23/2);
    
    return tableHeaderView;
}


#pragma mark-tableHeaderView2


-(UIView *)loadTableHeaderViewTwo
{
    aView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,35.5)];
    
    aView.backgroundColor = RGBCOLOR(243,243,243);
    
    NSArray * array = [NSArray arrayWithObjects:@"商品详情",[NSString stringWithFormat:@"商品评价(%@)",_ProductInfo.PCommentsCount],@"商家介绍",nil];
    
    NSArray * ImageArray = [NSArray arrayWithObjects:@"ZMallNewxiangqing1_200x71.png",@"ZMallNewpingjia1_240x71.png",@"ZMallNewjianjie1_200x71.png",@"ZMallNewxiangqing_200x71.png",@"ZMallNewpingjia_240x71.png",@"ZMallNewjianjie_200x71.png",nil];
    
    
    for (int i = 0;i < 3;i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(100*i+(i>1?20:0),0,100+(i==1?20:0),35.5);
        
        button.backgroundColor = RGBCOLOR(251,251,251);
        
        [button setImage:[UIImage imageNamed:[ImageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:[ImageArray objectAtIndex:i+3]] forState:UIControlStateSelected];
        
        button.tag = 1000+i;
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(switchSegment:) forControlEvents:UIControlEventTouchUpInside];
        
        [aView addSubview:button];
        
        
        
        UILabel * title_label = [[UILabel alloc] initWithFrame:button.bounds];
        
        title_label.text = [array objectAtIndex:i];
        
        title_label.tag = 10;
        
        title_label.textAlignment = NSTextAlignmentCenter;
        
        title_label.textColor = [UIColor blackColor];
        
        title_label.font = [UIFont systemFontOfSize:15];
        
        title_label.userInteractionEnabled = NO;
        
        [button addSubview:title_label];
        
        if (i == 0) {
            button.selected = YES;
        }else
        {
            title_label.textColor = RGBCOLOR(120,120,120);
        }
    }
    
    return aView;
}


#pragma mark-切换

-(void)switchSegment:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
            theType = ProductCellTypeDetail;
            _myTableView.tableFooterView = nil;
            break;
        case 1001:
            theType = ProductCellTypeEvaluation;
            
            if (!loadMoreView) {
                loadMoreView = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0,0,320,40)];
            }
            
            _myTableView.tableFooterView = loadMoreView;
            
            [self loadProductCommentsData];
            break;
        case 1002:
            theType = ProductCellTypeIntroduce;
            
            _myTableView.tableFooterView = nil;
            
            [self loadSellerInfomationAndRecommendGoods];
            
            break;
            
        default:
            break;
    }
    
    
    for (int i = 1000;i < 1003;i++) {
        if (i == sender.tag) {
            sender.selected = YES;
            
            UILabel * label = (UILabel *)[sender viewWithTag:10];
            
            label.textColor = [UIColor blackColor];
        }else
        {
            UIButton * button = (UIButton *)[aView viewWithTag:i];
            
            button.selected = NO;
            
            UILabel * label = (UILabel *)[button viewWithTag:10];
            
            label.textColor = RGBCOLOR(120,120,120);
        }
    }
    
//    float contentOffset = _myTableView.contentOffset.y;
    
    [_myTableView reloadData];
    
    
    
    _myTableView.contentOffset = CGPointMake(0,tableHeaderView.frame.size.height);
    
    
//    if (postionState[theType]  == 0.000000)
//    {
//        if (contentOffset >=tableHeaderView.frame.size.height)
//        {
//            _myTableView.contentOffset = CGPointMake(0,tableHeaderView.frame.size.height);
//        }else
//        {
//            _myTableView.contentOffset  = CGPointMake(0,contentOffset<tableHeaderView.frame.size.height?contentOffset:tableHeaderView.frame.size.height);
//        }
//    }else
//    {
//        _myTableView.contentOffset = CGPointMake(0,_myTableView.contentOffset.y>0?postionState[theType]:0);
//    }
}


#pragma mark-赞一个

-(void)TopOnce:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformScale(sender.transform,1.0,-1.0);
        [sender setTitle:@"18" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"ZMallgood1_26x29.png"] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            sender.transform = CGAffineTransformScale(sender.transform,1.0,-1.0);
        }];
    }];
}

#pragma mark-UIWebViewDelegate


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    float webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    CGRect rect = webView.frame;
    
    rect.size.height = webViewHeight;
    
    webView.frame = rect;
    
    [webView removeFromSuperview];
    
    webView.hidden = NO;
    
    [recommendGoods_dictionary setObject:webView forKey:@"GoodsDetailView"];
    
    [self.myTableView reloadData];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

#pragma mark-UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _myTableView) {
        switch (theType) {
            case ProductCellTypeDetail:
                postionState[0] = scrollView.contentOffset.y;
                break;
            case ProductCellTypeEvaluation:
                postionState[1] = scrollView.contentOffset.y;
                break;
            case ProductCellTypeIntroduce:
                postionState[2] = scrollView.contentOffset.y;
                break;
                
            default:
                break;
        }
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(_myTableView.contentOffset.y > (_myTableView.contentSize.height - _myTableView.frame.size.height+40) && _myTableView.contentOffset.y > 0 && scrollView == _myTableView && theType == ProductCellTypeEvaluation)
    {
        if ([loadMoreView.normalLabel.text isEqualToString:@"加载中..."] || [loadMoreView.normalLabel.text isEqualToString:@"没有更多了"])
        {
            return;
        }
        
        [loadMoreView startLoading];
        
        CommentsPageCount ++;
        
        [self loadProductCommentsData];
    }
}



-(NSString *)exchangeString:(NSString *)theString
{
    NSString * _text = [theString stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    RTLabelExtractedComponent *component = [RTLabel extractTextStyleFromText:_text paragraphReplacement:@"\n"];
    return component.plainText;
}

#pragma mark-UITableViewDelegate
-(void)dealloc{
    
    self.SellerInfo = nil;
    
    self.myTableView = nil;
    
    self.ProductInfo = nil;
    
    self.slide_array = nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    {
        switch (theType) {
            case ProductCellTypeDetail:
                
                return 1;
                break;
            case ProductCellTypeEvaluation:
                return productComments_array.count;
                break;
            case ProductCellTypeIntroduce:
            
                return [recommendGoods_dictionary objectForKey:@"GoodsDetailView"]?recommendGoods_dictionary.count-1:recommendGoods_dictionary.count;
                break;
                
            default:
                break;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 0;
    
    if (indexPath.section != 0) {
        switch (theType) {
            case ProductCellTypeDetail:
            {
                UIWebView * webView = (UIWebView *)[recommendGoods_dictionary objectForKey:@"GoodsDetailView"];
                
                rowHeight = webView.frame.size.height;
            }
                
                break;
                
            case ProductCellTypeEvaluation:
                rowHeight = 128;
                break;
                
            case ProductCellTypeIntroduce:
                
                if (_SellerInfo.SDescription.length !=0 && ![_SellerInfo.SDescription isEqualToString:@""]) {
                    
                 
                    if (indexPath.row == 0)
                    {
                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12.5,0,295,0)];
                        
                        label.textAlignment = NSTextAlignmentLeft;
                        
                        label.textColor = [UIColor blackColor];
                        
                        label.lineBreakMode = NSLineBreakByWordWrapping;
                        
                        label.numberOfLines = 0;
                        
                        label.text = _SellerInfo.SDescription;
                        [label sizeToFit];

                        
                        
                        rowHeight = label.frame.size.height+38;
                    }else if (indexPath.row == 1)
                    {
                        rowHeight = 93;
                    }else
                    {
                        DetailRecommendGoodsView * view = (DetailRecommendGoodsView *)[recommendGoods_dictionary objectForKey:@"recommendGoods"];
                        
                        rowHeight = view.frame.size.height;
                    }
                    
                }else
                {
                    
                    if (indexPath.row==0) {
                        rowHeight = 46;
                    }else
                    {
                        DetailRecommendGoodsView * view = (DetailRecommendGoodsView *)[recommendGoods_dictionary objectForKey:@"recommendGoods"];
                        
                        rowHeight = view.frame.size.height;
                    }
                }
                
                break;
                
            default:
                break;
        }
    }
    
    return rowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return tableHeaderView.frame.size.height;
    }else
    {
        return 35.5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return tableHeaderView;
    }else
    {
        return aView;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (theType == ProductCellTypeIntroduce)
    {
        static NSString * identifier = @"cell";
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_SellerInfo.SDescription.length ==0 && [_SellerInfo.SDescription isEqualToString:@"GoodsDetailView"])
        {
            
            if (indexPath.row == 0)
            {
                SellerInfoView * view = (SellerInfoView *)[recommendGoods_dictionary objectForKey:@"sellerInfo"];
                [cell.contentView addSubview:view];
            }else
            {
                DetailRecommendGoodsView * detailView = (DetailRecommendGoodsView *)[recommendGoods_dictionary objectForKey:@"recommendGoods"];
                [cell.contentView addSubview:detailView];
            }
            
        }else
        {
            
            for (UIView * view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
            if (indexPath.row == 0)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12.5,19,295,cell.frame.size.height)];
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.textColor = [UIColor blackColor];
                
                label.lineBreakMode = NSLineBreakByWordWrapping;
                
                label.backgroundColor = [UIColor clearColor];
                
                label.numberOfLines = 0;
                
                label.text = _SellerInfo.SDescription;
                [label sizeToFit];
                
                [cell.contentView addSubview:label];
            }else if (indexPath.row == 1)
            {
                SellerInfoView * view = (SellerInfoView *)[recommendGoods_dictionary objectForKey:@"sellerInfo"];
                [cell.contentView addSubview:view];
            }else if (indexPath.row == 2)
            {
                DetailRecommendGoodsView * detailView = (DetailRecommendGoodsView *)[recommendGoods_dictionary objectForKey:@"recommendGoods"];
                [cell.contentView addSubview:detailView];
            }
        }
        
        return cell;
    }else
    {
        static NSString * identifier = @"identifier";
        
        ProductCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[ProductCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView * view in cell.contentView.subviews) {
            view.hidden = YES;
        }
        
        switch (theType) {
            case ProductCellTypeDetail:
            {
                UIWebView * webView = (UIWebView *)[recommendGoods_dictionary objectForKey:@"GoodsDetailView"];
                
                webView.hidden = NO;
                
                [cell.contentView addSubview:webView];
                
            }
                break;
            case ProductCellTypeEvaluation:
            {
                ProductModel * info = [productComments_array objectAtIndex:indexPath.row];
                
                _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                
                [cell setAllViewsWithCellType:ProductCellTypeEvaluation];
                
                [cell setInfoWithProductInfo:info WithType:ProductCellTypeEvaluation];
            }
                break;
            case ProductCellTypeIntroduce:
            {
                
            }
                
                break;
                
            default:
                break;
        }
        return cell;
    }
}




#pragma mark-DetailRecommendGoodsViewDelegate


-(void)ClickToProductDetailsWith:(SellerInfo *)info
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end



























