//
//  ClassifySlideView.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-29.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^mybloc)(int idofclassify);


@interface ClassifySlideView : UIView


-(void)ClassifySlideViewSetArray:(NSArray *)_arr bloc:(mybloc)bloccopy;

@property(nonatomic,copy)mybloc bloc;

@property(nonatomic,assign)int pretag;

@end
