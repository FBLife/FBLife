//
//  SellerGoodsView.h
//  越野e族
//
//  Created by soulnear on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cellClickedBlock)(NSString* classId);//点击cell的block


@protocol SellerGoodsViewDelegate <NSObject>


@end



@interface SellerGoodsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    int identifierIsHidden[255];
    
    int history_page;
    
    NSArray * namesArray;
    
    NSMutableArray * data_array;
}

@property(nonatomic,strong)UITableView * classifyTableView;

@property(nonatomic,assign)id<SellerGoodsViewDelegate>delegate;

@property(nonatomic,strong)cellClickedBlock cellClickedBlock;


-(void)loadViewWithContent:(NSMutableArray *)contents NameArray:(NSArray *)names;

@end
