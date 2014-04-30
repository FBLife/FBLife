//
//  FiveStareView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "FiveStareView.h"



@implementation FiveStareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=RGBCOLOR(236, 236, 236);
 
        
    
    }
    return self;
}

-(void)setArray:(NSArray *)arrayInfo block:(fiveStarbuttonTarget)block{
    
    _mybloc=block;

    for (UIView *aview in self.subviews) {
        [aview removeFromSuperview];
    }
    
    header=[[ShouyeheaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 38)];
    [header settitle:@"五星商家"];
    [self addSubview:header];
    
    _scroV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 38, 320, 48)];
    _scroV.showsVerticalScrollIndicator=NO;
    _scroV.showsHorizontalScrollIndicator=NO;
    _scroV.delegate=self;
    _scroV.scrollEnabled=YES;
    [self addSubview:_scroV];
    _scroV.backgroundColor=[UIColor whiteColor];
    _scroV.contentSize=CGSizeMake(56*arrayInfo.count, 0);

    
    
    NSLog(@"xxx=%d",arrayInfo.count);
    
    for (int i=0; i<arrayInfo.count; i++) {
        
        
        NSString *str_imgUrl=[[arrayInfo objectAtIndex:i] objectForKey:@"default_image"];
        _imgV=[[AsyncImageView alloc]initWithFrame:CGRectMake(i*56, (48-25)/2, 54, 25)];//这个cell的高度是48，居中显示
        [_imgV loadImageFromURL:str_imgUrl withPlaceholdImage:nil];
        [_scroV addSubview:_imgV];
        
        
        int  str_mallId=[[[arrayInfo objectAtIndex:i] objectForKey:@"link"] integerValue];
        UIButton *_button=[[UIButton alloc]initWithFrame:CGRectMake(i*56, (48-25)/2, 108/2, 50/2)];
        [_button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        _button.tag=str_mallId;
        _button.backgroundColor=[UIColor clearColor];
       [_scroV addSubview:_button];
        
    }
    
    
    
    
    
    
    
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    
    
    
}

-(void)dobutton:(UIButton *)sender{
    _mybloc(sender.tag);
    
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
