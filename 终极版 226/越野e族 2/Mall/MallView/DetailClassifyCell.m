//
//  DetailClassifyCell.m
//  越野e族
//
//  Created by soulnear on 14-5-5.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "DetailClassifyCell.h"

@implementation DetailClassifyCell
@synthesize headImageview = _headImageview;
@synthesize MainTitleLabel = _MainTitleLabel;
@synthesize ClassifyLabel = _ClassifyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_headImageview)
        {
            _headImageview=[[AsyncImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
//            [_headImageview loadImageFromURL:nil withPlaceholdImage:[UIImage imageNamed:@"tongxun.png"]];
            _headImageview.image = [UIImage imageNamed:@"tongxun.png"];
            [self.contentView addSubview:_headImageview];
        }
        
        
        
        if (!_MainTitleLabel) {
            _MainTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 220, 16)];
            _MainTitleLabel.backgroundColor=[UIColor clearColor];
            _MainTitleLabel.textColor=[UIColor blackColor];
            _MainTitleLabel.font=[UIFont systemFontOfSize:16];
            [self.contentView addSubview:_MainTitleLabel];
        }
        
        
        if (!_ClassifyLabel) {
            _ClassifyLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 50, 220, 12)];
            _ClassifyLabel.backgroundColor=[UIColor clearColor];
            _ClassifyLabel.font=[UIFont systemFontOfSize:11];
            _ClassifyLabel.textColor=RGBCOLOR(144, 144, 144);
            [self.contentView addSubview:_ClassifyLabel];
        }
    }
    return self;
}


-(void)loadContentWithDetailClassifyModel:(DetailClassifyModel *)model
{
    _MainTitleLabel.text = model.ClassDefaultCate;

    [_headImageview loadImageFromURL:model.ClassDefaultImage withPlaceholdImage:[UIImage imageNamed:@""]];
    
    NSMutableString * exampleString = [NSMutableString stringWithString:@""];
    
    for (NSDictionary * aDic in model.ClassCates) {
                
        [exampleString appendString:[NSString stringWithFormat:@"%@ ",[aDic objectForKey:@"cate_name"]]];
    }
    
    _ClassifyLabel.text = exampleString;
}





- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
