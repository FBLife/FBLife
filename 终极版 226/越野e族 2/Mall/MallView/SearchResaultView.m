//
//  SearchResaultView.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

/**
 *  {
 "add_time" = 1392938068;
 brand = "\U8d8a\U91cee\U65cf";
 "cate_id" = 802;
 "cate_name" = "\U4e3b\U9898\U6587\U5316\U7cfb\U5217\te\U65cf\U670d\U9970\t\U5176\U4ed6";
 closed = 0;
 "color_rgb" = "";
 comments = 0;
 "credit_image" = "http://malltest.fblife.com/themes/mall/default/styles/default/images/heart_1.gif";
 "credit_value" = 0;
 "default_image" = "http://mall.fblife.com/data/files/store_126020/goods_174/small_201402211512546457.jpg";
 "goods_id" = 9691;
 "goods_name" = "\U8d8a\U91cee\U65cf2014\U6f6e\U7537\U7ae5T\U6064 \U7eaf\U68c9\U5047\U4e24\U4ef6t\U6064 \U5370\U82b1\U5706\U9886\U4fee\U8eabT\U6064 YCMT-017";
 "goods_sort" = 225;
 "grade_name" = "\U9ad8\U7ea7\U5e97\U94fa";
 "if_show" = 1;
 newgoods = 1;
 price = "150.00";
 "recom_sort" = 0;
 recommended = 1;
 "region_id" = 278;
 "region_name" = "\U5e7f\U4e1c\U7701";
 sales = 0;
 sgrade = 3;
 "spec_1" = "\U9ed1\U8272";
 "spec_2" = 120;
 "spec_id" = 12201;
 "spec_name_1" = "\U989c\U8272";
 "spec_name_2" = "\U5c3a\U7801";
 "spec_qty" = 2;
 stock = 5;
 "store_id" = 126020;
 "store_name" = "e\U65cf\U670d\U9970";
 type = material;
 views = 42;
 }
 */

@interface searchModel : NSObject
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSString *goods_name;
@property(nonatomic,strong)NSString *store_name;
@property(nonatomic,strong)NSString *default_image;
@property(nonatomic,strong)NSString *price;

-(void)searchModelSetDic:(NSDictionary*)dicinfo;

@end

@implementation searchModel

-(void)searchModelSetDic:(NSDictionary*)dicinfo{
    self.goods_id=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"goods_id"]];
    self.goods_name=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"goods_name"]];
    self.store_name=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"store_name"]];
    self.default_image=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"default_image"]];
    self.price=[NSString stringWithFormat:@"%@",[dicinfo objectForKey:@"price"]];

}

@end



#import "SearchResaultView.h"

@implementation SearchResaultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];

    }
    return self;
}
-(void)setarray:(NSArray *)arrinfo searchbloc:(MallxiangqingBloc)bloc{

    searchModel *model=[[searchModel alloc]init];
    
    for (int i=0; i<arrinfo.count; i++) {
        
        [model searchModelSetDic:[arrinfo objectAtIndex:i]];
        
        NSLog(@"default_image===%@",model.default_image);
        
        
        _mybloc = bloc;
        
        
        //整个是一个大button
        UIButton *_button=[[UIButton alloc]initWithFrame:CGRectMake(12+i*153, 0, 288/2, 438/2)];
        _button.backgroundColor=[UIColor whiteColor];
        _button.tag=[model.goods_id integerValue];
        [_button addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        //imageView,展示图
        AsyncImageView *_imgV=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 144, 144)];
        [_imgV loadImageFromURL:model.default_image withPlaceholdImage:[UIImage imageNamed:@""]];
        [_button addSubview:_imgV];
        
        //厂家和设备
        
        UILabel *goodsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 148, 144, 44)];
        goodsLabel.numberOfLines=0;
        goodsLabel.backgroundColor=[UIColor clearColor];
        goodsLabel.font=[UIFont systemFontOfSize:13];
        goodsLabel.text=[NSString stringWithFormat:@"[%@]%@",model.store_name,model.goods_name];
        [_button addSubview:goodsLabel];
        
        
        //价格label
        
        UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 148+44, 38, 15)];
        priceLabel.text=@"价格：";
        priceLabel.backgroundColor=[UIColor clearColor];
        priceLabel.font=[UIFont systemFontOfSize:12];
        priceLabel.textColor=[UIColor grayColor];
        [_button addSubview:priceLabel];
        
        
        
        //具体价格
        
        UILabel *showPriceLbel=[[UILabel alloc]initWithFrame:CGRectMake(40, 148+44, 100, 15)];
        showPriceLbel.backgroundColor=[UIColor clearColor];
        showPriceLbel.font=[UIFont systemFontOfSize:15];
        showPriceLbel.textColor=RGBCOLOR(176, 8, 19);
        showPriceLbel.text=[NSString stringWithFormat:@"￥%@",model.price];
        [_button addSubview:showPriceLbel];
    }
    
   
    
    
    
    
}

-(void)dobutton:(UIButton *)sender{
    
    _mybloc(sender.tag);
    
}

//-(void)handleImageLayout:(AsyncImageView *)tag{
//   // tag.frame=CGRectMake(0, 0, tag.image.size.width/2, tag.image.size.height/2);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
