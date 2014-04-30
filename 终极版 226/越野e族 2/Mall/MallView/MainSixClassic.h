//
//  MainSixClassic.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sixbuttonTarget)(int tag);

@interface MainSixClassic : UIView<AsyncImageDelegate>

-(void)setArray:(NSArray *)arrayInfo block:(sixbuttonTarget)block;


@property(nonatomic,copy)sixbuttonTarget mybloc;

@end
