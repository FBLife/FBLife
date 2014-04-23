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
                
                _buyersHeaderImageView.backgroundColor = [UIColor redColor];
                
                [self.contentView addSubview:_buyersHeaderImageView];
            }
            
            if (!_buyersUserNameLabel) {
                _buyersUserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(86,20,100,15)];
                
                _buyersUserNameLabel.textAlignment = NSTextAlignmentLeft;
                
                _buyersUserNameLabel.textColor = [UIColor blackColor];
                
                _buyersUserNameLabel.font = [UIFont systemFontOfSize:14];
                
                [self.contentView addSubview:_buyersUserNameLabel];
            }
            
            if (!_buyTimeLabel) {
                _buyTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(190,20,100,15)];
                
                _buyTimeLabel.textAlignment = NSTextAlignmentLeft;
                
                _buyTimeLabel.font = [UIFont systemFontOfSize:13];
                
                _buyTimeLabel.textColor = RGBCOLOR(176,176,176);
                
                [self.contentView addSubview:_buyTimeLabel];
            }
            
            if (!_commentsContentLabel) {
                _commentsContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(86,35+23/2,222.5,38)];
                
                _commentsContentLabel.textColor = RGBCOLOR(125,125,125);
                
                _commentsContentLabel.textAlignment = NSTextAlignmentLeft;
                
                _commentsContentLabel.numberOfLines = 2;
                
                _commentsContentLabel.font = [UIFont systemFontOfSize:15];
                
                [self.contentView addSubview:_commentsContentLabel];
            }
            
            if (!_commentsStarsImageView) {
                _commentsStarsImageView = [[EvaluationStars alloc] initWithFrame:CGRectMake(86,85,250,16)];
                
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
//    [_buyersHeaderImageView loadImageFromURL:info.PMerchantsImage withPlaceholdImage:nil];
    
    
    info.PName = @"静静兰花香";
    
    
    CGPoint thePoint = [zsnApi LinesWidth:info.PName Label:_buyersUserNameLabel font:[UIFont systemFontOfSize:14] linebreak:NSLineBreakByCharWrapping];
    
    CGRect rect = _buyersUserNameLabel.frame;
    
    _buyersUserNameLabel.text = info.PName;
    
    rect.origin.x = thePoint.x+10;
    
    rect.size.width = 310 - rect.origin.x;
    
    _buyTimeLabel.frame = rect;
    
    _buyTimeLabel.text = @"(2014-03-21 12:16:27)";
    
    _commentsContentLabel.text = @"全5分吧，虽然中间物流出点岔子，但是店家服务态度很好很好很好。";
    
    [_commentsStarsImageView loadStarsWithCount:3];
    
    
}





- (void)awakeFromNib
{
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end


















