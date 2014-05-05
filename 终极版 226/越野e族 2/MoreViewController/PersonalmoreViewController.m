//
//  PersonalmoreViewController.m
//  FbLife
//
//  Created by 史忠坤 on 13-12-9.
//  Copyright (c) 2013年 szk. All rights reserved.
//90 107 148

#import "PersonalmoreViewController.h"
#import "MessageViewController.h"
#import "NewMineViewController.h"
#import "FriendListViewController.h"
#import "DraftBoxViewController.h"
#import "SDImageCache.h"
#import "FullyLoaded.h"
#import "UMFeedbackViewController.h"
#import "AboutViewController.h"
#import "QrcodeViewController.h"
#import "DetailViewController.h"
#import "UMTableViewController.h"
#import "AppDelegate.h"
//#import "ScanningViewController.h"


@interface PersonalmoreViewController (){
    LogInViewController * logIn ;
    
}

@end


/*


@implementation PersonalmoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    if (string_fansnumber.length==0) {
        [self receivemyimage_head];
    }
    
    [MobClick beginEvent:@"PersonalmoreViewController"];
    
    if (_myTableView)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endEvent:@"PersonalmoreViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayofjingpinyingyong=[[NSArray alloc]init];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(receivemyimage_head) name:@"LogIn" object:nil];
    
    //    [[NSNotificationCenter defaultCenter]
    //     addObserver:self selector:@selector(getmybackgroundImage) name:@"successgetuid" object:nil];
    
    [self receivemyimage_head];
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        //iOS 5 new UINavigationBar custom background
        
        [self.navigationController.navigationBar setBackgroundImage:MY_MACRO_NAME?[UIImage imageNamed:IOS7DAOHANGLANBEIJING]:[UIImage imageNamed:@"ios7eva320_44.png"] forBarMetrics: UIBarMetricsDefault];
        
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
    self.navigationItem.title = @"个人中心";
    
    UIColor * cc = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:cc,[UIFont systemFontOfSize:20],[UIColor clearColor],nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor,nil]];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = MY_MACRO_NAME?-4:5;
    
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ios7logo.png"]];
    leftImageView.center = CGPointMake(MY_MACRO_NAME? 22:25,22);
    
    UIView *leftttview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [leftttview addSubview:leftImageView];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftttview];
    
    
    
    self.navigationItem.leftBarButtonItems = @[space,leftButton];
    //
    if (MY_MACRO_NAME) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,IOS_VERSION>=7.0?0:0,320,iPhone5?(568-49-64):(480-49-64)) style:UITableViewStylePlain];
    }else{
        
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,iPhone5?480:370) style:UITableViewStylePlain];
        
    }
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundView=[[UIView alloc] init];//改变表的背景视图
    _myTableView.backgroundColor = RGBCOLOR(40, 43, 53);//RGBCOLOR(243,243,243);//添加颜色
    _myTableView.separatorColor=[UIColor blackColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    arrayofsection=[NSArray arrayWithObjects:@"编辑资料",@"我的主页",@"消息通知", @"联系人", @"草稿箱", @"扫一扫",@"muyou",@"清除缓存",@"意见反馈",@"版本更新",@"关于",@"muyou",@"精品应用",nil];
    
    arrayofimg=[NSArray arrayWithObjects:@"",
                @"ios7_home5959.png",
                @"ios7_xiaoxi5959.png",
                @"ios7_friend5959.png",
                @"ios7_caogao59x59.png",
                @"ios7_erweima5959.png",
                
                @"",
                
                @"ios7_trash5959.png",
                @"ios7_message59x59.png",
                @"ios7_change5959.png",
                @"ios7_help5959.png",
                
                @"",
                
                @"ios7_yingyong59_59.png",
                
                nil];
    
    
    //友盟获取精品应用的数据
    
    
    _mTableView = [[UMUFPTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain appkey:@"5153e5e456240b79e20006b9" slotId:nil currentViewController:self];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.dataLoadDelegate = (id<UMUFPTableViewDataLoadDelegate>)self;
    
    [_mTableView requestPromoterDataInBackground];
    
   
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshsectionthree:) name:@"fbnotification" object:nil] ;   	// Do any additional setup after loading the view.
}
#pragma mark---来到通知之后，刷新列表

-(void)refreshsectionthree:(NSNotification *)center{
    NSDictionary *dic_pushinfo=(NSDictionary *)center.object;
    
    int type=[[[dic_pushinfo objectForKey:@"aps"] objectForKey:@"type"] integerValue];
    NSLog(@"dic===%@=======type====%d",dic_pushinfo,type);
    switch (type) {
        case 2:
        {
            
        }
        case 3:
        {
            
        }
        case 4:
        {
            
        }
        case 5:
        {
            [self refreshcellthreewithtype:@"fb"];

        }
            break;
        case 6:
        {
            [self refreshcellthreewithtype:@"message"];
        }
            break;
        case 7:
        {
            [self refreshcellthreewithtype:@"fb"];

        }
            break;
        case 9:
        {
            [self refreshcellthreewithtype:@"fb"];
        }
            break;
        case 20:
        {
        }
            break;
        case 21:
        {
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    NSLog(@"==note==%@",dic_pushinfo);
    
    
}
-(void)refreshcellthreewithtype:(NSString *)type{
    
    
    
    
    
    
    string_messageorfb=[NSString stringWithFormat:@"%@",type];
    
    
    NSLog(@">>%@<<",string_messageorfb);
    
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    NSArray *arra=[NSArray arrayWithObject:reloadIndexPath];
    [ _myTableView reloadRowsAtIndexPaths:arra withRowAnimation:UITableViewRowAnimationNone];
    

    
}

#pragma mark--取精品应用数据回调


- (void)loadDataFailed {
    
    NSLog(@"获取精品应用数据失败");
    
}

//该方法在成功获取广告数据后被调用
- (void)UMUFPTableViewDidLoadDataFinish:(UMUFPTableView *)tableview promoters:(NSArray *)promoters {
    
    arrayofjingpinyingyong=[NSArray arrayWithArray:promoters];
    NSLog(@"arrayofjingpinyingyong====%@",arrayofjingpinyingyong);
    
    
    if ([promoters count] > 0)
    {
        
        NSLog(@"可以更新精品应用的数据了");
        //   [_myTableView reloadData];
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:12 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}








#pragma mark-tableviewdelegate&datesource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayofsection count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    for (UIView *aview in cell.contentView.subviews) {
        [aview removeFromSuperview];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    
    if (indexPath.row==6||indexPath.row==11) {
        UILabel *albel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.5,320 , 20-1)];
        // albel.text=[arrayofsection  objectAtIndex:indexPath.row];
        albel.backgroundColor=RGBCOLOR(247, 247, 247);
        [cell.contentView addSubview:albel];
        UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_longline640x1.png"]];
        img.frame=CGRectMake(0,20-0.5, 320, 0.5);
        [cell.contentView addSubview:img];
        
        
        
    }else if(indexPath.row==0){
        
        UIColor *bluetestcolor=RGBCOLOR(90, 107, 148);
        
        imgbeijing=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        [imgbeijing loadImageFromURL:[self getmybackgroundImage] withPlaceholdImage:[UIImage imageNamed:@"underPageBackGround.png"]];
        [cell.contentView addSubview:imgbeijing];
        
        
        UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_longline640x1.png"]];
        img.frame=CGRectMake(0, 312/2-0.5, 320, 0.5);
        [cell.contentView addSubview:img];
        
        BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
        
        
        imghead=[[AsyncImageView alloc]initWithFrame:CGRectMake(13.25, 55, 80, 80)];
        [imghead loadImageFromURL:isLogIn?string_face_original:@"" withPlaceholdImage:[UIImage imageNamed:@"ios7_headimplace.png"]];
//        if (string_face_original.length!=0) {
            imghead.layer.masksToBounds=NO;
            
            imghead.layer.shadowColor = [UIColor blackColor].CGColor;
            
            imghead.layer.shadowOffset = CGSizeMake(0.5,0.5);
            
            imghead.layer.shadowRadius = 1;
            
            imghead.layer.shadowOpacity = 0.5;
//        }
        
        [cell.contentView addSubview:imghead];
        
        UILabel *namelabel=[[UILabel alloc]initWithFrame:CGRectMake(105, 135/2, 200, 20)];
        namelabel.textColor=[UIColor whiteColor];
        namelabel.textAlignment=UITextAlignmentLeft;
        namelabel.font=[UIFont systemFontOfSize:19];
        namelabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
        namelabel.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:namelabel];
        
        
        
        //        这里以前是是编辑资料，现在改了
        //        UIButton *editButton=[[UIButton alloc]initWithFrame:CGRectMake(105, 110, 100, 14)];
        //        [editButton setImage:[UIImage imageNamed:@"ios7_bianjiziliao25x28.png"] forState:UIControlStateNormal];
        //        [editButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        //        editButton.titleLabel.font=[UIFont systemFontOfSize:13];
        //        [editButton setTitleColor:RGBCOLOR(128, 128, 128) forState:UIControlStateNormal];
        //
        //        [editButton setImageEdgeInsets:UIEdgeInsetsMake(0,-18,0,0)];
        //        [editButton setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];//上左下右
        //        [cell.contentView addSubview:editButton];
        
        
        NSLog(@"ahah%@..........%d",string_follownumber,string_follownumber.length);
        UILabel *label_fans=[[UILabel alloc]initWithFrame:CGRectMake(105, 110, 30, 20)];
        label_fans.backgroundColor=[UIColor clearColor];
        label_fans.text=@"关注";
        label_fans.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:label_fans];
        label_fans.hidden=![string_fansnumber length];
        
        UILabel *label_follow=[[UILabel alloc]initWithFrame:CGRectMake(360/2, 110, 30, 20)];
        
        label_follow.text=@"粉丝";
        label_follow.backgroundColor=[UIColor clearColor];
        label_follow.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:label_follow];
        label_follow.hidden=![string_fansnumber length];
        
        UIView *viewshuline=[[UIView alloc]initWithFrame:CGRectMake(340/2, 115, 1, 10)];
        viewshuline.backgroundColor=RGBCOLOR(213, 213, 213);
        viewshuline.hidden=!string_fansnumber.length;
        [cell.contentView addSubview:viewshuline];
        
        
        UILabel *follow_label=[[UILabel alloc]initWithFrame:CGRectMake(132, 110, 35, 20)];
        follow_label.backgroundColor=[UIColor clearColor];
        follow_label.textColor=bluetestcolor;
        follow_label.text=string_follownumber;
        follow_label.textAlignment=UITextAlignmentCenter;
        follow_label.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:follow_label];
        
        
        
        UILabel *fans_label=[[UILabel alloc]initWithFrame:CGRectMake(218, 110, 40, 20)];
        fans_label.backgroundColor=[UIColor clearColor];
        fans_label.textAlignment=UITextAlignmentLeft;
        fans_label.textColor=bluetestcolor;
        fans_label.text=string_fansnumber;
        fans_label.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:fans_label];
        
        
        
    }else if(indexPath.row==12){
        
        UILabel *albel=[[UILabel alloc]initWithFrame:CGRectMake(55, 0,120 , 43-0.5)];
        
        albel.text=[arrayofsection  objectAtIndex:indexPath.row];
        [cell.contentView addSubview:albel];
        
        
        UIButton *button_turntotuijianliebiao=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 43-0.5)];
        [button_turntotuijianliebiao addTarget:self action:@selector(turntojingpinyingyong) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button_turntotuijianliebiao];
        
        
        UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios7_longline640x1.png"]];
        img.frame=CGRectMake(0, 452/2-0.5, 320, 0.5);
        [cell.contentView addSubview:img];
        
        UIImageView *img_littleicon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[arrayofimg objectAtIndex:indexPath.row]]];
        img_littleicon.center=CGPointMake((320-527/2)/2, 21.5);
        [cell.contentView addSubview:img_littleicon];
        
        UIImageView *right_img=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"ios7_right1628.png"]];
        right_img.center=CGPointMake(305, 21.5);
        [cell.contentView addSubview:right_img];
        
        UIImageView *centerimg=[[UIImageView alloc]initWithFrame:CGRectMake(13.25, 43.5, 320-13.25*2, 0.5)];
        centerimg.image=[UIImage imageNamed:@"ios7_longline640x1.png"];
        [cell.contentView addSubview:centerimg];
        
        //
        
        if (arrayofjingpinyingyong.count>3) {
            for (int i=0; i<4; i++) {
                
                NSDictionary *dicjingpininfo=[arrayofjingpinyingyong objectAtIndex:i];
                
                UIButton *suggest_button=[[UIButton alloc]initWithFrame:CGRectMake(11.25+80*i, 53, 115/2, 115/2)];
                suggest_button.tag=99+i;
                suggest_button.backgroundColor=[UIColor clearColor];
                [suggest_button addTarget:self action:@selector(domysuggestbutton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:suggest_button];
                
                AsyncImageView *imgbuttonbg=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 115/2, 115/2)];
                
                [ imgbuttonbg loadImageFromURL:[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"icon"]] withPlaceholdImage:nil];
                [suggest_button addSubview:imgbuttonbg];
                
                
                
                UILabel *labelofname=[[UILabel alloc]initWithFrame:CGRectMake(8+80*i, 53+115/2+3, 67, 20)];
                labelofname.text=[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"title"]];
                labelofname.font=[UIFont systemFontOfSize:12];
                labelofname.textAlignment=UITextAlignmentCenter;
                //                labelofname.backgroundColor=[UIColor greenColor];
                [cell.contentView addSubview:labelofname];
                
                
            }
            
            
            
        }else{
            
            for (int i=0; i<[arrayofjingpinyingyong count]; i++) {
                
                NSDictionary *dicjingpininfo=[arrayofjingpinyingyong objectAtIndex:i];
                
                UIButton *suggest_button=[[UIButton alloc]initWithFrame:CGRectMake(11.25+80*i, 53, 115/2, 115/2)];
                //                suggest_button.layer.cornerRadius=5;
                suggest_button.tag=99+i;
                suggest_button.backgroundColor=[UIColor clearColor];
                [suggest_button addTarget:self action:@selector(domysuggestbutton:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:suggest_button];
                
                AsyncImageView *imgbuttonbg=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 115/2, 115/2)];
                
                [ imgbuttonbg loadImageFromURL:[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"icon"]] withPlaceholdImage:nil];
                //                imgbuttonbg.layer.cornerRadius=5;
                [suggest_button addSubview:imgbuttonbg];
                
                
                
                UILabel *labelofname=[[UILabel alloc]initWithFrame:CGRectMake(11.25+80*i, 53+115/2+3, 115/2, 20)];
                labelofname.text=[NSString stringWithFormat:@"%@",[dicjingpininfo objectForKey:@"title"]];
                labelofname.textAlignment=UITextAlignmentCenter;
                [cell.contentView addSubview:labelofname];
                
            }
            
            
        }
        //退出登录的部分
        
        
        UIImageView *secondline=[[UIImageView alloc]initWithFrame:CGRectMake(0, 53+115/2+5+23, 320, 0.5)];
        secondline.image=[UIImage imageNamed:@"ios7_longline640x1.png"];
        [cell.contentView addSubview:secondline];
        
        UIView *loginview=[[UIView alloc]initWithFrame:CGRectMake(0, 53+115/2+5+0.5+23, 320, 452/2-(53+115/2+5+0.5+23))];
        loginview.backgroundColor=RGBCOLOR(247, 247, 247);
        
        [cell.contentView addSubview:loginview];
        
        UIButton *loginOrOutbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320-13.25*2, 40)];
        loginOrOutbutton.center=CGPointMake(160, (452/2-(53+115/2+5+0.5+23))/2);
        loginOrOutbutton.backgroundColor=RGBCOLOR(120, 121, 123);
        // loginOrOutbutton.titleLabel.text=@"退出当前账号";
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        BOOL logIn1 = [user boolForKey:USER_IN];
        [loginOrOutbutton addTarget:self action:@selector(dengluortuichu) forControlEvents:UIControlEventTouchUpInside];
        
        [loginOrOutbutton setTitle:logIn1?@"退出当前账号":@"登录账号" forState:UIControlStateNormal];
        [loginview addSubview:loginOrOutbutton];
        
        
        
        
        
        
        
    }else{
        UILabel *albel=[[UILabel alloc]initWithFrame:CGRectMake(55, 0,120 , 43-0.5)];
        
        if (indexPath.row==7) {
            NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/data"];
            
            albel.text = [NSString stringWithFormat:@"清除缓存%@",[zsnApi fileSizeAtPath:path]];
            
        }else{
            albel.text=[arrayofsection  objectAtIndex:indexPath.row];
            
        }
        [cell.contentView addSubview:albel];
        
        
        UIImageView *img_littleicon=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[arrayofimg objectAtIndex:indexPath.row]]];
        img_littleicon.center=CGPointMake((320-527/2)/2, 21.5);
        [cell.contentView addSubview:img_littleicon];
        
        if (indexPath.row==9||indexPath.row==7) {
        }
        else{
            UIImageView *right_img=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"ios7_right1628.png"]];
            right_img.center=CGPointMake(305, 21.5);
            [cell.contentView addSubview:right_img];
            
        }
        
        
        if (indexPath.row == 2){
            
            
            
            
            UIImageView *     tixing_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(530/2,13.25,56/2,33/2)];
            tixing_imageView.image = [UIImage imageNamed:@"ios7_newicon_56_33.png"];
            
            tixing_imageView.hidden = YES;
            
            [cell.contentView addSubview:tixing_imageView];
            
            
            if (!self.leveyTabBarController.tabBar.tixing_imageView.hidden&&[[NSUserDefaults standardUserDefaults] boolForKey:USER_IN])
            {
                tixing_imageView.hidden = NO;
            }else
            {
                tixing_imageView.hidden = YES;
            }
            
            
            
            
        }
        
        
        if (indexPath.row==5||indexPath.row==10) {
            UIImageView *img=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"ios7_longline640x1.png"]];
            img.frame=CGRectMake(0, 42.5, 320, 0.5);
            [cell.contentView addSubview:img];
            
            
            
            
        }else{
            UIImageView *img=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"ios7_shortline_527x1.png"]];
            img.frame=CGRectMake(320-527/2, 42.5, 527/2, 0.5);
            [cell.contentView addSubview:img];
            
            //ios7_right1628@2x
            
            
            
        }
        
        
 
    }
    
    
    cell.contentView.backgroundColor=[UIColor whiteColor];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==6||indexPath.row==11) {
        return 20;
    }else if(indexPath.row==12){
        return 452/2;
    }else if(indexPath.row==0){
        return 312/2;
    }else{
        return 86/2;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexpath.row===%d",indexPath.row);
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    switch (indexPath.row)
    {
        case 0:
        {
            NSLog(@"编辑资料的，需要接口");
        }
            
            break;
        case 1:
        {
            if (isLogIn)
            {
                NewMineViewController *my_info=[[NewMineViewController alloc]init];
                [self.navigationController pushViewController:my_info animated:YES];
                
            }else
            {
                if (!logIn)
                {
                    logIn = [[LogInViewController alloc] init];
                }
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                
                [self presentModalViewController:logIn animated:YES];
            }
        }
            
            break;
        case 2:
        {
            if (isLogIn)
            {
                
                
                MessageViewController *message=[[MessageViewController alloc]init];
                
                NSLog(@">>>>>%@>>>>",string_messageorfb);
                if (string_messageorfb.length>0) {
                    message.string_messageorfbno=string_messageorfb;

                }else if( self.leveyTabBarController.tabBar.tixing_imageView.hidden==NO) {
                    message.string_messageorfbno=@"fb";
                }
                string_messageorfb=@"";
                self.leveyTabBarController.tabBar.tixing_imageView.hidden = YES;

                [self.navigationController pushViewController:message animated:YES];
                NSIndexPath  *indexPath_1=[NSIndexPath indexPathForRow:2 inSection:0];
                NSArray      *indexArray=[NSArray  arrayWithObject:indexPath_1];
                [_myTableView  reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationNone];

            }else
            {
                if (!logIn)
                {
                    logIn = [[LogInViewController alloc] init];
                }
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                
                [self presentModalViewController:logIn animated:YES];
            }
            break;
        }
        case 3:
        {
            if (isLogIn)
            {
                FriendListViewController *message=[[FriendListViewController alloc]init];
                
                message.title_name_string = @"mine";
                
                message.delegate = self;
                
                [self presentModalViewController:message animated:YES];
            }else
            {
                if (!logIn)
                {
                    logIn = [[LogInViewController alloc] init];
                }
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                [self presentModalViewController:logIn animated:YES];
            }
            
            
        }
            
            break;
        case 4:{
            if (isLogIn)
            {
                DraftBoxViewController *draft=[[DraftBoxViewController alloc]init];
                
                [self.navigationController pushViewController:draft animated:YES];
            }else
            {
                if (!logIn)
                {
                    logIn = [[LogInViewController alloc] init];
                }
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                [self presentModalViewController:logIn animated:YES];
            }
            
        }
            break;
        case 5:{
            
            NSLog(@"到二维码界面的");
            
            if (isLogIn)
            {
                //                QrcodeViewController *_qrcode=[[QrcodeViewController alloc]init];
                //                _qrcode.headImage=imghead.image;
                //                [self.leveyTabBarController hidesTabBar:YES animated:NO];
                //                [self.navigationController pushViewController:_qrcode animated:YES];
                
                DetailViewController *_qrcode=[[DetailViewController alloc]init];
                [self.leveyTabBarController hidesTabBar:YES animated:NO];
                [self.navigationController pushViewController:_qrcode animated:YES];
                
                
                
                
                
                
            }else
            {
                if (!logIn)
                {
                    logIn = [[LogInViewController alloc] init];
                }
                [self.leveyTabBarController hidesTabBar:YES animated:YES];
                [self presentModalViewController:logIn animated:YES];
            }
            
            
            
        }
            break;
        case 6:{
            NSLog(@"空的");
            
        }
            
            break;
        case 7:{
            [self removeCache];
            
            
        }
            
            break;
        case 8:{
            
            [self feedback];
            
            
        }
            break;
        case 9:{
            [self checkVersionUpdate];
            
        }
            
            break;
        case 10:{
            AboutViewController * aboutVC = [[AboutViewController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.leveyTabBarController hidesTabBar:YES animated:YES];
            [self.navigationController pushViewController:aboutVC animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
            
        }
            
            break;
        case 11:{
            
            NSLog(@"空得。。。。");
            
        }
            
            break;
        case 12:{
            NSLog(@"不做操作");
            
        }
            
            break;
            
        default:
            break;
    }
    
    
    
}


#pragma friendlistdelegate

-(void)returnUserName:(NSString *)username Uid:(NSString *)uid
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    mine.uid = uid;
    
    [self.navigationController pushViewController:mine animated:YES];
}

-(void)removeCache
{
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[FullyLoaded sharedFullyLoaded] removeAllCacheDownloads];
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
    NSArray *arra=[NSArray arrayWithObject:reloadIndexPath];
    [ _myTableView reloadRowsAtIndexPaths:arra withRowAnimation:UITableViewRowAnimationNone];
    
    //弹出提示信息
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"缓存清除成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)feedback{
    
    
    UMFeedbackViewController *feedb=[[UMFeedbackViewController alloc]init];
    [self.navigationController pushViewController:feedb animated:YES];
    
}


-(void)checkVersionUpdate
{
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/version.php?appversion=%@",NOW_VERSION]];
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:fullUrl];
    
    __block ASIHTTPRequest * _request = request;
    
    
    request.delegate = self;
    
    [_request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            NSString * bbsInfo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
            NSLog(@"dic===%@",dic);
            if (![bbsInfo isEqualToString:NOW_VERSION])
            {
                NSString * new = [NSString stringWithFormat:@"我们的%@版本已经上线了,赶快去更新吧!",bbsInfo];
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:new delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"稍后提示",nil];
                
                alert.delegate = self;
                
                alert.tag = 10000;
                
                [alert show];
                
                
            }else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"版本更新检查" message:@"您目前使用的是最新版本" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [_request setFailedBlock:^{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测失败,请检查您当前网络是否正常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }];
    
    [request startAsynchronous];
}


#pragma mark-UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag == 10000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];
    }
}

-(void)dengluortuichu{
    
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
    if (isLogIn)
    {
        [self deletetoken];

        self.leveyTabBarController.tabBar.tixing_imageView.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearolddata" object:nil];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"" forKey:USER_NAME] ;
        [user setObject:@"" forKey:USER_PW] ;
        [user setObject:@"" forKey:USER_AUTHOD] ;
        [user setObject:@"" forKey:USER_UID] ;
        string_follownumber=@"";
        string_fansnumber=@"";
        
        [user setBool:NO forKey:USER_IN];
        
        [user removeObjectForKey:@"friendList"];
        [user removeObjectForKey:@"RecentContact"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clean" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTheTimer" object:nil];
        
        
        [user synchronize];
        
        [self LogOut];
    }else
    {
        if (!logIn)
        {
            logIn = [[LogInViewController alloc] init];
        }
        [self.leveyTabBarController hidesTabBar:YES animated:YES];
        [self presentModalViewController:logIn animated:YES];
    }
    
    [_myTableView reloadData];
    
    
}
-(void)receivemyimage_head{
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:URL_USERMESSAGE,@"(null)",authkey];
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"个人信息 -=-=  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
                NSLog(@"dictionary=%@",dictionary);
                
                int is_shangjia = [[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"is_shangjia"]] intValue];
                label_title.text=is_shangjia?@"企业主页":@"个人中心";
                //                [_dataArray replaceObjectAtIndex:0 withObject:is_shangjia?@"企业主页":@"个人主页"];
                
                string_face_original=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"face_original"]];
                string_fansnumber=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"fans_count"]];
                string_follownumber=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"follow_count"]];
                NSString *string_uid=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
                [[NSUserDefaults standardUserDefaults]setObject:string_uid forKey:USER_UID];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"successgetuid" object:Nil];
                NSLog(@"string_uid===%@",string_uid);
                
                [imghead loadImageFromURL:string_face_original withPlaceholdImage:[UIImage imageNamed:@"ios7_headimplace.png"]];
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            [_myTableView reloadData];
            
            
        }
        
        
        
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
}

#pragma mark-退出登录，消除devicetoken

-(void)deletetoken{
//    http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=sdfasfdsafdasdf&token=ssdfasdfaddfgdsgf2a&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json
 
    
    NSString *stringdevicetoken=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]];
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=%@&token=%@&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json",authkey,stringdevicetoken];
    NSLog(@"删除的urlurl = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"删除消息 -=-=  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] ==0)
            {
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            
        }
  
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
    
    
}
-(void)LogOut
{
    [hud show];
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:NS_EXIT_SUC];
    [hud setActivity:NO];
    //    [hud setImage:[UIImage imageNamed:@"19-check"]];
    [hud show];
    [hud hideAfter:3];
    // [_myTableView reloadData];
}
-(void)domysuggestbutton:(UIButton *)sender{
    
    NSLog(@"点击的是第%d个Button",sender.tag-99);
    int index=sender.tag-99;
    NSDictionary *promoter = [_mTableView.mPromoterDatas objectAtIndex:index];
    
    [_mTableView didClickPromoterAtIndex:promoter index:index];
    
}
-(void)turntojingpinyingyong{
    
    
    NSLog(@"到精品列表的");
    
    
    UMTableViewController *controller = [[UMTableViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(NSString *)getmybackgroundImage
{
    
    
    
    NSString * uid = [[NSUserDefaults standardUserDefaults]objectForKey:USER_UID];
    
    if (uid.length !=0 && uid.length < 6)
    {
        for (int i = 0;i < uid.length -6;i++)
        {
            uid = [NSString stringWithFormat:@"%d%@",0,uid];
        }
    }
    
    NSString * string;
    if (uid.length ==0)
    {
        string = @"";
    }else
    {
        string =  [NSString stringWithFormat:@"http://fb.fblife.com/./images/userface/000/%@/%@/face_%@_0.jpg",[[uid substringToIndex:2] substringFromIndex:0],[[uid substringToIndex:4] substringFromIndex:2],[[uid substringToIndex:6] substringFromIndex:4]];
    }
    NSLog(@"str======%@",string);
    return string;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handleImageLayout:(AsyncImageView *)tag{
    NSLog(@"chenggong");
    
}

@end


*/





@implementation PersonalmoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

/*带商城信息

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * yinying_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5,0,10,iPhone5?568:480)];
    
    yinying_imageView.image = [UIImage imageNamed:iPhone5?@"Mallyinying20_1136.png":@"Mallyinying20_960.png"];

    [self.view addSubview:yinying_imageView];
    
    UIImageView * aView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5,0,555/2,568)];
    
    aView.image = [UIImage imageNamed:@"Mallbackgurand.png"];
    
    aView.userInteractionEnabled = YES;
    
    [self.view addSubview:aView];
    
    self.view.backgroundColor = RGBCOLOR(60,44,45);
    
    UIButton * settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    settingButton.frame = CGRectMake(491/2,22,38/2,39/2);
    
    [settingButton setImage:[UIImage imageNamed:@"Mallshezhi38_39.png"] forState:UIControlStateNormal];
    
    [settingButton addTarget:self action:@selector(PushToSettingController:) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:settingButton];
    
    
    UIButton * header_image = [UIButton buttonWithType:UIButtonTypeCustom];
    
    header_image.frame = CGRectMake(220/2,102/2,115/2,112/2);
    
    [header_image setImage:[UIImage imageNamed:@"Malltouxiang115_112.png"] forState:UIControlStateNormal];
    
    
    [header_image addTarget:self action:@selector(LogInViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:header_image];
    
    
    UILabel * userName_label = [[UILabel alloc] initWithFrame:CGRectMake(0,102/2+30/2+112/2,555/2,30/2)];
    
    userName_label.text = @"登录账号";
    
    userName_label.textColor = [UIColor whiteColor];
    
    userName_label.textAlignment = NSTextAlignmentCenter;
    
    [aView addSubview:userName_label];
    
    
    
    
    
    for (int i = 0;i<2;i++)
    {
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake((555/2-481/2)/2,343/2+(189/2)*i,481/2,0.5)];
        
        line_view.backgroundColor = [UIColor colorWithRed:113/255.0 green:97/255.0 blue:100/255.0 alpha:1];
        
        [aView addSubview:line_view];
    }
    
    
    NSArray * title_array = [NSArray arrayWithObjects:@"购物车",@"我的订单",@"我的收藏夹",@"消息     ",@"草稿箱  ",@"通讯录  ",@"二维码  ",@"收藏     ",@"  夜间模式",nil];
    
    NSArray * image_array = [NSArray arrayWithObjects:@"Mallshop83_83.png",@"Malldingdan83_83.png",@"Mallcollec84_84.png",@"MallAction47_44.png",@"Mallcaogao39_42.png",@"Malltongxunlu44_42.png",@"Mallerweima35_35.png",@"Mallcollect48_46.png",@"Mallmoon44_44.png",nil];
    
    
    for (int i = 0;i < 3;i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake((555/2-481/2)/2+(20+70)*i,343/2,70,92);
        
        button.backgroundColor = [UIColor clearColor];
        
        [button setTitle:[title_array objectAtIndex:i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [button setImage:[UIImage imageNamed:[image_array objectAtIndex:i]] forState:UIControlStateNormal];

        [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,30,10)];
        
        button.titleLabel.backgroundColor = [UIColor clearColor];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(60,-65,0,0)];
        
        [aView addSubview:button];
    }
    
    
    
    for (int i = 0;i < 3;i++) {
        for (int j = 0;j < 2;j++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.backgroundColor = [UIColor clearColor];
            
            button.tag = j+i*2+999;
            
            button.frame = CGRectMake(37+122*j,303+59.5*i,100,45/2);
            
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [button setTitle:[title_array objectAtIndex:3+j+i*2] forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:[image_array objectAtIndex:3+j+i*2]] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(functionButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,60)];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
            
            [aView addSubview:button];
        }
    }
}

#pragma mark-到设置界面

-(void)PushToSettingController:(UIButton *)sender
{
    SettingViewController * setVC = [[SettingViewController alloc] init];
    
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:setVC];

    [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
}




*/



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * aView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5,0,556/2,568)];
    
    aView.image = [UIImage imageNamed:@"PersonalMoreBackGroundImage.png"];
    
    aView.userInteractionEnabled = YES;
    
    [self.view addSubview:aView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    float location_height = iPhone5?30:0;
    
    
    BOOL isLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
    
   
    if (isLogIn) {
        [self receivemyimage_head];
    }
    
//已登录
    
    saoyisao_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    saoyisao_button.frame = CGRectMake(58,79,37/2,37/2);
    
    saoyisao_button.hidden = !isLogIn;

    [saoyisao_button setImage:[UIImage imageNamed:@"person_saoyisao_37x37.png"] forState:UIControlStateNormal];
    
    [saoyisao_button addTarget:self action:@selector(saoyisaoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:saoyisao_button];
    
    
    headerImage_view = [[AsyncImageView alloc] initWithFrame:CGRectMake(101,49,150/2,150/2)];
    
    headerImage_view.layer.cornerRadius = 150/4;
    
    headerImage_view.layer.masksToBounds = YES;
    
    headerImage_view.hidden = !isLogIn;
    
    [aView addSubview:headerImage_view];
    
    
    logOut_button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    logOut_button.frame = CGRectMake(201,79,37/2,42/2);
    
    logOut_button.hidden = !isLogIn;
    
    [logOut_button setImage:[UIImage imageNamed:@"person_out_37x42.png"] forState:UIControlStateNormal];
    
    [logOut_button addTarget:self action:@selector(dengluortuichu) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:logOut_button];
    
    
    
    userName_label = [[UILabel alloc] initWithFrame:CGRectMake(88,135.5,100,15)];
    
    userName_label.textColor = [UIColor whiteColor];
    
    userName_label.textAlignment = NSTextAlignmentCenter;
    
    userName_label.font = [UIFont systemFontOfSize:33/2];
    
    [aView addSubview:userName_label];
    
    
    
    
    Follow = [[UILabel alloc] initWithFrame:CGRectMake(45,164 + location_height,27,14)];
    
    Follow.text = @"关注";
    
    Follow.hidden = !isLogIn;
    
    Follow.textAlignment = NSTextAlignmentCenter;
    
    Follow.textColor = [UIColor whiteColor];
    
    Follow.backgroundColor = [UIColor clearColor];
    
    Follow.font = [UIFont systemFontOfSize:12];
    
    [aView addSubview:Follow];
    
    Follow_label = [[UILabel alloc] initWithFrame:CGRectMake(84,163.5 + location_height,45,15)];
    
    Follow_label.hidden = !isLogIn;
    
    Follow_label.textColor = [UIColor whiteColor];
    
    Follow_label.font = [UIFont systemFontOfSize:18];
    
    Follow_label.textAlignment = NSTextAlignmentLeft;
    
    Follow_label.backgroundColor = [UIColor clearColor];
    
    [aView addSubview:Follow_label];
    
    
    
    
    Fans = [[UILabel alloc] initWithFrame:CGRectMake(Follow.frame.origin.x+234/2,164 + location_height,27,14)];
    
    Fans.text = @"粉丝";
    
    Fans.hidden = !isLogIn;
    
    Fans.textAlignment = NSTextAlignmentCenter;
    
    Fans.textColor = [UIColor whiteColor];
    
    Fans.backgroundColor = [UIColor clearColor];
    
    Fans.font = [UIFont systemFontOfSize:12];
    
    [aView addSubview:Fans];
    
    
    
    Fans_label = [[UILabel alloc] initWithFrame:CGRectMake(Fans.frame.origin.x+39,163.5 + location_height,45,15)];
    
    Fans_label.textColor = [UIColor whiteColor];
    
    Fans_label.hidden = !isLogIn;
    
    Fans_label.font = [UIFont systemFontOfSize:18];
    
    Fans_label.textAlignment = NSTextAlignmentLeft;
    
    Fans_label.backgroundColor = [UIColor clearColor];
    
    [aView addSubview:Fans_label];
    
    
    
    line_view = [[UIView alloc] initWithFrame:CGRectMake(267/2,161.5 + location_height,0.5,16)];
    
    line_view.backgroundColor = RGBCOLOR(96,99,112);
    
    line_view.hidden = !isLogIn;
    
    [aView addSubview:line_view];
    
    
   

    
    //未登录
    
    login_image = [UIButton buttonWithType:UIButtonTypeCustom];
    
    login_image.frame = CGRectMake(220/2,102/2,115/2,112/2);
    
    [login_image setImage:[UIImage imageNamed:@"Malltouxiang115_112.png"] forState:UIControlStateNormal];
    
    login_image.hidden = isLogIn;
    
    [login_image addTarget:self action:@selector(LogInViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    [aView addSubview:login_image];
    
    
    login_label = [[UILabel alloc] initWithFrame:CGRectMake(0,102/2+30/2+112/2,555/2,30/2)];
    
    login_label.text = @"登录账号";
    
    login_label.hidden = isLogIn;
    
    login_label.textColor = [UIColor whiteColor];
    
    login_label.textAlignment = NSTextAlignmentCenter;
    
    [aView addSubview:login_label];
    
    
    
    UIImageView * SquaredBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(23.25,200 + location_height,231,230)];
    
    SquaredBackGroundView.image = [UIImage imageNamed:@"SquaredBackGroundImage.png"];
    
    SquaredBackGroundView.userInteractionEnabled = YES;
    
    [aView addSubview:SquaredBackGroundView];
    
    
    NSArray * array1 = [NSArray arrayWithObjects:@"person_xiaoxi_45x42.png",@"person_tongxunlu_46x43.png",@"person_caogaoxiang_40x42.png",@"person_erweima_34x34.png",@"person_huancun_38x38.png",@"person_fankui_43x29.png",@"person_gengxin_28x39.png",@"person_about_40x40.png",@"person_night_39x40.png",@"person_xiaoxi-1_45x42.png",@"person_tongxunlu-1_46x43.png",@"person_caogaoxiang-1_40x42.png",@"person_erweima-1_34x34.png",@"person_huancun-1_38x38.png",@"person_fankui-1_43x29.png",@"person_gengxin-1_28x39.png",@"person_about-1_40x40.png",@"person_night-1_39x40.png",nil];
    
    NSArray * array2 = [NSArray arrayWithObjects:@"消  息",@"通讯录",@"草稿箱",@"二维码",@"清除缓存",@"意见反馈",@"版本更新",@"关  于",@"夜间模式",nil];
    
    
    for (int i = 0;i < 3;i++) {
        for (int j = 0;j < 3;j++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(0.5+76.5*j,0.5+76.5*i,76,76);
            
            button.tag = 1000+j+i*3;
            
            UIImage * normal_image = [UIImage imageNamed:[array1 objectAtIndex:j+i*3]];
            
            UIImage * highLighted_image = [UIImage imageNamed:[array1 objectAtIndex:j+i*3+9]];
            
            [button setImage:normal_image forState:UIControlStateNormal];
            
            [button setImage:highLighted_image forState:UIControlStateHighlighted];
            
            [button setTitle:[array2 objectAtIndex:j+i*3] forState:UIControlStateNormal];
            
            [button setTitleColor:RGBCOLOR(142,142,142) forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12.5];
            
            button.titleLabel.backgroundColor = [UIColor clearColor];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(46,-17,0,0)];
            
            [button setImageEdgeInsets:UIEdgeInsetsMake(0,(76-normal_image.size.width)/2,30,(76-normal_image.size.width)/2)];
            
            [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [SquaredBackGroundView addSubview:button];
        }
    }
    
    
    UILabel * copyRight = [[UILabel alloc] initWithFrame:CGRectMake(0,(iPhone5?568:480)-40,555/2,20)];
    
    copyRight.text = [NSString stringWithFormat:@"Copyright © 2002-%@ FBLIFE.com",[self stringFromDate]];

    copyRight.textAlignment = NSTextAlignmentCenter;
    
    copyRight.textColor = RGBCOLOR(96,100,111);
    
    copyRight.font = [UIFont systemFontOfSize:10];

    copyRight.backgroundColor = [UIColor clearColor];
    
    [aView addSubview:copyRight];
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * myDictionary = [user objectForKey:@"myInformationData"];
    
    if (myDictionary) {
        [self loadMyInformationDataWith:myDictionary];
    }
    
    
    hud = [[ATMHud alloc] initWithDelegate:self];
    
    [self.view addSubview:hud.view];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivemyimage_head) name:@"successLoginToLoadPersonalData" object:nil];
    
}



- (NSString *)stringFromDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY"];
    
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return destDateString;
    
}


//button点击方法

-(void)doButton:(UIButton *)sender
{
    switch (sender.tag-1000) {
        case 0:
            [self pushToMessageController];
            [self.leveyTabBarController hidesTabBar:NO animated:YES];
            break;
        case 1:
            [self pushToFriendListController];
            [self.leveyTabBarController hidesTabBar:NO animated:YES];
            break;
        case 2:
            [self pushToDraftBoxController];
            [self.leveyTabBarController hidesTabBar:NO animated:YES];
            break;
        case 3:
        {
            QrcodeViewController * qrcode = [[QrcodeViewController alloc] init];
            
            qrcode.headImage = headerImage_view.image;
            
            qrcode.uid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_UID];
            
            qrcode.nameString = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
            
            UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:qrcode];
            
            [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
            
            [self.navigationController pushViewController:naVC animated:YES];
        }
            
            break;
        case 4:
            [self removeCache];
            break;
        case 5:
            [self feedback];
            break;
        case 6:
            [self checkVersionUpdate];
            break;
        case 7:
        {
            if ([self isLogin])
            {
                AboutViewController * aboutVC = [[AboutViewController alloc] init];
                
                UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:aboutVC];
                
                [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
            }else
            {
                [self login];
            }
            
            [self.leveyTabBarController hidesTabBar:NO animated:YES];
        }
            break;
        case 8:
        {
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            
            BOOL nightMode = [userDefaults boolForKey:@"nightMode"];
            
            [[(AppDelegate *)[UIApplication sharedApplication].delegate shadowView] setHidden:nightMode];
            
            [userDefaults setBool:!nightMode forKey:@"nightMode"];
            
            [userDefaults synchronize];
        }
            break;
            
        default:
            break;
    }
}


//扫一扫

-(void)saoyisaoButton:(UIButton *)sender
{
    [self pushToQrcodeController];
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
}


-(void)login
{
    if (!logIn)
    {
        logIn = [[LogInViewController alloc] init];
        
        logIn.delegate = self;
    }
    
    [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:logIn animated:YES];
    
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
}

-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_IN];
}

-(void)LogInViewShow:(UIButton *)button
{
    [self login];
}

#pragma mark-到消息

-(void)pushToMessageController
{
    if ([self isLogin])
    {
        MessageViewController *message=[[MessageViewController alloc]init];
        
        if (string_messageorfb.length>0)
        {
            message.string_messageorfbno=string_messageorfb;
            
        }else if( self.leveyTabBarController.tabBar.tixing_imageView.hidden==NO)
        {
            message.string_messageorfbno=@"fb";
        }
        
        string_messageorfb=@"";
        
        self.leveyTabBarController.tabBar.tixing_imageView.hidden = YES;
        
        UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:message];
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
        
        
    }else{
        [self login];
    }
    
}

#pragma mark-到通讯录

-(void)pushToFriendListController
{
    
    if ([self isLogin])
    {
        FriendListViewController *message=[[FriendListViewController alloc]init];
        
        message.title_name_string = @"mine";
        
        message.delegate = self;
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:message animated:YES];
    }else
    {
        [self login];
    }
}


#pragma mark-到草稿箱

-(void)pushToDraftBoxController
{
    if ([self isLogin])
    {
        DraftBoxViewController *draft=[[DraftBoxViewController alloc]init];
        
        UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:draft];
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
    }else
    {
        [self login];
    }
}

#pragma mark-到二维码

-(void)pushToQrcodeController
{
    
    if ([self isLogin])
    {
        DetailViewController *_qrcode=[[DetailViewController alloc]init];
        
        UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:_qrcode];
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
    }else
    {
        [self login];
    }
}


-(void)returnUserName:(NSString *)username Uid:(NSString *)uid
{
    NewMineViewController * mine = [[NewMineViewController alloc] init];
    
    mine.uid = uid;
    
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:mine];
    
    [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];

}

-(void)atSomeBodys:(NSString *)string
{
    
}


#pragma mark-LogInDelegate


-(void)successToLogIn
{
    [self setAllViewHidden:YES];
    
    [self receivemyimage_head];
}

-(void)failToLogIn
{
    
}


#pragma mark-AsyncImageDelegate

-(void)handleImageLayout:(AsyncImageView *)tag
{
    
}


-(void)removeCache
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清空缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alertView.tag = 556;
    
    [alertView show];
}
-(void)feedback{
    
    if ([self isLogin])
    {
        UMFeedbackViewController *feedb=[[UMFeedbackViewController alloc]init];
        
        UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:feedb];
        
        [[(AppDelegate *)[UIApplication sharedApplication].delegate fansVC] presentModalViewController:naVC animated:YES];
    }else
    {
        [self login];
    }
}


-(void)checkVersionUpdate
{
    NSURL * fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://bbs.fblife.com/bbsapinew/version.php?appversion=%@",NOW_VERSION]];
    
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:fullUrl];
    
    __block ASIHTTPRequest * _request = request;
    
    
    request.delegate = self;
    
    [_request setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            
            NSString * bbsInfo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bbsinfo"]];
            NSLog(@"dic===%@",dic);
            if (![bbsInfo isEqualToString:NOW_VERSION])
            {
                NSString * new = [NSString stringWithFormat:@"我们的%@版本已经上线了,赶快去更新吧!",bbsInfo];
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发现新版本" message:new delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:@"稍后提示",nil];
                
                alert.delegate = self;
                
                alert.tag = 10000;
                
                [alert show];
                
                
            }else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"版本更新检查" message:@"您目前使用的是最新版本" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
    }];
    
    
    [_request setFailedBlock:^{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测失败,请检查您当前网络是否正常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        [alert show];
    }];
    
    [request startAsynchronous];
}

#pragma mark-UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1 && alertView.tag == 555) {
        [self deletetoken];
        
        [self setAllViewHidden:NO];
        
        self.leveyTabBarController.tabBar.tixing_imageView.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearolddata" object:nil];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"" forKey:USER_NAME] ;
        [user setObject:@"" forKey:USER_PW] ;
        [user setObject:@"" forKey:USER_AUTHOD] ;
        [user setObject:@"" forKey:USER_UID] ;
        string_follownumber=@"";
        string_fansnumber=@"";
        
        [user setBool:NO forKey:USER_IN];
        
        [user removeObjectForKey:@"friendList"];
        [user removeObjectForKey:@"RecentContact"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clean" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeTheTimer" object:nil];
        
        
        [user synchronize];
    }else if (buttonIndex == 0 && alertView.tag == 10000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/yue-ye-yi-zu/id605673005?mt=8"]];
    }else if (buttonIndex == 1 && alertView.tag == 556)
    {
        [[SDImageCache sharedImageCache] clearDisk];
        [[FullyLoaded sharedFullyLoaded] removeAllCacheDownloads];
        
        
        [self hudRemove:YES];
        
        [self performSelector:@selector(hudRemove:) withObject:NO afterDelay:1.5];
    }
}


-(void)hudRemove:(BOOL)isCom
{
    if (isCom) {
        [hud setBlockTouches:NO];
        [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
        [hud setCaption:@"正在清除缓存"];
        [hud setActivity:YES];
        [hud show];
    }else
    {
        [hud setBlockTouches:NO];
        [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
        [hud setCaption:@"缓存清除成功"];
        [hud setActivity:NO];
        [hud setImage:[UIImage imageNamed:@"19-check"]];
        [hud show];
        [hud hideAfter:0.4];
    }
}



-(void)dengluortuichu{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定注销此账号?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = 555;
    
    [alert show];
}


-(void)loadMyInformationDataWith:(NSDictionary *)dictionary
{
    string_face_original=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"face_original"]];
    
    Fans_label.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"fans_count"]];
    
    Follow_label.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"follow_count"]];
    
    userName_label.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"username"]];
    
    NSString *string_uid=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"uid"]];
    
    [[NSUserDefaults standardUserDefaults]setObject:string_uid forKey:USER_UID];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"successgetuid" object:Nil];
    
    [headerImage_view loadImageFromURL:string_face_original withPlaceholdImage:[UIImage imageNamed:@"ios7_headimplace.png"]];
}

-(void)receivemyimage_head{
    
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:URL_USERMESSAGE,@"(null)",authkey];
    NSLog(@"1请求的url = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"个人信息 -=-=  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] !=1)
            {
                NSDictionary * dictionary = [[[dic objectForKey:@"data"] allValues] objectAtIndex:0];
                NSLog(@"dictionary=%@",dictionary);
                
                
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                
                [userDefaults setObject:dictionary forKey:@"myInformationData"];
                
                [userDefaults synchronize];
                
                [self loadMyInformationDataWith:dictionary];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
}

#pragma mark-退出登录，消除devicetoken

-(void)deletetoken{
    //    http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=sdfasfdsafdasdf&token=ssdfasdfaddfgdsgf2a&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json
    
    
    NSString *stringdevicetoken=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:DEVICETOKEN]];
    NSString *authkey=[[NSUserDefaults standardUserDefaults] objectForKey:USER_AUTHOD];
    NSString * fullURL= [NSString stringWithFormat:@"http://bbs2.fblife.com/localapi/user_app_token.php?action=deltoken&authcode=%@&token=%@&token_key=01b1f00235ae1d46432ba45771beb2d1&datatype=json",authkey,stringdevicetoken];
    NSLog(@"删除的urlurl = %@",fullURL);
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:fullURL]];
    
    __block ASIHTTPRequest * _requset = request;
    
    _requset.delegate = self;
    
    [_requset setCompletionBlock:^{
        
        @try {
            NSDictionary * dic = [request.responseData objectFromJSONData];
            NSLog(@"删除消息 -=-=  %@",dic);
            
            if ([[dic objectForKey:@"errcode"] intValue] ==0)
            {
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            
        }
        
        
    }];
    
    
    [_requset setFailedBlock:^{
        
        [request cancel];
        
        
        //        [self initHttpRequestInfomation];
    }];
    
    [_requset startAsynchronous];
    
    
}
-(void)LogOut
{
    [hud show];
    //弹出提示信息
    [hud setBlockTouches:NO];
    [hud setAccessoryPosition:ATMHudAccessoryPositionLeft];
    [hud setShowSound:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    [hud setCaption:NS_EXIT_SUC];
    [hud setActivity:NO];
    [hud show];
    [hud hideAfter:3];
}



-(void)setAllViewHidden:(BOOL)isLogIn
{
    login_image.hidden = isLogIn;
    
    login_label.hidden = isLogIn;
    
    
    saoyisao_button.hidden = !isLogIn;
    
    headerImage_view.hidden = !isLogIn;
    
    userName_label.hidden = !isLogIn;
    
    Follow_label.hidden = !isLogIn;
    
    Fans_label.hidden = !isLogIn;
    
    line_view.hidden = !isLogIn;
    
    logOut_button.hidden = !isLogIn;
    
    Fans.hidden = !isLogIn;
    
    Follow.hidden = !isLogIn;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end









