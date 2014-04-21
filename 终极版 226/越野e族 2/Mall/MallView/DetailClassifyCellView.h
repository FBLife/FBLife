//
//  DetailClassifyCellView.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-26.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailClassifyCellView : UIView
@property(nonatomic,strong)AsyncImageView *headImageview;
@property(nonatomic,strong)UILabel *MainTitleLabel;
@property(nonatomic,strong)UILabel *ClassifyLabel;
-(void)settitleWithString:(NSString *)titleStr _ClassifyLabelText:(NSString *)classfyStr;
@end
