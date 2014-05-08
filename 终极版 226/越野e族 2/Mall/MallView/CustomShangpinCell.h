//
//  CustomShangpinCell.h
//  越野e族
//
//  Created by gaomeng on 14-4-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellersModel.h"
#import "CustomOneView.h"



typedef void (^spChooseBlock)(int tag);

@interface CustomShangpinCell : UITableViewCell

@property(nonatomic,strong)NSArray *CustomOneviewsArray;//两个CustomOneView的数组

@property(nonatomic,strong)CustomOneView *oneView1;//包含异步图片 3个label
@property(nonatomic,strong)CustomOneView *oneView2;

//两个button
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;

//代码块
@property(nonatomic,strong)spChooseBlock spChooseBlock;

//设置代码块
-(void)setSpChooseBlock:(spChooseBlock)_block;

//用一个商家实例初始化自定义单元格
-(void)configWithSeller:(SellersModel*)seller;


//用一个数组初始化自定义cell
-(void)configWithArray:(NSMutableArray *)shangpinArray indexPath:(NSIndexPath*)theIndexPath;

//清空数据
-(void)cleanData;



@end
