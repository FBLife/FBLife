//
//  BtnF4.m
//  越野e族
//
//  Created by gaomeng on 14-4-18.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "BtnF4.h"

@implementation BtnF4

+(id)shareBtnF4{
    static BtnF4 *btnF4 = nil;
    if (btnF4) {
        return btnF4;
    }
    btnF4 = [[BtnF4 alloc]init];
    
    //首页
    UIButton *btnShouye = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShouye setImage:[UIImage imageNamed:@"home_37x37.png"] forState:UIControlStateNormal];
    [btnShouye setTitle:@"商家首页" forState:UIControlStateNormal];
    [btnShouye setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, -5)];
    [btnShouye setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -30, 0)];
    btnShouye.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnShouye setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
    //简介
    UIButton *btnJianjie = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnJianjie setImage:[UIImage imageNamed:@"jianjie_41x35.png"] forState:UIControlStateNormal];
    [btnJianjie setTitle:@"商家简介" forState:UIControlStateNormal];
    [btnJianjie setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, -5)];
    [btnJianjie setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -30, 0)];
    btnJianjie.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnJianjie setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
    //电话
    UIButton *btnPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPhone setImage:[UIImage imageNamed:@"telephone_34x34.png"] forState:UIControlStateNormal];
    [btnPhone setTitle:@"联系电话" forState:UIControlStateNormal];
    [btnPhone setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, -5)];
    [btnPhone setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -30, 0)];
    btnPhone.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnPhone setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    //论坛
    UIButton *btnBBS = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBBS setImage:[UIImage imageNamed:@"talk_37x36.png"] forState:UIControlStateNormal];
    [btnBBS setTitle:@"商家论坛" forState:UIControlStateNormal];
    [btnBBS setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, -5)];
    [btnBBS setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, -30, 0)];
    btnBBS.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnBBS setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    btnF4.btnF4Array = [NSArray arrayWithObjects:btnShouye,btnJianjie,btnPhone,btnBBS, nil];
    
    
    return btnF4;
}

@end
