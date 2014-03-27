//
//  MallPayResultViewController.m
//  越野e族
//
//  Created by soulnear on 14-3-26.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MallPayResultViewController.h"

@interface MallPayResultViewController ()

@end

@implementation MallPayResultViewController
@synthesize IsSuccess = _IsSuccess;
    
    
    

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
    
    
    
-(void)backto
{
    [self.navigationController popViewControllerAnimated:YES];
}
    

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _IsSuccess = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = _IsSuccess?@"支付成功":@"支付失败";
    
    
    UIImage * theImage = [UIImage imageNamed:_IsSuccess?@"MallSuccess249_156.png":@"MallFailure204_191.png"];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:theImage];
    
    imageView.center = CGPointMake(160,75+theImage.size.height/2);
    
    [self.view addSubview:imageView];
    
    
    
    UILabel * label_ = [[UILabel alloc] initWithFrame:CGRectMake(0,imageView.frame.origin.y+imageView.frame.size.height+20,320,20)];
    
    label_.text = _IsSuccess?@"您以付款成功":@"您的付款失败";
    
    label_.textAlignment = NSTextAlignmentCenter;
    
    label_.backgroundColor = [UIColor clearColor];
    
    label_.font = [UIFont systemFontOfSize:18];
    
    label_.textColor = [UIColor blackColor];
    
    [self.view addSubview:label_];
    
    
    
    
    
//    if (_IsSuccess)
//    {
//        [self paySuccess];
//    }else
//    {
//        [self payFailed];
//    }
}
    
-(void)paySuccess
{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MallSuccess249_156.png"]];
    
    imageView.center = CGPointMake(160,iPhone5?(568-(MY_MACRO_NAME?64:44))/2:(480-(MY_MACRO_NAME?64:44))/2);
    
    [self.view addSubview:imageView];
    
    
    
    UILabel * label_ = [[UILabel alloc] initWithFrame:CGRectMake(0,imageView.frame.origin.y+imageView.frame.size.height+20,320,20)];
    
    label_.text = @"您以付款成功";
    
    label_.textAlignment = NSTextAlignmentCenter;
    
    label_.textColor = [UIColor blackColor];
    
    [self.view addSubview:label_];
    
}
    
    
-(void)payFailed
{
    
}
    
    
    
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end






















