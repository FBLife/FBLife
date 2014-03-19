//
//  MallViewController.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShowModel.h"
@interface MallViewController : UIViewController<SlideShowModelDelegate,UITableViewDataSource,UITableViewDelegate>{
    
}
@property(nonatomic,strong)SlideShowModel *slidemodel;
@end
