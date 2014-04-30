//
//  MallTypeClassifyViewController.m
//  越野e族
//
//  Created by soulnear on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MallTypeClassifyViewController.h"
#import "ClassifyViewController.h"



@interface ClassifyPopView ()
{
    
}

@end

@implementation ClassifyPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}


-(void)setAllViewsWithContent:(NSArray *)theContent
{
    UIImageView * separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,7)];
    
    separatorLine.image = [UIImage imageNamed:@"ZMallneijiantou_640x14.png"];
    
    [self addSubview:separatorLine];
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0,7,320,self.frame.size.height-7)];
    
    backView.backgroundColor = RGBCOLOR(252,252,252);
    
    [self addSubview:backView];
    
    int row = (theContent.count/3?1:0)+theContent.count/3;

    
    for (int i = 0;i < row;i++) {
        for (int j = 0;j < 3;j++) {
            
            if (j+i*3<theContent.count)
            {
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(12+103*j,20+44*i,90,32);
                
                [button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
                
                button.backgroundColor = RGBCOLOR(245,245,245);
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [button setTitle:[theContent objectAtIndex:j+i*3] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(ChooseButton:) forControlEvents:UIControlEventTouchUpInside];
                
                [backView addSubview:button];
            }
            
        }
    }
}


-(void)ChooseButton:(UIButton *)sender
{
    
}

@end




@interface MallTypeClassifyViewController ()
{
    NSArray * aaa;
    
    NSMutableArray * dataArray;
}

@end

@implementation MallTypeClassifyViewController
@synthesize myTableView = _myTableView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void)PeopleView:(UIButton *)sender
{
//    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    [delegate setPersonalState:PersonalStateTypeShow];
    
    
    
    NSArray * array1 = [NSArray arrayWithObjects:@"牧马人系列",@"猛禽系列",@"坦途系列",nil];
    
    NSMutableArray * data_array = [[NSMutableArray alloc] init];
    
    NSArray * array2 = [NSArray arrayWithObjects:@"悬挂系列",@"外装饰件",@"内装饰件",@"装甲防护系列",@"户外装备",nil];
    
    for (int i = 0;i < 3;i++) {
        [data_array addObject:array2];
    }
    
    
    SellerGoodsView * goodsView = [[SellerGoodsView alloc] initWithFrame:CGRectMake(320,20,557/2,iPhone5?548:460)];
    
    goodsView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    goodsView.layer.shadowOffset = CGSizeMake(-1,0);
    
    goodsView.layer.shadowRadius = 5;

    goodsView.delegate = self;
    
    [goodsView loadViewWithContent:data_array NameArray:array1];
    
    [[UIApplication sharedApplication].keyWindow addSubview:goodsView];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        goodsView.frame = CGRectMake(320-557/2,20,557/2,iPhone5?548:460);
        
        CGRect rect = self.navigationController.view.frame;
        
        rect.origin.x = -557/2;
        
        self.navigationController.view.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    self.title = @"整车";
    
    history_index = -1;
    
    aaa = [NSArray arrayWithObjects:@"SUV",@"皮卡",@"商务",@"轿车",nil];
    
    dataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0;i < 4;i++) {
        NSArray * array = [NSArray arrayWithObjects:@"雷克萨斯",@"奔驰",@"宝马",@"保时捷",nil];
        
        [dataArray addObject:array];
    }
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64) style:UITableViewStylePlain];
    
    _myTableView.dataSource = self;
    
    _myTableView.delegate = self;
    
    _myTableView.rowHeight = 58;
    
    if (MY_MACRO_NAME) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [self.view addSubview:_myTableView];
}



-(float)returnPopViewHeightWithCount:(int)theCount
{
    int row = (theCount/3?1:0)+theCount/3;
    return 20+44*row + 12;
}




#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aaa.count;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * tempArray = [dataArray objectAtIndex:indexPath.row];
    
    NSLog(@"height ------   %d",identifierHidden[indexPath.row]);
    
    return identifierHidden[indexPath.row]?([self returnPopViewHeightWithCount:tempArray.count]+51):58;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(12,21,280,16)];
    
    title_label.text = [aaa objectAtIndex:indexPath.row];
    
    title_label.textAlignment = NSTextAlignmentLeft;
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.font = [UIFont systemFontOfSize:15];
    
    [cell.contentView addSubview:title_label];
    
    
    
    UIImageView * jiantouImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:identifierHidden[indexPath.row]?@"ZMalljiantou-down_31x18.png":@"ZMalljiantou-up_31x18.png"]];
    
    jiantouImageView.center = CGPointMake(300,29);
    
    [cell.contentView addSubview:jiantouImageView];
    
    
    if (identifierHidden[indexPath.row]) {
        NSArray * tempArray = [dataArray objectAtIndex:indexPath.row];
        
        ClassifyPopView * popView = [[ClassifyPopView alloc] initWithFrame:CGRectMake(0,51,320,[self returnPopViewHeightWithCount:tempArray.count])];
        
        [popView setAllViewsWithContent:tempArray];
        
        [cell.contentView addSubview:popView];
    }
    
    
    
    
    return cell;
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0;i < aaa.count;i++)
    {
        if (identifierHidden[i] && i != indexPath.row)
        {
            identifierHidden[i] = !identifierHidden[i];
        }
    }
    
    identifierHidden[indexPath.row] = !identifierHidden[indexPath.row];
    
    [tableView reloadData];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
