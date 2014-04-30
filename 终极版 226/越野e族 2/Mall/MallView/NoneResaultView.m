//
//  NoneResaultView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "NoneResaultView.h"

@implementation NoneResaultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    UIImageView *imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MallNoneresault.png"]];
    imgv.center=CGPointMake(0, self.frame.size.height/2);
    [self addSubview:imgv];
    return self;
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
