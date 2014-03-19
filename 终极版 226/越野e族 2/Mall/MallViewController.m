//
//  MallViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-17.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MallViewController.h"

@interface MallViewController ()

@end

@implementation MallViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    [self Startloadhuandeng];
	// Do any additional setup after loading the view.
}

#pragma mark-slidemodeldelegate
-(void)Startloadhuandeng{
    _slidemodel=[[SlideShowModel alloc]init];
    _slidemodel.delegate=self;
    [_slidemodel SlideShowModelStartLoad];
}
-(void)LoadPicFinishedWithUrlArray:(NSMutableArray *)sliderurlArr PicIDArr:(NSMutableArray *)picIDarray{
    NSLog(@"%@\n%@",sliderurlArr,picIDarray);
}
-(void)LoadErrorwithstring:(NSString *)errorinfo{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
