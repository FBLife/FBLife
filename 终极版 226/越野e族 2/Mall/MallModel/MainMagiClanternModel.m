//
//  MainMagiClanternModel.m
//  越野e族
//
//  Created by 史忠坤 on 14-4-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MainMagiClanternModel.h"








@interface MainMagiClanternModel (){
    
    NSMutableData *_data;
}

@end


@implementation MainMagiClanternModel
-(void)SeturlStr:(NSString *)str block:(myBlock)block{
    
    _testBlocksbl=block;
    _string_url=str;
    
    
    
    NSLog(@"urlstr=====%@",_string_url);
    
    NSURL *url = [NSURL URLWithString:_string_url];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:req delegate:self];
    
    
    NSLog(@"NSURLConnection 完成");
    
    
}
//连接接受响应，表示成功建立连接
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    
    
    _data = [NSMutableData data];
}
//连接接受数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
   
    NSLog(@"datadatadatadata%@",data);
    [_data appendData:data];
}
//连接完成

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    
    
    // NSArray *dicinfo=[_data objectFromJSONData];
    self.mydicinfo=[_data objectFromJSONData];
    
    
    NSLog(@"xxxx%@",self.mydicinfo);
    
    NSArray *array_=[self.mydicinfo objectForKey:@"datainfo"];
    
    
    
    NSLog(@".....******%@",array_);
    
//    for (int i=0; i<array_.count; i++) {
    
//        NSDictionary *dic=[array_ objectAtIndex:i];
//        [_model setDic:dic];
//        [arrayinfo addObject:_model];
//        
//    
//    }
    
    
        _testBlocksbl(array_,@"noerror");

    
    
    
    
    
}
//请求失败的处理
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    
    
    _testBlocksbl(nil,[error localizedDescription]);
    
    
}


@end
