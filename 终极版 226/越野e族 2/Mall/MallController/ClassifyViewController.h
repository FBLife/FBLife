//
//  ClassifyViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentView.h"

@interface ClassifyViewController : MyViewController
<UITableViewDataSource,UITableViewDelegate,CustomSegmentViewDelegate>

{
    
    
    
    
}

@property(nonatomic,strong)NSString *str_id;

@property(nonatomic,strong)UITableView *MainTabView;

@end
