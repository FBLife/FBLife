//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
@class SGFocusImageItem;
@class LoopScrollview;

#pragma mark - SGFocusImageFrameDelegate
@protocol LoopScrollviewDelegate <NSObject>
@optional
- (void)foucusImageFrame:(LoopScrollview *)imageFrame didSelectItem:(SGFocusImageItem *)item;
- (void)foucusImageFrame:(LoopScrollview *)imageFrame currentItem:(int)index;

@end


@interface LoopScrollview : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    BOOL _isAutoPlay;
}
- (id)initWithFrame:(CGRect)frame delegate:(id<LoopScrollviewDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto;

- (id)initWithFrame:(CGRect)frame delegate:(id<LoopScrollviewDelegate>)delegate focusImageItems:(SGFocusImageItem *)items, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithFrame:(CGRect)frame delegate:(id<LoopScrollviewDelegate>)delegate imageItems:(NSArray *)items;
- (void)scrollToIndex:(int)aIndex;

@property (nonatomic, assign) id<LoopScrollviewDelegate> delegate;

@end
