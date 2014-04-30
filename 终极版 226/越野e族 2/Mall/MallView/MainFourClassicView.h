//
//  MainFourClassicView.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-28.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^fourbloc)(int tag);


@interface MainFourClassicView : UIView{

    UIScrollView *_ScroV;

}



-(void)setArr:(NSArray *)arr_   bloc:(fourbloc)_bloc;

@property(nonatomic,copy)fourbloc Mybloc;
@property(nonatomic,strong)NSString *str_title;

@end
