//
//  MallViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-19.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShowModel.h"
@interface MallViewController : UIViewController<SlideShowModelDelegate,UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic,strong)SlideShowModel *slishouwmodels;
@property(nonatomic,strong)UITableView *MainTabView;

@end
