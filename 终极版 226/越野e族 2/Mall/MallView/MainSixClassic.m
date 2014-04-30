//
//  MainSixClassic.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainSixClassic.h"
#import "ShouyeheaderView.h"
#import "SixClassicFeed.h"
@implementation MainSixClassic

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=RGBCOLOR(209, 209, 209);
        // Initialization code
 
    }
    return self;
}


-(void)setArray:(NSArray *)arrayInfo block:(sixbuttonTarget)block{
    
    _mybloc=block;
    
    /**
     *  {
     default_cate: "整车",
     default_image: "http://img20.fblife.com/data/files/appimg/index1.png",
     cate_name: "SUV,皮卡,房车,商务"
     },
     */
    
    for (UIView *aview in self.subviews) {
        [aview removeFromSuperview];
    }
 
    
    ShouyeheaderView *header=[[ShouyeheaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 38)];
    [header settitle:@"产品分类"];
    [self addSubview:header];
//    NSArray *array_title=[NSArray arrayWithObjects:@"整车",@"户外运动",@"改装零部件",@"自驾装备",@"数码通讯",@"服饰鞋帽", nil];
    for (int i=0; i<arrayInfo.count; i++) {
        
        NSDictionary *dic_info=[arrayInfo objectAtIndex:i];
        SixClassicFeed *feed=[[SixClassicFeed alloc]init];
        [feed SixClassicFeedSetDic:dic_info];
        

        UIButton *_button=[[UIButton alloc]initWithFrame:CGRectMake(160*(i%2), 38+(250/3)*(i/2), 159.5, 250/3-0.5)];
        [_button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        _button.backgroundColor=[UIColor whiteColor];
        _button.tag=[feed.cate_id integerValue];
        [self addSubview:_button];
        
        
        NSString *str_imgurl=[[arrayInfo objectAtIndex:i] objectForKey:@"default_image"];
        AsyncImageView *img_V=[[AsyncImageView alloc]init];
        [img_V loadImageFromURL:str_imgurl withPlaceholdImage:nil];
        img_V.delegate=self;
        img_V.tag=100+i;
        [_button addSubview:img_V];
        
        
        
        
       //大标题
        // NSString *string_title=[[arrayInfo objectAtIndex:i] objectForKey:@"default_cate"];
        UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(12, 8, 90, 15)];
        title_label.textAlignment=NSTextAlignmentLeft;
        title_label.font=[UIFont systemFontOfSize:15];
        title_label.text=feed.default_cate;
        title_label.backgroundColor=[UIColor clearColor];
        [_button addSubview:title_label];
        
        //标签
        
        UILabel *biaoqian_label=[[UILabel alloc]initWithFrame:CGRectMake(12, 25, 83, 45)];
        biaoqian_label.numberOfLines=0;
        biaoqian_label.text=feed.cates;
        biaoqian_label.font=[UIFont systemFontOfSize:12];
        biaoqian_label.textColor=RGBCOLOR(118, 118, 118);
        [_button addSubview:biaoqian_label];
        
        
        
   
        
    }
    
    
    
}


-(void)dobutton:(UIButton *)sender{
    _mybloc(sender.tag);
    
}

-(void)handleImageLayout:(AsyncImageView *)tag{
    
    
    
    tag.frame=CGRectMake(0, 0, tag.image.size.width/2, tag.image.size.height/2);
    tag.center=CGPointMake(122, 255/6);
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
