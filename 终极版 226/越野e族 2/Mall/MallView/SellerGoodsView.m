//
//  SellerGoodsView.m
//  越野e族
//
//  Created by soulnear on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "SellerGoodsView.h"

@implementation SellerGoodsView
@synthesize classifyTableView = _classifyTableView;
@synthesize delegate = _delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        identifierIsHidden[0] = 1;
        
        history_page = 0;
        
        self.backgroundColor = [UIColor blackColor];
        
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,557/2,89/2)];
        
        title_label.backgroundColor = RGBCOLOR(68,68,68);
        
        title_label.text = @"    全部商品分类";
        
        title_label.textAlignment = NSTextAlignmentLeft;
        
        title_label.textColor = [UIColor whiteColor];
        
        [self addSubview:title_label];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,89/2,557/2,0.5)];
        
        lineView.backgroundColor = RGBCOLOR(87,87,87);
        
        [self addSubview:lineView];
        
        
        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,45,557/2,(iPhone5?548:460)-45) style:UITableViewStylePlain];
        
        _classifyTableView.delegate = self;
        
        _classifyTableView.backgroundColor = RGBCOLOR(76,76,76);
        
        _classifyTableView.dataSource = self;
        
        _classifyTableView.rowHeight = 44;
        
        _classifyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:_classifyTableView];
        
    }
    return self;
}


-(void)loadViewWithContent:(NSMutableArray *)contents NameArray:(NSArray *)names
{
    
    
    data_array = [NSMutableArray arrayWithArray:contents];
    
    namesArray = [NSArray arrayWithArray:names];
    
    [_classifyTableView reloadData];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[data_array objectAtIndex:section] isEqual:[NSNull null]]) {
        return 0;
    }
    return identifierIsHidden[section]?[[data_array objectAtIndex:section] count]:0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return namesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;//单元格点击不高亮
    
    cell.backgroundColor = RGBCOLOR(76,76,76);
    
    cell.textLabel.text = [[[data_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton * header_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    header_button.backgroundColor = RGBCOLOR(68,68,68);
    
    header_button.tag  = 100 + section;
    
    header_button.frame = CGRectMake(0,0,557/2,43);
    
    [header_button addTarget:self action:@selector(OpenToShow:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(15,0,200,44)];
    
    title_label.backgroundColor = [UIColor clearColor];
    
    title_label.tag = 10;
    
    title_label.text = [namesArray objectAtIndex:section];
    
    title_label.textAlignment = NSTextAlignmentLeft;
    
    title_label.textColor = RGBCOLOR(253,253,253);
    
    title_label.userInteractionEnabled = NO;
    
    [header_button addSubview:title_label];
    
    
    UIImageView * ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250,17.5,16,9)];
    
    ImageView.image = [UIImage imageNamed:identifierIsHidden[section]?@"ZMalljiantou-2_32x18.png":@"ZMalljiantou_32x18.png"];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    ImageView.tag = 11;
    
    [header_button addSubview:ImageView];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0,43,557/2,0.5)];
    
    lineView.backgroundColor = RGBCOLOR(87,87,87);
    
    [header_button addSubview:lineView];
    
    return header_button;
}


-(void)OpenToShow:(UIButton *)sender
{
    
    if (sender.tag != history_page) {
        identifierIsHidden[history_page-100] = 0;
    }
    
    identifierIsHidden[sender.tag-100] = !identifierIsHidden[sender.tag-100];
    
    [_classifyTableView reloadData];
    
    history_page = sender.tag;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"section = %d,row = %d",indexPath.section,indexPath.row);
    
    NSLog(@"%@",[[[data_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"]);
    NSLog(@"%@",[[[data_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]);
    
    
    if (self.cellClickedBlock) {
        self.cellClickedBlock([[[data_array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]);
        
    }
    
}


-(void)setCellClickedBlock:(cellClickedBlock)cellClickedBlock{
    _cellClickedBlock = cellClickedBlock;
}

@end
