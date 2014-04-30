//
//  MainMallSearchViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMallSearchViewController : MyViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *MainTabView;

@property(nonatomic,strong)UITableView *SecondTableview;


@property(nonatomic,strong)NSString * searchgoodsnameString;


@end
