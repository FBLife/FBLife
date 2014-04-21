//
//  MallViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-19.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MallViewController.h"

@interface MallViewController ()

@end

@implementation MallViewController

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
    
    
    self.navigationItem.title = @"商城";
    

    self.leftImageName = @"MallLeft40_32.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    
//    UIButton *button_back=[[UIButton alloc]initWithFrame: CGRectMake(MY_MACRO_NAME? -7:5, 3, 20, 32/2)];
//    
//    [button_back addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    [button_back setBackgroundImage:[UIImage imageNamed:@"MallLeft40_32.png"] forState:UIControlStateNormal];
//    
//    UIButton *back_view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
//    [back_view addSubview:button_back];
//    back_view.backgroundColor=[UIColor clearColor];
//    [back_view addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *back_item=[[UIBarButtonItem alloc]initWithCustomView:back_view];
//    self.navigationItem.leftBarButtonItem=back_item;
//    
//    
//     
//    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
//        //iOS 5 new UINavigationBar custom background
//        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
//        
//    }
    //主要的tableview
    _MainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64-49:480-64-49) style:UITableViewStylePlain];
    _MainTabView.delegate=self;
    _MainTabView.dataSource=self;
    _MainTabView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_MainTabView];
    
    
    
    
    [self StartLoadSlideShow];
	// Do any additional setup after loading the view.
}

#pragma mark-tableview的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    for (UIView *oldView in cell.contentView.subviews) {
        [oldView removeFromSuperview];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _MainTabView.frame.size.height/5;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController * product = [[ProductDetailViewController alloc] init];
    
    [self.navigationController pushViewController:product animated:YES];
}

#pragma mark-跳到分类页面
-(void)backto{
    NSLog(@"跳到分类页面");
    
}
#pragma mark-请求幻灯数据
-(void)StartLoadSlideShow{
    _slishouwmodels=[[SlideShowModel alloc]init];
    _slishouwmodels.delegate=self;
    [_slishouwmodels SlideShowModelStartLoad];
    
}
-(void)LoadErrorwithstring:(NSString *)errorinfo{
}
-(void)LoadPicFinishedWithUrlArray:(NSMutableArray *)sliderurlArr PicIDArr:(NSMutableArray *)picIDarray{
    
}

#pragma mark-
-(void)dealloc{
    _slishouwmodels.delegate=nil;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
