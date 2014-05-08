//
//  CustomShangpinCell.m
//  越野e族
//
//  Created by gaomeng on 14-4-20.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "CustomShangpinCell.h"
#import "CustomOneView.h"






@implementation CustomShangpinCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CustomOneView *customView1 = [[CustomOneView alloc]initWithFrame:CGRectMake(12, 10, 145, 218)];
        CustomOneView *customView2 = [[CustomOneView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+8, customView1.frame.origin.y, customView1.frame.size.width, customView1.frame.size.height)];
        
        //两个btn
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn1.frame = customView1.bounds;
        [btn1 addTarget:self action:@selector(customOneViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn2.frame = customView2.bounds;
        [btn2 addTarget:self action:@selector(customOneViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [customView1 addSubview:btn1];
        [customView2 addSubview:btn2];
        
        
        //把两个view加到视图上
        [self.contentView addSubview:customView1];
        [self.contentView addSubview:customView2];
        
        
        //给属性赋值
        self.oneView1 = customView1;
        self.oneView2 = customView2;
        self.btn1 = btn1;
        self.btn2 = btn2;
        
        
        
        
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




#pragma mark - myMethod
-(void)configWithSeller:(SellersModel*)seller{
    
    
    
}

//设置block

-(void)setSpChooseBlock:(spChooseBlock)_block{
    _spChooseBlock = _block;
}



-(void)configWithArray:(NSMutableArray *)shangpinArray indexPath:(NSIndexPath*)theIndexPath{
    
    //row==0 取数组下标为0 1的元素
    //row==1 取数组下标为2 3的元素
    //row==2 取数组下标为4 5的元素
    
    int bNum1 = theIndexPath.row *2;
    //
    int bNum2 = 0;
    if (theIndexPath.row *2+2>shangpinArray.count) {
        bNum2 = bNum1;
    }else{
        bNum2 = theIndexPath.row *2+1;
    }
    
    
    NSLog(@"bnum1 = %d  bnum2 = %d",bNum1,bNum2);
    
    if (shangpinArray.count!=0) {
        self.oneView1.jianjieLb.text = [shangpinArray[bNum1]objectForKey:@"goods_name"];
        self.oneView1.plb1.text = [NSString stringWithFormat:@"￥%@",[shangpinArray[bNum1]objectForKey:@"price"]];
        [self.oneView1.imv loadImageFromURL:[shangpinArray[bNum1]objectForKey:@"default_image"] withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
        self.btn1.tag = [[shangpinArray[bNum1]objectForKey:@"goods_id"]intValue];
        
        self.oneView2.jianjieLb.text = [shangpinArray[bNum2]objectForKey:@"goods_name"];
        self.oneView2.plb1.text = [NSString stringWithFormat:@"￥%@",[shangpinArray[bNum2]objectForKey:@"price"]];
        [self.oneView2.imv loadImageFromURL:[shangpinArray[bNum2]objectForKey:@"default_image"] withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
        self.btn2.tag = [[shangpinArray[bNum2]objectForKey:@"goods_id"]intValue];
        
        if (bNum1 == bNum2) {
            self.oneView2.hidden = YES;
        }
    }
    
    
    
}


-(void)customOneViewBtnClick:(UIButton *)sender{
    //执行代码块
    if (self.spChooseBlock) {
        self.spChooseBlock(sender.tag);
    }
    
}


-(void)cleanData{
    self.oneView1.jianjieLb.text = nil;
    self.oneView1.plb1.text = nil;
    [self.oneView1.imv loadImageFromURL:nil withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    self.btn1.tag = 0;
    
    self.oneView2.jianjieLb.text = nil;
    self.oneView2.plb1.text = nil;
    [self.oneView2.imv loadImageFromURL:nil withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
    self.btn2.tag = 0;
    self.oneView2.hidden = NO;
}



@end
