//
//  FiveStareView.h
//  越野e族
//
//  Created by 史忠坤 on 14-4-23.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouyeheaderView.h"

typedef void(^fiveStarbuttonTarget)(int tag);


@interface FiveStareView : UIView<UIScrollViewDelegate>{
    ShouyeheaderView *header;
    
    UIScrollView *_scroV;
    AsyncImageView *_imgV;
}

-(void)setArray:(NSArray *)arrayInfo block:(fiveStarbuttonTarget)block;

@property(nonatomic,copy)fiveStarbuttonTarget mybloc;

@end
