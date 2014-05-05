//
//  DetailClassifyViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailClassifyCellView.h"
#import "DetailClassifyModel.h"
#import "DetailClassifyCell.h"
#import "MallTypeClassifyViewController.h"

@interface DetailClassifyViewController : MyViewController<UITableViewDataSource,UITableViewDelegate>{
    
    DetailClassifyModel * ClassifyModel;
}
@property(nonatomic,strong)UITableView *MainTableview;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *classArray;
@property(nonatomic,strong)DetailClassifyCellView *cellView;

@property(nonatomic,strong)NSMutableArray * data_array;

@end
