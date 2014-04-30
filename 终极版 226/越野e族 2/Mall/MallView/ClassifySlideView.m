//
//  ClassifySlideView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-29.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ClassifySlideView.h"

@interface ClassifySlideViewmodel : NSObject

/**
 *  (
 {
 "cate_id" = 794;
 "cate_name" = "e\U65cf\U670d\U9970";
 count = 39;
 },
 {
 "cate_id" = 363;
 "cate_name" = "\U6388\U6743\U4ea7\U54c1";
 count = 7;
 },
 {
 "cate_id" = 362;
 "cate_name" = "\U8f66\U6807";
 count = 5;
 }
 );
 */

@property(nonatomic,strong)NSString *cate_id;

@property(nonatomic,strong)NSString *cate_name;

@property(nonatomic,strong)NSString *count;


-(void)setdicinfo:(NSDictionary *)dic_;




@end

@implementation ClassifySlideViewmodel

-(void)setdicinfo:(NSDictionary *)dic_{
    
    self.cate_id=[NSString stringWithFormat:@"%@",[dic_ objectForKey:@"cate_id"]];
    self.cate_name=[NSString stringWithFormat:@"%@",[dic_ objectForKey:@"cate_name"]];
    self.count=[NSString stringWithFormat:@"%@",[dic_ objectForKey:@"count"]];

    
}


@end



@implementation ClassifySlideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


-(void)ClassifySlideViewSetArray:(NSArray *)_arr bloc:(mybloc)bloccopy{
    _bloc=bloccopy;
    
 
    
    UIScrollView *_ScroV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 38, 320, 133)];
    _ScroV.showsHorizontalScrollIndicator=NO;
    _ScroV.showsVerticalScrollIndicator=NO;
    _ScroV.backgroundColor=[UIColor clearColor];
    _ScroV.pagingEnabled=NO;
    _ScroV.contentSize=CGSizeMake(_arr.count*320/5, 0);
    [self addSubview:_ScroV];

    
    UIImageView * silderImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ZMallline_78x4.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
    silderImageView.backgroundColor = [UIColor clearColor];
    silderImageView.tag = 99;
//    silderImageView.frame = CGRectMake(0, 34, 80, 2);
    
    [self addSubview:silderImageView];

    
    for (int i=0; i<_arr.count; i++) {
        NSDictionary *dic=[NSDictionary dictionary];
        dic=[_arr objectAtIndex:i];
        ClassifySlideViewmodel *_model=[[ClassifySlideViewmodel alloc]init];
        [_model setdicinfo:dic];
        
        UIButton  *_button=[[UIButton alloc]initWithFrame:CGRectMake(i*80, 0, 80, 34)];
        [_button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        _button.tag=[_model.cate_id integerValue];
        [_ScroV addSubview:_button];
        [self addSubview:_button];
        
        
        
        _button.backgroundColor=[UIColor whiteColor];
        [_button setTitle:_model.cate_name forState:UIControlStateNormal];
        [_button setTitle:_model.cate_name forState:UIControlStateSelected];
        [_button setTitle:_model.cate_name forState:UIControlStateHighlighted];
        _button.titleLabel.font=[UIFont systemFontOfSize:15];
        
        if (i==0) {
            _pretag=_button.tag;
            silderImageView.frame = CGRectMake(0, 34, _model.cate_name.length*18, 2);
            silderImageView.center=CGPointMake(40, 35);

            [_button setTitleColor:RGBCOLOR(177, 9, 19) forState:UIControlStateNormal];
            

        }else{
            [_button setTitleColor:RGBCOLOR(2, 2, 2) forState:UIControlStateNormal];

            
        }
//        [_button setTitleColor:RGBCOLOR(2, 2, 2) forState:UIControlStateNormal];
//        [_button setTitleColor:RGBCOLOR(177, 9, 19) forState:UIControlStateNormal];
//        [_button setTitleColor:RGBCOLOR(177, 9, 19) forState:UIControlStateNormal];

        
    }
    
    
}

-(void)dobutton:(UIButton *)sender{
    //找到先前的button，让他变颜色
    
    UIButton *prebutton=(UIButton *)[self viewWithTag:_pretag];
    [prebutton setTitleColor:RGBCOLOR(2, 2, 2) forState:UIControlStateNormal];
    [sender setTitleColor:RGBCOLOR(177, 9, 19) forState:UIControlStateNormal];

    _pretag=sender.tag;
    
    UIImageView * imageView = (UIImageView *)[self viewWithTag:99];
    imageView.hidden=NO;
    
    
    NSLog(@"tag=========%d",sender.tag);
    
    
    [UIView animateWithDuration:0.3 animations:^{
        //动画内容
        
        imageView.frame = CGRectMake(sender.frame.origin.x+(80-sender.titleLabel.text.length*18)/2, 34, sender.titleLabel.text.length*18, 2);
        
        imageView.center = CGPointMake(40+sender.frame.origin.x,35);

        
    }completion:^(BOOL finished)
     
     {
         
 
         
     }];
    
    
 
    
    _bloc(sender.tag);
    
    
    
    
    
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
