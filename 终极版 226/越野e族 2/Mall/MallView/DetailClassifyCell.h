//
//  DetailClassifyCell.h
//  越野e族
//
//  Created by soulnear on 14-5-5.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailClassifyModel.h"

@interface DetailClassifyCell : UITableViewCell
{
    
}


@property(nonatomic,strong)AsyncImageView *headImageview;

@property(nonatomic,strong)UILabel *MainTitleLabel;

@property(nonatomic,strong)UILabel *ClassifyLabel;


-(void)loadContentWithDetailClassifyModel:(DetailClassifyModel *)model;


@end
