//
//  ClassifyViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//
//具体分类
#import "ClassifyViewController.h"
#import "MainMagiClanternModel.h"
#import "ClassifySlideView.h"

<<<<<<< HEAD
@interface ClassifyViewController (){
    
    NSArray *array_lanmu;
    
    ClassifySlideView *_clv;

=======
@interface ClassifyViewController ()
{
    
>>>>>>> FETCH_HEAD
}

@end

@implementation ClassifyViewController


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
    self.view.backgroundColor=[UIColor orangeColor];
    
    self.navigationItem.title = @"商城";
    
    
    self.leftImageName = @"ios7_back.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    //顶部切换
    _clv=[[ClassifySlideView alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    
    [self.view addSubview:_clv];
    //2
    _MainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 36, 320, iPhone5?568-64-36:480-64-36) style:UITableViewStylePlain];
    _MainTabView.delegate=self;
    _MainTabView.dataSource=self;
    _MainTabView.backgroundColor=RGBCOLOR(236, 236, 236);
    _MainTabView.separatorColor=[UIColor greenColor];
    [self.view addSubview:_MainTabView];
    
    
    
    
    
    
     [self startLoadChanpin];
    
    
    
    
	// Do any additional setup after loading the view.
}

#pragma mark--tabview的代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return 10;
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
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    sectionV.backgroundColor=[UIColor clearColor];
    
    NSArray * exchange_array = [NSArray arrayWithObjects:@"ZMallchose1_199x57.png",@"ZMallchose2_197x57.png",@"ZMallchose_196x57.png",@"ZMallchose4_199x57.png",@"ZMallchose5_197x57.png",@"ZMallchose6_196x57.png",nil];
    
    CustomSegmentView * customSegment = [[CustomSegmentView alloc] initWithFrame:CGRectMake((320-295)/2,(50-57/2)/2,295,57/2)];
    [customSegment setAllViewWithArray:exchange_array];
    
    [customSegment settitleWitharray:[NSArray arrayWithObjects:@"默认",@"价格",@"销量", nil]];
    customSegment.delegate = self;
    
    
    [sectionV addSubview:customSegment];
    
    
    return sectionV;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(void)startLoadChanpin{
    
    NSLog(@"%s%@",__FUNCTION__,[NSString stringWithFormat:@"http://malltest.fblife.com/api.php?app=search&act=catenav&cate_id=%@&formattype=json",self.str_id]);
    
    typeof(_clv)_weak_clv=_clv;
    typeof(self)_weak_self=self;
    
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:[NSString stringWithFormat:@"http://mall.fblife.com/api.php?app=search&act=catenav&cate_id=%@&formattype=json",self.str_id] block:^(NSArray *arrayinfo, NSString *errorindo) {
        
        NSLog(@"根据id获取到二级分类的数据%@",arrayinfo);
        
        [_weak_clv ClassifySlideViewSetArray:arrayinfo bloc:^(int idofclassify) {
            
            NSLog(@"点击的是tag===%d",idofclassify);
            
            [_weak_self LoaddataonfProductwithid:idofclassify];
            
        }];
        
        
 
    }];
    

    
    
    
}

-(void)LoaddataonfProductwithid:(int )idofclassify{
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:@"http://mall.fblife.com/api.php?app=index&act=goodscate&formattype=json" block:^(NSArray *arrayinfo, NSString *errorindo) {
        
        NSLog(@"根据商品类别的id获取产品%@",arrayinfo);
        
        
        
        
        
    }];

    
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





























