//
//  ProductCunstomTableViewCell.m
//  越野e族
//
//  Created by soulnear on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ProductCustomCell.h"

@implementation ProductCustomCell
@synthesize buyersHeaderImageView = _buyersHeaderImageView;
@synthesize buyersUserNameLabel = _buyersUserNameLabel;
@synthesize buyTimeLabel = _buyTimeLabel;
@synthesize commentsContentLabel = _commentsContentLabel;
@synthesize commentsStarsImageView = _commentsStarsImageView;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


-(void)setAllViewsWithCellType:(ProductCellType)theType
{
    switch (theType) {
        case ProductCellTypeDetail:
            
            break;
            
        case ProductCellTypeEvaluation:
        {
            if (!_buyersHeaderImageView) {
                _buyersHeaderImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(23/2,20,60,50)];
                
                [self.contentView addSubview:_buyersHeaderImageView];
            }
            
            if (!_buyersUserNameLabel) {
                _buyersUserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(86,20,100,15)];
                
                _buyersUserNameLabel.textAlignment = NSTextAlignmentLeft;
                
                _buyersUserNameLabel.textColor = [UIColor blackColor];
                
                _buyersUserNameLabel.font = [UIFont systemFontOfSize:15];
                
                [self.contentView addSubview:_buyersUserNameLabel];
            }
            
            if (!_buyTimeLabel) {
                _buyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190,20,100,15)];
                
                _buyTimeLabel.textAlignment = NSTextAlignmentLeft;
                
                _buyTimeLabel.font = [UIFont systemFontOfSize:15];
                
                _buyTimeLabel.textColor = RGBCOLOR(176,176,176);
                
                [self.contentView addSubview:_buyTimeLabel];
            }
            
            if (!_commentsContentLabel) {
                _commentsContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(86,35+23/2,222.5,15)];
                
                _commentsContentLabel.textColor = RGBCOLOR(125,125,125);
                
                _commentsContentLabel.textAlignment = NSTextAlignmentLeft;
                
                _commentsContentLabel.font = [UIFont systemFontOfSize:15];
                
                [self.contentView addSubview:_commentsContentLabel];
            }
            
            if (!_commentsStarsImageView) {
                _commentsStarsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(86,0,200,15)];
                
                [self.contentView addSubview:_commentsStarsImageView];
            }
            
        }
            break;
            
        case ProductCellTypeIntroduce:
            
            break;
            
        default:
            break;
    }
}



-(void)setInfoWithProductInfo:(ProductModel *)info
{
    [_buyersHeaderImageView loadImageFromURL:info.PMerchantsImage withPlaceholdImage:nil];
    
    CGPoint thePoint = [zsnApi LinesWidth:info.PName Label:_buyersUserNameLabel font:[UIFont systemFontOfSize:15] linebreak:NSLineBreakByCharWrapping];
    
    CGRect rect = _buyersUserNameLabel.frame;
    
    _buyersUserNameLabel.text = info.PName;
    
    rect.origin.x = rect.origin.x + thePoint.x;
    
    _buyTimeLabel.frame = rect;
    
    _buyTimeLabel.text = @"(2014-03-21 12:16:27)";

    
    
}





- (void)awakeFromNib
{
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end


















