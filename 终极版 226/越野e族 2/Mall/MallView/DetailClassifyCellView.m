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
        
        self.backgroundColor=[UIColor clearColor];
        //1
        
        
        if (!_headImageview) {
            _headImageview=[[AsyncImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
            [_headImageview loadImageFromURL1:nil withPlaceholdImage:[UIImage imageNamed:@"bigimplace.png"]];
            _headImageview.backgroundColor=[UIColor redColor];
            [self addSubview:_headImageview];
        }
        
        
        
        //2
        _MainTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 100, 16)];
        _MainTitleLabel.backgroundColor=[UIColor clearColor];
        _MainTitleLabel.textColor=[UIColor blackColor];
        _MainTitleLabel.font=[UIFont systemFontOfSize:16];
        [self addSubview:_MainTitleLabel];
        
        //3
        
        _ClassifyLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 50, 220, 12)];
        _ClassifyLabel.backgroundColor=[UIColor clearColor];
        _ClassifyLabel.font=[UIFont systemFontOfSize:11];
        _ClassifyLabel.textColor=RGBCOLOR(144, 144, 144);
        [self addSubview:_ClassifyLabel];
        //4
        UIView *view_xian=[[UIView alloc]initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
        view_xian.backgroundColor=RGBCOLOR(198, 198, 198);
        [self addSubview:view_xian];
        
    }
    return self;
}

-(void)settitleWithString:(NSString *)titleStr _ClassifyLabelText:(NSString *)classfyStr{
    
    while ([classfyStr rangeOfString:@"  "].length) {
        classfyStr=[classfyStr stringByReplacingOccurrencesOfString:@"  " withString:@"s"];
    }
    
    while ([classfyStr rangeOfString:@"s"].length) {
        classfyStr=[classfyStr stringByReplacingOccurrencesOfString:@"s" withString:@"    "];
    }
    
    _MainTitleLabel.text=titleStr;
    _ClassifyLabel.text=classfyStr;
    
}
-(void)layoutSubviews{
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
