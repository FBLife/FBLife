//
//  DetailClassifyCellView.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-26.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailClassifyCellView.h"

@implementation DetailClassifyCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    _headImageview=[[AsyncImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
    _headImageview.backgroundColor=[UIColor redColor];
    [self addSubview:_headImageview];
    
    _MainTitle=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 100, 16)];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
