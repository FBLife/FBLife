//
//  AppDelegate.h
//  越野e族
//
//  Created by soulnear on 13-12-16.
//  Copyright (c) 2013年 soulnear. All rights reserved.
//
/**
 *  testgit
 */

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "LogInViewController.h"
#import "AsyncImageView.h"
#import "LeveyTabBarController.h"
#import "PRTween.h"
#import "UMSocialData.h"
#import "WXApi.h"
#import "RootViewController.h"
#import "BBSViewController.h"
#import "NewWeiBoViewController.h"
#import "NewMineViewController.h"
#import "MessageViewController.h"
#import "MallViewController.h"

#import "WeiboSDK.h"
#import "CarPortViewController.h"
#import "PersonalmoreViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "FansViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,LogInViewControllerDelegate,downloaddelegate,LeveyTabBarControllerDelegate,LeveyTabBarDelegate,AsyncImageDelegate,MobClickDelegate,WXApiDelegate>
{
    UITabBarController * tabbar;
    LogInViewController * logIn;
    AsyncImageView *guanggao_image;
    LeveyTabBarController *_leveyTabBarController;
    NSTimer *  timer;
    int index;
    
    PRTweenOperation *activeTweenOperation;
    UIImageView *iMagelogo;
    UIImageView *bigimageview;
    UIViewController *current_controller;
    NSDictionary *dic_push;
    int  NewsMessageNumber;
    downloadtool *allnotificationtool;
    
    int flagofpage;
    CTCallCenter *center;
    UIImageView *img_TEST;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)RootViewController * rootVC;
@property(nonatomic,strong)BBSViewController * bbsVC;
@property(nonatomic,strong)NewWeiBoViewController * weiboVC;
@property(nonatomic,strong)CarPortViewController * mineVC;
@property(nonatomic,strong)MallViewController * mallVC;
@property(nonatomic,strong)PersonalmoreViewController * moreVC;
@property(nonatomic,strong)FansViewController * fansVC;
@property(nonatomic,strong)CTCallCenter *_center;


-(void)setPersonalState:(PersonalStateType)type;

- (void)restoreViewLocation;

@end
