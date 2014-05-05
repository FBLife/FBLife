//
//  MainMallSearchViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainMallSearchViewController.h"
#import "MainMagiClanternModel.h"
#import "SearchResaultView.h"
#import "NoneResaultView.h"
@interface MainMallSearchViewController (){
    NoneResaultView *_noneResaultV;
    NSArray *search_array_info;
    NSMutableArray *array_two;//每两个放到一个数组里面,做多只能有两个元素
    NSMutableArray *array_all;
}

@end

@implementation MainMallSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    //
    _noneResaultV=[[NoneResaultView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64)];
    
    search_array_info=[NSArray array];//一个整体的array
    array_two=[NSMutableArray array];
    array_all=[NSMutableArray array];
    
    
    
    _MainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64:480-64) style:UITableViewStylePlain];
    _MainTabView.delegate=self;
    _MainTabView.dataSource=self;
    _MainTabView.backgroundColor=RGBCOLOR(236, 236, 236);
    _MainTabView.separatorColor=[UIColor clearColor];
    _MainTabView.showsVerticalScrollIndicator=NO;
    _MainTabView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_MainTabView];
    
    
    [self startSearchwithgoodsNmae:self.searchgoodsnameString SearchType:@"add_time desc" page:1];
    
	// Do any additional setup after loading the view.
}
#pragma mark-tableview的代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"==count=%d=====%@",array_all.count,array_all);
    
    
    return array_all.count;
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
        static NSString *identifier=@"identifier0";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        for (UIView *oldView in cell.contentView.subviews) {
            [oldView removeFromSuperview];
        }

    
    
        SearchResaultView *_reV=[[SearchResaultView alloc]initWithFrame:CGRectMake(0, 0, 320, 438/2)];



        NSArray  *arrayinfo=[array_all objectAtIndex:indexPath.row];
    
    
    
    
    NSLog(@"点击arrayinfo商品详情id==goosid==%@",arrayinfo);
    
    
    __weak typeof(self) bself = self;

    
        [_reV setarray:arrayinfo searchbloc:^(int idofGoods) {
            
            NSLog(@"点击进入商品详情id==goosid==%d",idofGoods);
            
            ProductDetailViewController * detail = [[ProductDetailViewController alloc] init];
            
            detail.GoodsId = [NSString stringWithFormat:@"%d",idofGoods];
            
            [bself.navigationController pushViewController:detail animated:YES];
            
            
            
        }];
        [cell.contentView addSubview:_reV];

    cell.contentView.backgroundColor=RGBCOLOR(236, 236, 236);
    cell.backgroundColor=RGBCOLOR(236, 236, 236);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
 
    return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        return 438/2+12;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  ProductDetailViewController * product = [[ProductDetailViewController alloc] init];
    
    // [self.navigationController

}
#pragma mark-获取数据

/*
 按照降序排列的
 http://malltest.fblife.com/api.php?act=index&keyword=T%D0%F4&app=search&formattype=json&page=1&pageper=2&order=price desc
 按照升序排列的
 http://malltest.fblife.com/api.php?act=index&keyword=T%D0%F4&app=search&formattype=json&page=1&pageper=2&order=price desc
 按照销量降序排列的
 http://malltest.fblife.com/api.php?act=index&keyword=T%D0%F4&app=search&formattype=json&page=1&pageper=2&order=sales desc
 */

-(void)startSearchwithgoodsNmae:(NSString *)str_name SearchType:(NSString *)str_searchtype page:(int)_page{
    
    
    __weak typeof(self) _weakself=self;
//    NSString *str_url=[NSString stringWithFormat:@"http://mall.fblife.com/api.php?act=index&keyword=%@&app=search&formattype=json&page=%d&pageper=15&order=%@",str_name,_page,str_searchtype];
    
    NSString *str_test=@"http://mall.fblife.com/api.php?act=index&keyword=T%D0%F4&app=search&formattype=json&page=1&pageper=9";
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:str_test block:^(NSArray *arrayinfo, NSString *errorindo) {
        
       // search_array_info=arrayinfo;
        
        
        
        NSLog(@"array===%d===%@",arrayinfo.count,arrayinfo);

        
        [_weakself ChangeDatawitharray:arrayinfo];
        
        
        
    }];
    
}

-(void)ChangeDatawitharray:(NSArray *)array{
    
  
   // NSMutableArray *array_all=[NSMutableArray array];
    
    NSLog(@"array===%d===%@",array.count,array);
//    NSMutableArray *array_two=[NSMutableArray array];

    for (int i=0; i<array.count; i++) {
        NSDictionary *dic_detail=[array objectAtIndex:i];
        [array_two addObject:dic_detail];
        
        
        
        
        if (array_two.count==1&&i==array.count-1) {
            //最后一个如果是一
            [array_all addObject:array_two];
            
            
            array_two=[NSMutableArray array];

            
        }else if (array_two.count==2&&i==array.count-1){
            [array_all addObject:array_two];
            
            array_two=[NSMutableArray array];

            
        }
            else if (array_two.count==2&&i<array.count-1){
            
            
            
            
            [array_all addObject:array_two];
            
                NSLog(@"%d==%@",array_all.count,array_all);
                array_two=[NSMutableArray array];


                
            
        }
    }
    
    NSLog(@"xxxxxx=====sss==%d==%@====",array_all.count,array_all);

    [_MainTabView reloadData];

    
    
    

    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_MainTabView) {
        _SecondTableview.contentOffset=_MainTabView.contentOffset;
    }else{
        _MainTabView.contentOffset=_SecondTableview.contentOffset;

    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
