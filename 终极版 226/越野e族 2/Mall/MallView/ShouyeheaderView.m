//
//  ShouyeheaderView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-22.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ShouyeheaderView.h"

@implementation ShouyeheaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=RGBCOLOR(236, 236, 236);
    }
    return self;
}

-(void)settitle:(NSString *)str_titlel{
    //title
    //右边红点185
    //字体185 16
    //上面价格的字体196 15
    UILabel *label_title=[[UILabel alloc]initWithFrame:CGRectMake(12, 11, 100, 16)];
    label_title.text=str_titlel;
    label_title.textColor=RGBCOLOR(185, 0, 0);
    label_title.font=[UIFont systemFontOfSize:16];
    [self addSubview:label_title];
    
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(0, 11, 4, 16)];
    redView.backgroundColor=RGBCOLOR(185, 0, 0);
    [self addSubview:redView];

    
    
    
    
    
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
