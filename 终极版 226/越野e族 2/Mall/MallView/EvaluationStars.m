//
//  EvaluationStars.m
//  越野e族
//
//  Created by soulnear on 14-4-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "EvaluationStars.h"

@implementation EvaluationStars

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * pinglunLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,35,15)];
        
        pinglunLabel.text = @"评价:";
        
        pinglunLabel.textAlignment = NSTextAlignmentLeft;
        
        pinglunLabel.font = [UIFont systemFontOfSize:15];
        
        pinglunLabel.textColor = RGBCOLOR(97,101,113);
        
        [self addSubview:pinglunLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    
}



-(void)loadStarsWithCount:(int)theCount
{
    for (int i = 0;i < 3;i++)
    {
        UIImageView * star_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40+9*i,5,17/2,16/2)];
        
        if (i == 0) {
            star_imageView.image = [UIImage imageNamed:@"ZMallhuangxing_17x16.png"];
        }else if (i == 1)
        {
            star_imageView.image = [UIImage imageNamed:theCount==1?@"Mall_gray_star_17x16.png":@"ZMallhuangxing_17x16.png"];
        }else
        {
            star_imageView.image = [UIImage imageNamed:theCount==3?@"ZMallhuangxing_17x16.png":@"Mall_gray_star_17x16.png"];
        }
        
        star_imageView.tag = 100 + i;
        
        [self addSubview:star_imageView];
    }
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
