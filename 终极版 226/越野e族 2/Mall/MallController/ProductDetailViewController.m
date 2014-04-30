//
//  ProductDetailViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ProductDetailViewController.h"


#define TEXTCLOLOR [UIColor colorWithRed:115/255.0f green:115/255.0f blue:115/255.0f alpha:1];

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
@synthesize myTableView = _myTableView;
@synthesize slide_array = _slide_array;
@synthesize ProductInfo = _ProductInfo;




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
    
    
    ASIHTTPRequest * productDetail_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:full_url]];
    
    productDetail_request.delegate = self;
    
    __block ASIHTTPRequest * request = productDetail_request;
    
    [productDetail_request setCompletionBlock:^{
        
        NSDictionary * totalDictionary = [request.responseData objectFromJSONData];
        
        NSString * errcode = [totalDictionary objectForKey:@"errcode"];
        
        NSLog(@"totalDictionary ------    %@",totalDictionary);
        
        if ([errcode intValue] == 0)
        {
            NSDictionary * data_dictionary = [totalDictionary objectForKey:@"datainfo"];
            
    
            _ProductInfo = [[ProductModel alloc] initWithDictionary:data_dictionary];
            
        }
        
        [self loadSlideViewAndContentView];
        
        [self loadTableHeaderViewTwo];
        
        [self.myTableView reloadData];
        
    }];
    
    [productDetail_request setFailedBlock:^{
        
    }];
    

    [productDetail_request startAsynchronous];
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadProductDetailInfo];
    
    self.view.backgroundColor = RGBCOLOR(243,243,243);
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    
    _ProductInfo = [[ProductModel alloc] init];

    
    _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource =self;
    
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
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[[_ProductInfo.PImages objectAtIndex:i] IImageUrl] forKey:@"link"];
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
    
    tableHeaderView.frame = CGRectMake(0,0,320,content_imageView.frame.size.height + 320);
    
    return tableHeaderView;
}


#pragma mark-tableHeaderView2


-(UIView *)loadTableHeaderViewTwo
{
    aView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,35.5+23/2)];
    
    aView.backgroundColor = RGBCOLOR(243,243,243);
    
    NSArray * array = [NSArray arrayWithObjects:@"商品详情",[NSString stringWithFormat:@"商品评价(%@)",_ProductInfo.PCommentsCount],@"商家介绍",nil];
    
    NSArray * ImageArray = [NSArray arrayWithObjects:@"ZMallNewxiangqing1_200x71.png",@"ZMallNewpingjia1_240x71.png",@"ZMallNewjianjie1_200x71.png",@"ZMallNewxiangqing_200x71.png",@"ZMallNewpingjia_240x71.png",@"ZMallNewjianjie_200x71.png",nil];
    
    
    for (int i = 0;i < 3;i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(100*i+(i>1?20:0),23/2,100+(i==1?20:0),35.5);
        
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
            break;
        case 1001:
            theType = ProductCellTypeEvaluation;
            break;
        case 1002:
            theType = ProductCellTypeIntroduce;
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
    
    
    float contentOffset = _myTableView.contentOffset.y;
    
    [_myTableView reloadData];
    
    
    if (postionState[theType]  == 0.000000)
    {
        if (contentOffset >=tableHeaderView.frame.size.height)
        {
            _myTableView.contentOffset = CGPointMake(0,tableHeaderView.frame.size.height);
        }else
        {
            _myTableView.contentOffset  = CGPointMake(0,contentOffset<tableHeaderView.frame.size.height?contentOffset:tableHeaderView.frame.size.height);
        }
    }else
    {
        _myTableView.contentOffset = CGPointMake(0,_myTableView.contentOffset.y>0?postionState[theType]:0);
    }
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



#pragma mark-UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    {
        return 128;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 0;
    
    switch (theType) {
        case ProductCellTypeDetail:
            rowHeight = 50;
            break;
            
        case ProductCellTypeEvaluation:
            rowHeight = 128;
            break;
            
        case ProductCellTypeIntroduce:
            rowHeight = 50;
            break;
            
        default:
            break;
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
    static NSString * identifier = @"identifier";
    
    ProductCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[ProductCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.textLabel.text = @"";
    
    switch (theType) {
        case ProductCellTypeDetail:
            cell.textLabel.text = [NSString stringWithFormat:@"周%d",indexPath.row];
            break;
        case ProductCellTypeEvaluation:
            
            _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            [cell setAllViewsWithCellType:ProductCellTypeEvaluation];
        
            [cell setInfoWithProductInfo:_ProductInfo];
            
            break;
        case ProductCellTypeIntroduce:
            cell.textLabel.text = [NSString stringWithFormat:@"郑%d",indexPath.row];
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end



























