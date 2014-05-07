//
//  DetailClassifyViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailClassifyViewController.h"
#import "ClassifyViewController.h"
@interface DetailClassifyViewController ()

@end

@implementation DetailClassifyViewController
@synthesize data_array = _data_array;
@synthesize headerImagesArray = _headerImagesArray;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-MyViewController


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)PeopleView:(UIButton *)sender
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [delegate setPersonalState:PersonalStateTypeShow];
}



-(void)initHttpRequest
{
    
    __weak typeof(self) bself = self;

    [ClassifyModel initHttpRequestWithUrl:MALL_CLASSIFY_URL WithBlock:^(NSMutableArray *theArray) {
        
        _data_array = [NSMutableArray arrayWithArray:theArray];
        
        [bself.MainTableview reloadData];
        
    }];
}



- (void)viewDidLoad
{    [super viewDidLoad];
    
    /**
     *  110,115,121
     */
    
    ClassifyModel = [[DetailClassifyModel alloc]init];
    
//    _data_array = [NSMutableArray array];
    
    
    [self initHttpRequest];

    self.view.backgroundColor=[UIColor whiteColor];
    //放在Controller里面
    
    
    _headerImagesArray = [NSArray arrayWithObjects:@"MallClassifyCar.png",@"MallClassifyMovement.png",@"MallClassifyModified.png",@"MallClassifyDriveEquipment.png",@"MallClassifyCommunication.png",@"MallClassifyDress.png",nil];
    
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    self.title = @"分类";
    
    
    
    
    
//    //1
    _MainTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self.view addSubview:_MainTableview];
    _MainTableview.delegate=self;
    _MainTableview.dataSource=self;
    _MainTableview.backgroundColor=[UIColor whiteColor];
    
    _MainTableview.separatorColor = RGBCOLOR(198,198,198);
    
    if (MY_MACRO_NAME) {
        _MainTableview.separatorInset = UIEdgeInsetsZero;
    }
    
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0)];
    
    _MainTableview.tableFooterView = footView;
    
    
    
//    //取消按钮
//    
//    UIButton *button_cancel=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, 44, 44)];
//    button_cancel.backgroundColor=[UIColor redColor];
//    [button_cancel setTitle:@"取消" forState:UIControlStateNormal];
//    [button_cancel addTarget:self action:@selector(DismissSelf) forControlEvents:UIControlEventTouchUpInside];
//    button_cancel.titleLabel.textColor=RGBCOLOR(110, 115, 121);
//    //
//    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:button_cancel];
//    rightitem.width=10;
//   // self.navigationItem.rightBarButtonItem=rightitem;
//
//    
//    
//    
//    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 44, 44)];
//    /**
//     *  设置frame只能控制按钮的大小
//     */
//    btn.frame= CGRectMake(0, 0, 44, 44);
//    btn.backgroundColor=[UIColor clearColor];
//  //  btn.titleLabel.textColor=RGBCOLOR(110, 115, 121);
//    [btn setTitle:@"取消" forState:UIControlStateNormal];
//    [btn setTitleColor:RGBCOLOR(110, 115, 121) forState:UIControlStateNormal];
//
//    [btn addTarget:self action:@selector(DismissSelf) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    /**
//     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
//     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
//     */
//    negativeSpacer.width = -7;
//    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
    
    
}

-(void)DismissSelf{
    [self dismissModalViewControllerAnimated:YES];
    self.leveyTabBarController.tabBar.hidden=NO;

}
#pragma mark-tableview的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data_array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    DetailClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[DetailClassifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.headImageview.image = nil;
    
    cell.MainTitleLabel.text = @"";
    
    cell.ClassifyLabel.text = @"";
    
    [cell loadContentWithDetailClassifyModel:[_data_array objectAtIndex:indexPath.row]];
    
    
//    _cellView=[[DetailClassifyCellView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
//
//    [_cellView settitleWithString:[_titleArray objectAtIndex:indexPath.row] _ClassifyLabelText:[_classArray objectAtIndex:indexPath.row]];
//    [cell.contentView addSubview:_cellView];
//    UIView *selectback=[[UIView alloc]initWithFrame:cell.frame];
//    selectback.backgroundColor=RGBCOLOR(242, 242, 242);
//    cell.selectedBackgroundView=selectback;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MallTypeClassifyViewController * ClassifyType = [[MallTypeClassifyViewController alloc] init];
    
    ClassifyType.theModel = [_data_array objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:ClassifyType animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
