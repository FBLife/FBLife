//
//  SearchResaultView.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-24.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MallxiangqingBloc)(int idofGoods);

@interface SearchResaultView : UIView

-(void)setarray:(NSArray *)arrinfo searchbloc:(MallxiangqingBloc)bloc;

@property(nonatomic,copy)MallxiangqingBloc mybloc;


@end
