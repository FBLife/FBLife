//
//  DetailRecommendGoodsView.m
//  越野e族
//
//  Created by soulnear on 14-4-25.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailRecommendGoodsView.h"
#import "SellerInfo.h"

@implementation DetailRecommendGoodsView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



-(void)loadViewWithDataArray:(NSArray *)dataArray
{

    temp_array = [NSMutableArray arrayWithArray:dataArray];
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(12,19,200,15)];
    
    title_label.text = @"商家其他商品";
    
    title_label.textAlignment = NSTextAlignmentLeft;
    
    title_label.textColor = [UIColor blackColor];
    
    title_label.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:title_label];
    
    int row = (dataArray.count/2?1:0)+dataArray.count/2;
    
    
    for (int i = 0;i < row;i++) {
        for (int j = 0;j < 2;j++) {
            
            if (j+i*2 < dataArray.count) {
                SellerInfo * info = [dataArray objectAtIndex:j+i*2];
                
                CGRect rect = CGRectMake(12+152*j,46+227*i,144,144);
                
                AsyncImageView * goodsImageView = [[AsyncImageView alloc] initWithFrame:rect];
                
                [goodsImageView loadImageFromURL:info.GoodsImage withPlaceholdImage:[UIImage imageNamed:@""]];
                
                goodsImageView.tag = 100 + j + i*2;
                
                goodsImageView.userInteractionEnabled = YES;
                
                [self addSubview:goodsImageView];
                
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
                
                [goodsImageView addGestureRecognizer:tap];
                
                
                UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x+7,rect.origin.y+rect.size.height+8,130,34)];
                
                title_label.text = info.GoodsName;
                
                title_label.textAlignment = NSTextAlignmentLeft;
                
                title_label.textColor = [UIColor blackColor];
                
                title_label.font = [UIFont systemFontOfSize:14];
                
                title_label.backgroundColor = [UIColor clearColor];
                
                title_label.lineBreakMode = NSLineBreakByCharWrapping;
                
                title_label.numberOfLines = 2;
                
                [self addSubview:title_label];
                
                //25  32
                
                
                UILabel * price_label = [[UILabel alloc] initWithFrame:CGRectMake(title_label.frame.origin.x,rect.origin.y+rect.size.height+50,30,14)];
                
                price_label.textColor = RGBCOLOR(141,141,141);
                
                price_label.text = @"价格:";
                
                price_label.backgroundColor = [UIColor clearColor];
                
                price_label.textAlignment = NSTextAlignmentLeft;
                
                price_label.font = [UIFont systemFontOfSize:12.5];
                
                [self addSubview:price_label];
                
                UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(price_label.frame.origin.x+32,price_label.frame.origin.y,100,14)];
                
                price.text = [NSString stringWithFormat:@"¥ %@",info.GoodsPrice];
                
                price.textAlignment = NSTextAlignmentLeft;
                
                price.textColor = RGBCOLOR(185,0,0);
                
                price.backgroundColor = [UIColor clearColor];
                
                price.font = [UIFont systemFontOfSize:16];
                
                [self addSubview:price];
            }
        }
    }
}

-(void)doTap:(UITapGestureRecognizer *)sender
{
    SellerInfo * info = [temp_array objectAtIndex:(sender.view.tag - 100)];
    
    ProductDetailViewController * Product_detail = [[ProductDetailViewController alloc] init];
    
    Product_detail.SellerInfo = info;
    
    [[(ProductDetailViewController *)self.delegate navigationController] pushViewController:Product_detail animated:YES];
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
