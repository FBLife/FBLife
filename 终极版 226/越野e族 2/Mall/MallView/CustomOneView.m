//
//  CustomOneView.m
//  越野e族
//
//  Created by gaomeng on 14-4-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "CustomOneView.h"
#import "SellersDetailView.h"


@implementation CustomOneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //图片
        self.imv = [[AsyncImageView alloc]init];
        self.imv.frame = CGRectMake(0, 0, 145, 145);
        [self.imv loadImageFromURL:nil withPlaceholdImage:[UIImage imageNamed:@"big_moren640x324.png"]];
        
        
        //介绍
        self.jianjieLb = [[UILabel alloc]init];
        self.jianjieLb.font = [UIFont systemFontOfSize:13];
        self.jianjieLb.numberOfLines = 2;
        self.jianjieLb.frame = CGRectMake(6, CGRectGetMaxY(self.imv.frame)+3, self.imv.frame.size.width-12, 35);
        
        
        //价格:
        self.plb = [[UILabel alloc]init];
        self.plb.text = @"价格:";
        self.plb.frame = CGRectMake(6, CGRectGetMaxY(self.jianjieLb.frame)+5, 35, 25);
        self.plb.textColor = [UIColor grayColor];
        self.plb.font = [UIFont systemFontOfSize:12];
        
        //价格
        self.plb1 = [[UILabel alloc]init];
        self.plb1.textColor = [UIColor redColor];
        self.plb1.frame = CGRectMake(CGRectGetMaxX(self.plb.frame)+5, self.plb.frame.origin.y, 100, 25);
        
        
        //调试颜色
//        self.imv.backgroundColor = [UIColor redColor];
//        self.jianjieLb.backgroundColor = [UIColor orangeColor];
//        self.plb.backgroundColor = [UIColor yellowColor];
//        self.plb1.backgroundColor = [UIColor greenColor];
        
        
        
        //添加视图
        [self addSubview:self.imv];
        [self addSubview:self.jianjieLb];
        [self addSubview:self.plb];
        [self addSubview:self.plb1];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}








@end
