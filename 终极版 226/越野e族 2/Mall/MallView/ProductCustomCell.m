//
//  ProductCunstomTableViewCell.m
//  越野e族
//
//  Created by soulnear on 14-4-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "ProductCustomCell.h"



@implementation SellerInfoView
@synthesize delegate = _delegate;

-(SellerInfoView *)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        headerImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(12,39/2,106/2,110/2)];
        
        headerImageView.layer.borderColor = RGBACOLOR(208,208,208,1).CGColor;
        
        headerImageView.layer.borderWidth = 0.5;
        
        [self addSubview:headerImageView];
        
        
        sellerName = [[UILabel alloc] initWithFrame:CGRectMake(12+53+27/2,39/2,240,15)];
        
        sellerName.textAlignment = NSTextAlignmentLeft;
        
        sellerName.textColor = [UIColor blackColor];
        
        sellerName.backgroundColor = [UIColor clearColor];
        
        sellerName.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:sellerName];
        
        
        MessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        MessageButton.frame = CGRectMake(158/2,46,187/2,59/2);
        
        [MessageButton setImage:[UIImage imageNamed:@"ZMallmessage_187x59.png"] forState:UIControlStateNormal];
        
        [MessageButton addTarget:self action:@selector(PushToMessageVC:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:MessageButton];
        
        
        telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        telephoneButton.frame = CGRectMake(375/2,46,187/2,59/2);
    
        [telephoneButton setImage:[UIImage imageNamed:@"ZMalltelephone_187x59.png"] forState:UIControlStateNormal];
        
        [telephoneButton addTarget:self action:@selector(CallSeller:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:telephoneButton];
        
    }
    
    return self;
}


-(void)SellerInfoViewData:(SellerInfo *)infomation
{
    theInfo = infomation;
    
    [headerImageView loadImageFromURL:infomation.SStoreLogo withPlaceholdImage:[UIImage imageNamed:@"touxiang.png"]];
    sellerName.text = infomation.SStoreName;
}


-(void)PushToMessageVC:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(pushToChatViewControllerWith:)]) {
        [_delegate pushToChatViewControllerWith:theInfo];
    }
}

-(void)CallSeller:(UIButton *)sender
{
    UIApplication * app = [UIApplication sharedApplication];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",theInfo.STelephone]];
        
    if ([app canOpenURL:url])
    {
        [app openURL:url];
    }else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您当前设备不支持此功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        
        [alert show];
    }
}




@end








@implementation ProductCustomCell
@synthesize myWebView = _myWebView;
@synthesize buyersHeaderImageView = _buyersHeaderImageView;
@synthesize buyersUserNameLabel = _buyersUserNameLabel;
@synthesize buyTimeLabel = _buyTimeLabel;
@synthesize commentsContentLabel = _commentsContentLabel;
@synthesize commentsStarsImageView = _commentsStarsImageView;
@synthesize myInfoView = _myInfoView;



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
            if (!_myWebView) {
                _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,(iPhone5?568:480)-35.5-44-(MY_MACRO_NAME?20:0))];
                
                [self.contentView addSubview:_myWebView];
            }
            break;
            
        case ProductCellTypeEvaluation:
        {
            if (!_buyersHeaderImageView) {
                
                _buyersHeaderImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(23/2,20,60,60)];
                
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
                _commentsContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(86,35+9,222.5,38)];
                
                _commentsContentLabel.textColor = RGBCOLOR(125,125,125);
                
                _commentsContentLabel.textAlignment = NSTextAlignmentLeft;
                
                _commentsContentLabel.numberOfLines = 2;
                
                _commentsContentLabel.font = [UIFont systemFontOfSize:15];
                
                [self.contentView addSubview:_commentsContentLabel];
            }
            
            if (!_commentsStarsImageView) {
                _commentsStarsImageView = [[EvaluationStars alloc] initWithFrame:CGRectMake(86,90,250,16)];
                
                [self.contentView addSubview:_commentsStarsImageView];
            }
            
        }
            break;
            
        case ProductCellTypeIntroduce:
        {
            if (!_myInfoView) {
                _myInfoView = [[SellerInfoView alloc] initWithFrame:CGRectMake(0,0,320,93)];
                
                [self.contentView addSubview:_myInfoView];
            }
        }
            
            break;
            
        default:
            break;
    }
}



-(void)setInfoWithProductInfo:(ProductModel *)info WithType:(ProductCellType)theType
{
    switch (theType) {
        case ProductCellTypeDetail:
            
            self.myWebView.hidden = NO;
            [self.myWebView loadHTMLString:info.PDetails baseURL:[[NSBundle mainBundle] resourceURL]];
            break;
        case ProductCellTypeEvaluation:
        {
            self.buyersHeaderImageView.hidden = NO;
            self.commentsContentLabel.hidden = NO;
            self.buyTimeLabel.hidden = NO;
            self.commentsStarsImageView.hidden = NO;
            self.buyersUserNameLabel.hidden = NO;
            
            [_buyersHeaderImageView loadImageFromURL:[NSString stringWithFormat:@"http://bbs.fblife.com/ucenter//avatar.php?uid=%@&type=virtual&size=middle",info.BuyerId] withPlaceholdImage:[UIImage imageNamed:@"touxiang.png"]];
            
            CGPoint thePoint = [zsnApi LinesWidth:info.BuyerName Label:_buyersUserNameLabel font:[UIFont systemFontOfSize:14] linebreak:NSLineBreakByCharWrapping];
            
            CGRect rect = _buyersUserNameLabel.frame;
            
            _buyersUserNameLabel.text = info.BuyerName;
            
            rect.origin.x = thePoint.x+10;
            
            rect.size.width = 310 - rect.origin.x;
            
            _buyTimeLabel.frame = rect;
            
            _buyTimeLabel.text = [zsnApi timechangeByAll:info.CommentsTime];
            
            _commentsContentLabel.text = info.CommentsContent;
            
            
            if (info.CommentsContent.length == 0 || [info.CommentsContent isEqual:@""]) {
                CGRect starsFrame = _commentsStarsImageView.frame;
                
                starsFrame.origin.y = 60;
                
                _commentsStarsImageView.frame = starsFrame;
            }else
            {
                _commentsStarsImageView.frame = CGRectMake(86,90,250,16);
            }
            
            
            if ([info.CommentsEvaluation intValue] == 0) {
                _commentsStarsImageView.hidden = YES;
            }else
            {
                [_commentsStarsImageView loadStarsWithCount:[info.CommentsEvaluation intValue]];
            }
        }
            break;
        case ProductCellTypeIntroduce:
            
            break;
        default:
            break;
    }
}


- (void)awakeFromNib
{
    
}


-(void)dealloc
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    self.buyersHeaderImageView = nil;
    
    self.buyersUserNameLabel = nil;
    
    self.buyTimeLabel = nil;
    
    self.commentsContentLabel = nil;
    
    self.commentsStarsImageView = nil;
    
    self.myInfoView = nil;
    
    self.myWebView = nil;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   
}

@end


















