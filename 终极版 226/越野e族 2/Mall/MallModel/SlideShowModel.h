//
//  SlideShowModel.h
//  越野e族
//
//  Created by 史忠坤 on 14-3-19.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@class SlideShowModel;
@protocol SlideShowModelDelegate <NSObject>

-(void)LoadPicFinishedWithUrlArray:(NSMutableArray *)sliderurlArr PicIDArr:(NSMutableArray *)picIDarray;
-(void)LoadErrorwithstring:(NSString *)errorinfo;

@end
@interface SlideShowModel : NSObject<ASIHTTPRequestDelegate>{
    __weak ASIHTTPRequest * requestimg;
}
@property(nonatomic,assign)id<SlideShowModelDelegate>delegate;
-(void)SlideShowModelStartLoad;
-(void)SlideShowModelStopLoad;
@end
