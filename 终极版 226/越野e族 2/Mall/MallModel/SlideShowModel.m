//
//  SlideShowModel.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-19.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//
//http://malltest.fblife.com/api.php?app=index&act=slides&formattype=json
#import "SlideShowModel.h"

@implementation SlideShowModel
-(void)SlideShowModelStartLoad{
    requestimg = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://malltest.fblife.com/api.php?app=index&act=slides&formattype=json"]]];
    
    //   NSLog(@"=--==%@",[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ",string_lngand]);
    
    requestimg.tag=2014;
    
    requestimg.delegate = self;
    
    [requestimg setCompletionBlock:^{
        
        
        /**
         *  {
         "datainfo": {
         "slides": [
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201310281732235104.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=8536"
         },
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201308310901108596.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=7718"
         },
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201306241753207531.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=6639"
         },
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201310311022587795.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=8600"
         },
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201402171041311255.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=9603"
         },
         {
         "img": "http://img20.fblife.com/data/files/mall/template/201312021035228790.jpg",
         "link": "http://mall.fblife.com/index.php?app=goods&id=9158"
         }
         ]
         },
         "errcode": 0
         }
         */
        NSArray *arrayinfo=[NSArray array];
        
        NSMutableArray *array_picurl=[NSMutableArray array];
        NSMutableArray *array_id=[NSMutableArray array];
        

        @try {
            NSDictionary * dic = [requestimg.responseData objectFromJSONData];
            if ([[dic objectForKey:@"errcode"] intValue]==0) {
                arrayinfo = [[dic objectForKey:@"datainfo"] objectForKey:@"slides"];
                for (int i=0; i<arrayinfo.count; i++) {
                    NSDictionary *dic=[arrayinfo objectAtIndex:i];
                    NSString *str_url=[NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]];
                    [array_picurl addObject:str_url];
                    NSString *stringlink=[NSString stringWithFormat:@"%@",[dic objectForKey:@"link"]];
                    stringlink=[self returnIdWithlink:stringlink];
                    [array_id addObject:stringlink];
 
                }
                
            }else{
                
                [self.delegate LoadErrorwithstring:@"error"];
            }

            
        }
        @catch (NSException *exception) {
            NSLog(@"%sCatchAbug",__FUNCTION__);
            
            
        }
        @finally {
            
            [self.delegate LoadPicFinishedWithUrlArray:array_picurl PicIDArr:array_id];
            
        }
        
        
        
        
    }];
    
    
    [requestimg setFailedBlock:^{
        [self SlideShowModelStopLoad];
        
    }];
    
    [requestimg startAsynchronous];

    
}
-(void)SlideShowModelStopLoad{
    [requestimg cancel];
    requestimg.delegate=nil;
    
  }
-(NSString *)returnIdWithlink:(NSString *)_link{
    @try {
        //http://mall.fblife.com/index.php?app=goods&id=9158
        NSLog(@"原本的====%@",_link);
        _link=[_link substringFromIndex:_link.length- [_link rangeOfString:@"&id="].length];
        NSLog(@"现在的===%@",_link);
    }
    @catch (NSException *exception) {
        NSLog(@"%sfindabug",__FUNCTION__);
        
    }
    @finally {
        
    }


    
    return _link;
}

@end
