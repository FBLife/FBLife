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
    
    int row = (theContent.count%3?1:0)+theContent.count/3;

    
    for (int i = 0;i < row;i++) {
        for (int j = 0;j < 3;j++) {
            
            if (j+i*3<theContent.count)
            {
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [button setTitleColor:RGBCOLOR(82,82,82) forState:UIControlStateNormal];
                
                button.backgroundColor = RGBCOLOR(245,245,245);
                
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [button setTitle:[[theContent objectAtIndex:j+i*3] objectForKey:@"value"] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(ChooseButton:) forControlEvents:UIControlEventTouchUpInside];
                [backView addSubview:button];
                
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    button.frame = CGRectMake(12+103*j,20+44*i,90,32);
                    
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
}


-(void)ChooseButton:(UIButton *)sender
{
    NSLog(@"点击的是什么------%@",sender.titleLabel.text);
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
@synthesize theModel = _theModel;
@synthesize data_array = _data_array;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


-(void)PeopleView:(UIButton *)sender
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [delegate setPersonalState:PersonalStateTypeShow];
}



-(void)initHttpRequest
{
    NSString * fullUrl = [NSString stringWithFormat:MALL_CLASSIFY_DETAILURL,_theModel.ClassCateId];
    
    NSLog(@"fullUrl------%@",fullUrl);
    
    __weak typeof(self) bself = self;
    
    [_theModel initHttpRequestTwoWithUrl:fullUrl WithBlock:^(NSMutableArray *theArray) {
        bself.data_array = theArray;
        
        [bself.myTableView reloadData];
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _data_array = [NSMutableArray array];
    
    [self initHttpRequest];
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeBack WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    self.title = _theModel.ClassDefaultCate;
    
    history_index = -1;
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-64) style:UITableViewStylePlain];
    
    _myTableView.dataSource = self;
    
    _myTableView.delegate = self;
    
    _myTableView.rowHeight = 58;
    
    if (MY_MACRO_NAME) {
        _myTableView.separatorInset = UIEdgeInsetsZero;
    }
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    
    
    UIView * vvv = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    _myTableView.tableFooterView = vvv;
    
}



-(float)returnPopViewHeightWithCount:(int)theCount
{
    int row = (theCount%3?1:0)+theCount/3;
    
    return 20+44*row + 12;
}




#pragma mark-UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data_array.count;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailClassifyModel * aModel = [_data_array objectAtIndex:indexPath.row];
    
    return identifierHidden[indexPath.row]?([self returnPopViewHeightWithCount:aModel.TClassChildren.count]+51):58;
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
    
    
    DetailClassifyModel * aModel = [_data_array objectAtIndex:indexPath.row];
    
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(12,21,280,16)];
    
    title_label.text = aModel.TClassValue;
    
    title_label.textAlignment = NSTextAlignmentLeft;
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.font = [UIFont systemFontOfSize:15];
    
    [cell.contentView addSubview:title_label];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,0.5)];
    
    lineView.backgroundColor = RGBCOLOR(198,198,198);
    
    [cell.contentView addSubview:lineView];
    
    UIImageView * jiantouImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:identifierHidden[indexPath.row]?@"ZMalljiantou-down_31x18.png":@"ZMalljiantou-up_31x18.png"]];
    
    jiantouImageView.center = CGPointMake(300,29);
    
    [cell.contentView addSubview:jiantouImageView];
    
    
    if (identifierHidden[indexPath.row]) {
        
        ClassifyPopView * popView = [[ClassifyPopView alloc] initWithFrame:CGRectMake(0,51,320,[self returnPopViewHeightWithCount:aModel.TClassChildren.count])];
        
        popView.clipsToBounds = YES;
        
        popView.tag = 100;
        
        [popView setAllViewsWithContent:aModel.TClassChildren];
        
        [cell.contentView addSubview:popView];
    }
    
    
    if (indexPath.row == _data_array.count-1) {
        UIView * footLine = [[UIView alloc] initWithFrame:CGRectMake(0,57.5,320,0.5)];
        
        footLine.backgroundColor = RGBCOLOR(198,198,198);
        
        [cell.contentView addSubview:footLine];
    }
    
 
    return cell;
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rows = 900000000;
    
    for (int i = 0;i < _theModel.ClassCates.count;i++)
    {
        if (identifierHidden[i] && i != indexPath.row)
        {
            identifierHidden[i] = !identifierHidden[i];
            
            rows = i;
        }
    }
    
    identifierHidden[indexPath.row] = !identifierHidden[indexPath.row];
    
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:rows==900000000?indexPath:[NSIndexPath indexPathForRow:rows inSection:0]];
    
    ClassifyPopView * view = (ClassifyPopView *)[cell.contentView viewWithTag:100];
    
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(0,51,320,0);
    
    } completion:^(BOOL finished) {
        
    }];
    
    if (rows == 900000000) {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    }else
    {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,[NSIndexPath indexPathForRow:rows inSection:0],nil] withRowAnimation:UITableViewRowAnimationFade];
    }
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
