//
//  MainFourClassicView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-28.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainFourClassicView.h"
#import "ShouyeheaderView.h"
/**
 *  img_type: "1",
 title: "越野e族超大容量移动便携充电宝 ",
 price: "78.00",
 link: "http://mall.fblife.com/index.php?app=goods&id=9695",
 cate1: "服饰鞋帽",
 cate2: "e族服饰",
 default_image: "http://mall.fblife.com/data/files/mallindex/goods_sort/20140418/20140418175344.jpg"
 */

@interface MainFourClassicViewmodel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *link;
@property (nonatomic,strong)NSString *cate1;
@property (nonatomic,strong)NSString *cate2;
@property (nonatomic,strong)NSString *default_image;

-(void)setdic:(NSDictionary *)dic;
@end

@implementation MainFourClassicViewmodel

-(void)setdic:(NSDictionary *)dic{
    
    self.title=[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    self.price=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    self.link=[NSString stringWithFormat:@"%@",[dic objectForKey:@"link"]];
    self.cate1=[NSString stringWithFormat:@"%@",[dic objectForKey:@"cate1"]];
    self.cate2=[NSString stringWithFormat:@"%@",[dic objectForKey:@"cate2"]];
    self.default_image=[NSString stringWithFormat:@"%@",[dic objectForKey:@"default_image"]];
    
    
}


@end



@implementation MainFourClassicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=RGBCOLOR(209, 209, 209);

    }
    return self;
}

-(void)setArr:(NSArray *)arr_   bloc:(fourbloc)_bloc {
    
    
    _Mybloc=_bloc;
    
    
    
    NSLog(@"fourarray====%@",arr_);
    
    for (UIView *aview in self.subviews) {
        [aview removeFromSuperview];
    }
    
    for (UIView *aview in self.subviews) {
        [aview removeFromSuperview];
    }
    
    
    ShouyeheaderView *header=[[ShouyeheaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 38)];
    [header settitle:_str_title];
    [self addSubview:header];
    _ScroV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 38, 320, 133)];
    _ScroV.showsHorizontalScrollIndicator=NO;
    _ScroV.showsVerticalScrollIndicator=NO;
    _ScroV.backgroundColor=[UIColor clearColor];
    _ScroV.pagingEnabled=NO;
    [self addSubview:_ScroV];

    _ScroV.contentSize=CGSizeMake(arr_.count*320/3, 0);


    
    
    
    for (int i=0; i<arr_.count; i++) {
        
        
        NSDictionary *dic=[NSDictionary dictionary];
       dic= (NSDictionary *)[arr_ objectAtIndex:i];
        
        
        
        NSLog(@"dic===xxxx====%@",dic);
        MainFourClassicViewmodel *_model=[[MainFourClassicViewmodel alloc]init];
        [_model setdic:dic];
        UIButton  *_button=[[UIButton alloc]initWithFrame:CGRectMake(i*106, 0, 105.5, 133)];
        [_button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        _button.tag=[_model.link integerValue];
        [_ScroV addSubview:_button];
        _button.backgroundColor=[UIColor whiteColor];
        
        AsyncImageView *imgV=[[AsyncImageView alloc]initWithFrame:CGRectMake(2.25, 0, 100, 100)];
        [_button addSubview:imgV];
        [imgV loadImageFromURL:_model.default_image withPlaceholdImage:nil];
        
        UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 105.5, 15)];
        [_button addSubview:title_label];
        title_label.backgroundColor=[UIColor clearColor];
        title_label.text=_model.title;
        title_label.font=[UIFont systemFontOfSize:13];
        
        
        UILabel *price_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 115, 105.5, 15)];
        [_button addSubview:price_label];
        price_label.text=[NSString stringWithFormat:@"￥%@",_model.price];
        price_label.backgroundColor=[UIColor clearColor];
        price_label.textColor=RGBCOLOR(191, 11, 23);
        price_label.font=[UIFont systemFontOfSize:14];
        
        _str_title=_model.cate1;
        
        
    }
    

    

    
    
}

-(void)dobutton:(UIButton *)sender{
    _Mybloc(sender.tag);
    
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
