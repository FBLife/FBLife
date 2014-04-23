//
//  ClassifyViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-21.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//
//具体分类
#import "ClassifyViewController.h"

@interface ClassifyViewController ()
{
    
}

@end

@implementation ClassifyViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    
    
    NSArray *array_lanmu=[NSArray arrayWithObjects:@"全部",@"SUV",@"皮卡",@"跨界", nil];
    
    for (int i=0; i<array_lanmu.count; i++) {
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 20)];
        [self.view addSubview:button];
    }
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





























