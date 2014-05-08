//
//  MoreSPViewController.m
//  越野e族
//
//  Created by gaomeng on 14-5-3.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MoreSPViewController.h"
#import "CustomShangpinCell.h"

@interface MoreSPViewController ()

@end

@implementation MoreSPViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isUpMore = NO;
    _isUpMoreSuccess = YES;
    _page = 1;
    _priceClicked = YES;
    
    
    //分配内存
    _spArray = [NSMutableArray arrayWithCapacity:1];
    
    
    
//    //最上面segmentview
//    UIView *topSegmentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    topSegmentView.backgroundColor = backGray;
//    
//    //segmentControl
//    NSArray *segments = [[NSArray alloc]initWithObjects:@"默认",@"价格",@"销量", nil];
//    UISegmentedControl *segmentc = [[UISegmentedControl alloc]initWithItems:segments];
//    segmentc.frame = CGRectMake(12, 10, 296, 26);
//    [segmentc addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    segmentc.selectedSegmentIndex = 0;
//    self.mySegmentedControl = segmentc;
//    
//    //添加到topview上
//    [topSegmentView addSubview:segmentc];
//    [self.view addSubview:topSegmentView];
    
    
    
    //0
    UIView *sectionV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    sectionV.backgroundColor=RGBCOLOR(236, 236, 236);
    
    NSArray * exchange_array = [NSArray arrayWithObjects:@"ZMallchose1_199x57.png",@"ZMallchose2_197x57.png",@"ZMallchose_196x57.png",@"ZMallchose4_199x57.png",@"ZMallchose5_197x57.png",@"ZMallchose6_196x57.png",nil];
    
    CustomSegmentView * customSegment = [[CustomSegmentView alloc] initWithFrame:CGRectMake((320-295)/2,(50-57/2)/2,295,57/2)];
    [customSegment setAllViewWithArray:exchange_array];
    
    [customSegment settitleWitharray:[NSArray arrayWithObjects:@"默认",@"价格",@"销量", nil]];
    customSegment.delegate = self;
    
    
    [sectionV addSubview:customSegment];
    
    [self.view addSubview:sectionV];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //主tableview
    _tableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, 320, 568-50-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
    
    
    NSLog(@"self.spFenlei = %d",self.spFenlei);
    
    //判断用户点击的是那种商品分类
    switch (self.spFenlei) {
        case 1:
            _headerTitle = @"推荐商品";
            [self prepareMorenData];
            break;
        case 2:
            _headerTitle = @"新品";
            [self prepareMorenData];
            break;
        case 3:
            _headerTitle = @"所有商品";
            [self prepareMorenData];
            break;
        default:
            break;
    }
    
    //商品个数
    _count = 0;
    
    
    
    
    //下拉刷新
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-_tableview.bounds.size.height, 320, _tableview.bounds.size.height)];
        view.delegate = self;
        view.backgroundColor = RGBCOLOR(236, 236, 236);
        _refreshHeaderView = view;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    [_tableview addSubview:_refreshHeaderView];
    
    //上提加载更多
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    _upMoreView = [[LoadingIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    _upMoreView.type = 1;
    [view addSubview:_upMoreView];
    view.backgroundColor = RGBCOLOR(236, 236, 236);
    _tableview.tableFooterView = view;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 228;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self panduanNumberOfRow:_count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    CustomShangpinCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomShangpinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = backGray;
    [cell cleanData];
    [cell configWithArray:_spArray indexPath:indexPath];
    [cell setSpChooseBlock:^(int tag) {
#pragma mark - 在此处设置点击具体商品需要跳转的操作
        NSLog(@"在MoreSPViewController.m中设置 商品id =%d",tag);
    }];
    
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _headerTitle;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    view.backgroundColor = backGray;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 30)];
    label.text = _headerTitle;
    [view addSubview:label];
    return view;
}



#pragma mark - 下拉刷新Method
-(void)reloadTableViewDataSource{
    _reloading = YES;
}

-(void)doneLoadingTableViewData{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableview];
    
}

#pragma mark - EGORefreshTableHeaderDelegate

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    _page = 1;
  
    [self reloadTableViewDataSource];
    
    //触发下拉刷新动作 开始拉取数据
    switch (_segmentChoose) {
        case 0:
            [self prepareMorenData];
            break;
        case 1:
            [self preparePriceData];
            break;
        case 2:
            [self prepareXiaoliangData];
            break;
            
        default:
            break;
    }
    
    
    
}


-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return _reloading;
}

-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}

#pragma mark - UIScrollViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if(_tableview.contentOffset.y > (_tableview.contentSize.height - _tableview.frame.size.height+40)&&_isUpMoreSuccess==YES&&[_spArray count]>0) {
        
        _isUpMore = YES;
        [_upMoreView startLoading];
        _page++;
        _isUpMoreSuccess = !_isUpMoreSuccess;
        switch (_segmentChoose) {
            case 0:
                [self prepareMorenData];
                break;
            case 1:
                [self preparePriceData];
                break;
            case 2:
                [self prepareXiaoliangData];
                break;
            default:
                break;
        }
//        [_refreshHeaderView startLoading];
//        myCurrentPage++;
//        isloadProductSuccess=!isloadProductSuccess;
//        
//        [self startSearchwithgoodsNmae:self.searchgoodsnameString SearchType:sortstring page:myCurrentPage];
        
        
    }
    
}







-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
//    if (_tableview.contentOffset.y > (_tableview.contentSize.height - _tableview.frame.size.height+40) && _tableview.contentOffset.y > 0 && scrollView == _tableview) {
//        
//        _isUpMore = YES;
//        [_upMoreView startLoading];
//        switch (_segmentChoose) {
//            case 0:
//                [self prepareMorenData];
//                break;
//            case 1:
//                [self preparePriceData];
//                break;
//            case 2:
//                [self prepareXiaoliangData];
//                break;
//            default:
//                break;
//        }
//        
//    }
    
}




#pragma mark - myMethod

//-(void)segmentChanged:(UISegmentedControl *)paramSender{
//    if ([paramSender isEqual:self.mySegmentedControl]) {
//        //获得索引位置
//
//        NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];
//        
//        //获得对应索引位置的text值
//        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
//        NSLog(@"Segment %ld with %@ text is selected",(long)selectedSegmentIndex,selectedSegmentText);
//        
//        //根据不同的index请求不同的网络数据 默认0 价格1 销量2
//        switch (selectedSegmentIndex) {
//            case 0:
//                _page = 1;
//                _spArray = nil;
//                _spArray = [NSMutableArray arrayWithCapacity:1];
//                _segmentChoose = 0;
//                _count = 0;
//                [_tableview reloadData];
//                [self prepareMorenData];
//                break;
//            case 1:
//                _page = 1;
//                _spArray = nil;
//                _spArray = [NSMutableArray arrayWithCapacity:1];
//                _segmentChoose = 1;
//                _count = 0;
//                [_tableview reloadData];
//                [self preparePriceData];
//                break;
//            case 2:
//                _page = 1;
//                _spArray = nil;
//                _spArray = [NSMutableArray arrayWithCapacity:1];
//                _segmentChoose = 2;
//                _count = 0;
//                [_tableview reloadData];
//                [self prepareXiaoliangData];
//                break;
//                
//            default:
//                break;
//        }
//    }
//}





#pragma mark--类别切换

-(void)buttonClick:(int)buttonSelected{
    switch (buttonSelected) {
        case 0:
            _page = 1;
            _spArray = nil;
            _spArray = [NSMutableArray arrayWithCapacity:1];
            _segmentChoose = 0;
            _count = 0;
            [_tableview reloadData];
            [self prepareMorenData];
            break;
        case 1:
            _priceClicked = !_priceClicked;
            _page = 1;
            _spArray = nil;
            _spArray = [NSMutableArray arrayWithCapacity:1];
            _segmentChoose = 1;
            _count = 0;
            [_tableview reloadData];
            [self preparePriceData];
            break;
        case 2:
            _page = 1;
            _spArray = nil;
            _spArray = [NSMutableArray arrayWithCapacity:1];
            _segmentChoose = 2;
            _count = 0;
            [_tableview reloadData];
            [self prepareXiaoliangData];
            break;
            
        default:
            break;
    }
    
    
}



#pragma mark - 网络请求

//推荐商品 http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=1&formattype=json
//新品  http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&goodssort=2&formattype=json&formattype=json
//所有商品 http://malltest.fblife.com/api.php?app=store&act=search&id=%@&pageper=4&formattype=json





//默认
-(void)prepareMorenData{
    NSLog(@"当前页码:%d",_page);
    NSLog(@"是否为上提加载更多：%d",_isUpMore);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mall.fblife.com/api.php?app=store&act=search&id=%@&goodssort=%d&page=%d&pageper=8&formattype=json",self.sellerID,self.spFenlei,_page]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *datainfoArray =[dic objectForKey:@"datainfo"];
            
            //是否为上提加载更多
            if (_isUpMore) {
                [_spArray addObjectsFromArray:datainfoArray];
                //上提加载更多完成
                [_upMoreView stopLoading:1];
                _isUpMore = NO;
                
            }else{
                
                NSMutableArray *tmp = [NSMutableArray arrayWithArray:datainfoArray];
                [_spArray removeAllObjects];
                _spArray = tmp;
            }
            
            _isUpMoreSuccess = YES;
        }
    
    
        
        //获取商品数据里元素的个数
        _count = [_spArray count];
        NSLog(@"商品的个数为:%d",_count);
        
        
        
        //重载tableview
        [_tableview reloadData];
        
        //下拉刷新完成
        [self doneLoadingTableViewData];
        
        
        
    }];
    
    
}




//价格
-(void)preparePriceData{
    NSLog(@"当前页码:%d",_page);
    NSLog(@"是否为上提加载更多：%d",_isUpMore);
    
    
    NSURL *url = nil;
    if (_priceClicked) {//升序
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mall.fblife.com/api.php?app=store&act=search&id=%@&goodssort=%d&page=%d&pageper=8&order=price_asc&formattype=json",self.sellerID,self.spFenlei,_page]];
    }else{//降序
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mall.fblife.com/api.php?app=store&act=search&id=%@&goodssort=%d&page=%d&pageper=8&order=price_desc&formattype=json",self.sellerID,self.spFenlei,_page]];
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray *datainfoArray = [dic objectForKey:@"datainfo"];
            
            
            //是否为上提加载更多
            if (_isUpMore) {
                [_spArray addObjectsFromArray:datainfoArray];
                //上提加载更多完成
                [_upMoreView stopLoading:1];
                _isUpMore = NO;
                
            }else{
                
                
                NSMutableArray *tmp = [NSMutableArray arrayWithArray:datainfoArray];
                [_spArray removeAllObjects];
                _spArray = tmp;
            }
            
            _isUpMoreSuccess = YES;
        }
        
        
        //获取商品数据里元素的个数
        _count = [_spArray count];
        NSLog(@"商品的个数为:%d",_count);
        
        //重载tableview
        [_tableview reloadData];
        _isUpMoreSuccess = YES;
        
        //下拉刷新完成
        [self doneLoadingTableViewData];
    }];
}

//销量
-(void)prepareXiaoliangData{
    NSLog(@"当前页码:%d",_page);
    NSLog(@"是否为上提加载更多：%d",_isUpMore);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mall.fblife.com/api.php?app=store&act=search&id=%@&goodssort=%d&page=%d&pageper=8&order=sales_desc&formattype=json",self.sellerID,self.spFenlei,_page]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSMutableArray *datainfoArray = [dic objectForKey:@"datainfo"];
            
            
            //是否为上提加载更多
            if (_isUpMore) {
                [_spArray addObjectsFromArray:datainfoArray];
                //上提加载更多完成
                [_upMoreView stopLoading:1];
                _isUpMore = NO;
                
            }else{
                
                
                NSMutableArray *tmp = [NSMutableArray arrayWithArray:datainfoArray];
                [_spArray removeAllObjects];
                _spArray = tmp;
            }
            
            _isUpMoreSuccess = YES;
        }
        
        
        
        
        //获取商品数据里元素的个数
        _count = [_spArray count];
        NSLog(@"商品的个数为:%d",_count);
        
        
        //重载tableview
        [_tableview reloadData];
        
        //下拉刷新完成
        [self doneLoadingTableViewData];
        
        
    }];
}


-(NSInteger)panduanNumberOfRow:(NSInteger)count{
    
    
    
    NSLog(@"countxxx===%d====%d",_spArray.count,count);
    
    if (count%2 == 0) {
        return count / 2;
    }
    return count/2 +1;
}


@end
