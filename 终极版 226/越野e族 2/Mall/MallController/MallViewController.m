//
//  MallViewController.m
//  越野e族
//
//  Created by 史忠坤 on 14-3-19.
//  Copyright (c) 2014年 soulnear. All rights reserved.
//

#import "MallViewController.h"
#import "DetailClassifyViewController.h"
#import "MainMagiClanternModel.h"
#import "shouyehuandengfeed.h"
#import "ShouyeheaderView.h"//右边带红点的view
#import "FiveStareView.h"
#import "MainSixClassic.h"
#import "MainMallSearchViewController.h"
#import "MainFourClassicView.h"//带图片的分类的view
#import "ClassifyViewController.h"//六大分类跳过去



@interface MallViewController (){
    
    NSMutableArray *SlideArray;//幻灯
    NSArray *fivestarArray;//五星商家
    NSArray *sixClassicArray;//六大分类
    NSMutableArray *fourtitlearray;//四个的分类的title，可能会增加
    NSArray *fourinfoSArray;//四个array的info;
    
    
}

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
    
    SlideArray=[NSMutableArray array];//存储幻灯数据
    fivestarArray=[NSArray array];
    sixClassicArray=[NSArray array];
    fourtitlearray=[NSMutableArray array];
    fourinfoSArray=[NSArray array];

    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.navigationItem.title = @"商城";
    

    self.leftImageName = @"MallLeft40_32.png";
    
    [self setMyViewControllerLeftButtonType:MyViewControllerLeftbuttonTypeOther WithRightButtonType:MyViewControllerRightbuttonTypePerson];
    
    
    _MainTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?568-64-49:480-64-49) style:UITableViewStylePlain];
    _MainTabView.delegate=self;
    _MainTabView.dataSource=self;
    _MainTabView.backgroundColor=[UIColor whiteColor];
    _MainTabView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_MainTabView];
    
//    __weak typeof(self) __weakself=self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
//        [__weakself StartLoadSlideShow];
//        [__weakself startLoadFiveStarMall];
//        [__weakself startLoadSixClassic];
//        [__weakself startLoadFourSuggest];
//    });
    
    
    
//    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_block_t block1=^{
//
//    };
    
    [self StartLoadSlideShow];
    [self startLoadFiveStarMall];
    [self startLoadSixClassic];
    [self startLoadFourSuggest];
    
    
    
    
    NSLog(@"xxxxxafter");
//
    
    
    
    
	// Do any additional setup after loading the view.
}

#pragma mark-tableview的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2+fourinfoSArray.count+2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *array_title=[NSArray arrayWithObjects:@"推荐商品",@"整车",@"户外运动",@"改装零部件",@"产品分类",@"五星商家", nil];

    if (indexPath.row==0) {

        
        static NSString *identifier=@"identifier0";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIImageView *bigkuangImV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ZMallsearch-kuang_592x56.png"]];
            bigkuangImV.center=CGPointMake(160, 22);
            [cell.contentView addSubview:bigkuangImV];
            
            UIImageView *searchImv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ZMallsearch_26x26.png"]];
            searchImv.center=CGPointMake(85, 22);
            [cell.contentView addSubview:searchImv];
            
            searchfield=[[UITextField alloc]initWithFrame:CGRectMake(98, 14, 180, 16)];
            searchfield.backgroundColor=[UIColor clearColor];
            searchfield.font=[UIFont systemFontOfSize:14];
            searchfield.placeholder=@"请输入要搜索的商品/店铺";
            searchfield.delegate=self;
            searchfield.returnKeyType=UIReturnKeySearch;
            [cell.contentView addSubview:searchfield];

        }
        

        
         return cell;
    }
    if (indexPath.row==1) {
        
        
        static NSString *identifier=@"identifier1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            SGFocusImageFrame *bannerView =[[SGFocusImageFrame alloc]initWithFrame:CGRectMake(0, 0, 320, 143)];
            [cell.contentView addSubview:bannerView];
            bannerView.tag=1024;
        }
        

        
        
        int length = SlideArray.count;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0 ; i < length; i++)
        {
            shouyehuandengfeed *feed=[SlideArray objectAtIndex:i];

            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"test",@"title" ,feed.slide_img,@"image",feed.link,@"link",feed.type,@"type",feed.link,@"idoftype",nil];
            
            
            NSLog(@"dict===%@",dict);
            
            [tempArray addObject:dict];
        }
        
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
        if (length > 1)
        {
            NSDictionary *dict = [tempArray objectAtIndex:length-1];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:-1] ;
            [itemArray addObject:item];
        }
        for (int i = 0; i < length; i++)
        {
            NSDictionary *dict = [tempArray objectAtIndex:i];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:i] ;
            [itemArray addObject:item];
            
        }
        //添加第一张图 用于循环
        if (length >1)
        {
            NSDictionary *dict = [tempArray objectAtIndex:0];
            SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithDict:dict tag:length];
            [itemArray addObject:item];
        }
        SGFocusImageFrame *bannerView =(SGFocusImageFrame *)[cell.contentView viewWithTag:1024];
        [bannerView setarray:itemArray delegate:self isAuto:YES type:2] ;
        //[[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, 320, 143) delegate:self imageItems:itemArray isAuto:NO type:2];
        
        [bannerView scrollToIndex:0];
        return cell;
        
        
    }
//    
    //
    else if(indexPath.row==2+1+fourinfoSArray.count){
        //五星商家

        static NSString *identifier=@"identifier3";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            FiveStareView *_fiveView=[[FiveStareView alloc]initWithFrame:CGRectMake(0, 0, 320, 38+48+18)];
            _fiveView.tag=998;
            [cell.contentView addSubview:_fiveView];
        }
        
        FiveStareView *_fiveView=(FiveStareView *)[cell.contentView viewWithTag:998];
        [_fiveView setArray:fivestarArray block:^(int tag) {
            
            [self turntonShangjiawithId:tag];
            
        }];
//
        return cell;
        
    }else if(indexPath.row==2+fourinfoSArray.count) {
        
        
        
        //六大分类的
        
        static NSString *identifier=@"identifier4";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            MainSixClassic *_classicV=[[MainSixClassic alloc]initWithFrame:CGRectMake(0, 0, 320, 38+249*sixClassicArray.count/6)];
            _classicV.tag=909;
            [cell.contentView addSubview:_classicV];


        }
        
     
        cell.contentView.backgroundColor=RGBCOLOR(236, 236, 236);
        
        MainSixClassic *_classicV=(MainSixClassic *)[cell.contentView viewWithTag:909];
        [_classicV setArray:sixClassicArray block:^(int tag) {
            
            NSLog(@"跳到六大分类的=%d",tag);
            
            ClassifyViewController *_clV=[[ClassifyViewController alloc]init];
            _clV.str_id=[NSString stringWithFormat:@"%d",tag];
            [self.navigationController pushViewController:_clV animated:YES];
            

            
        }];
//

        return cell;
        
        
    }
    else {
        
        NSLog(@"xxxxxindexpath.row==%d====%d",indexPath.row,fourinfoSArray.count);
        
        
        static NSString *identifier=@"identifier2";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            MainFourClassicView *fourView=[[MainFourClassicView alloc]initWithFrame:CGRectMake(0, 0, 320, 133+38)];
            fourView.tag=808;
            [cell.contentView addSubview:fourView];

        }
   
        //四个分类的
        cell.contentView.backgroundColor=[UIColor clearColor];
        MainFourClassicView *fourView=(MainFourClassicView *)[cell.contentView viewWithTag:808];
        [fourView setArr:[fourinfoSArray objectAtIndex:indexPath.row-2] bloc:^(int tag) {
            
            
            
            NSLog(@"四大分类的。。。。tag===%d",tag);
            
        }];
        
        
        return cell;
        
    }

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        //search
        return 44;
    }else if(indexPath.row==1){
        //幻灯
        return 143;
    }
        else if(indexPath.row==2+1+fourinfoSArray.count){
        //五星商家
        return 38+48+18;
    }else if(indexPath.row==2+fourinfoSArray.count){
        //产品六大分类
        return 38+249*sixClassicArray.count/6;
        
    }
    else {
        
        
        
        return 133+38;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  ProductDetailViewController * product = [[ProductDetailViewController alloc] init];
    
   // [self.navigationController pushViewController:product animated:YES];
    
    
    if (indexPath.row==0) {
        [searchfield becomeFirstResponder];
    }
}

#pragma mark--uitextfield的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self turntoSearchWithString:textField.text];
    return YES;
}


#pragma mark-跳到分类页面
-(void)backto{
    NSLog(@"跳到分类页面");
    
    
    
    
    DetailClassifyViewController *_ClassifyVC=[[DetailClassifyViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:_ClassifyVC];
    [self presentModalViewController:nav animated:YES];
    self.leveyTabBarController.tabBar.hidden=YES;

    
}
#pragma mark-跳到商家页面

-(void)turntonShangjiawithId:(int )tag{
    
    NSLog(@"跳到商家的，商家id===%d",tag);
    
    
    
}

#pragma mark-跳转到分类界面

-(void)turntoClassicwithId:(int )idofClassic{
    
}

#pragma mark-跳转到搜索界面去

-(void)turntoSearchWithString:(NSString *)nameofSearch{
    
    NSLog(@"nameofsearch====%@",nameofSearch);
    searchfield.text=@"";
    [searchfield resignFirstResponder];
    MainMallSearchViewController *_searV=[[MainMallSearchViewController alloc]init];
    _searV.searchgoodsnameString=nameofSearch;
    [self.navigationController pushViewController:_searV animated:YES];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [searchfield resignFirstResponder];
    
}



#pragma mark-请求幻灯数据

-(void)StartLoadSlideShow{
    
    
    
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    
    __weak typeof(SlideArray) _weakSlideArray=SlideArray;
    __weak typeof(_MainTabView) _weak_MainTabView=_MainTabView;

    [_magicModel SeturlStr:@"http://mall.fblife.com/api.php?app=index&act=slides&formattype=json" block:^(NSArray *arrayinfo, NSString *errorindo) {
        
        
        
       
            NSLog(@"请求到幻灯的数据%@",arrayinfo);
            
            for (int i=0; i<arrayinfo.count; i++) {
                shouyehuandengfeed *shouyefeed=[[shouyehuandengfeed alloc]init];
                [shouyefeed setDic:[arrayinfo objectAtIndex:i]];
                [_weakSlideArray addObject:shouyefeed];
 
            }
            [_weak_MainTabView reloadData];


        
    }];
}


#pragma mark-请求五星商家的数据

-(void)startLoadFiveStarMall{
    
    
    
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:@"http://mall.fblife.com/api.php?app=index&act=recomstore&formattype=json" block:^(NSArray *arrayinfo, NSString *errorindo) {
        
        NSLog(@"请求五星商家得到数据%@",arrayinfo);
        fivestarArray=arrayinfo;
            [_MainTabView reloadData];

        
        
    }];
}

#pragma mark-请求四大分类的数据（推荐、整车、户外、改装零部件）
-(void)startLoadFourSuggest{
    
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:@"http://mall.fblife.com/api.php?app=index&act=goods&formattype=json" block:^(NSArray *arrayinfo, NSString *errorindo) {
        NSDictionary *dicinfo=[NSDictionary dictionary];
        dicinfo=(NSDictionary *)arrayinfo;
       fourinfoSArray=[dicinfo allValues];
        
            [_MainTabView reloadData];

        
    }];
    
}

#pragma mark-请求六大分类的数据
-(void)startLoadSixClassic{
    
    
    MainMagiClanternModel *_magicModel=[[MainMagiClanternModel alloc]init];
    [_magicModel SeturlStr:@"http://mall.fblife.com/api.php?app=index&act=goodscate&formattype=json" block:^(NSArray *arrayinfo, NSString *errorindo) {
        
        NSLog(@"请求五星商家得到数据%@",arrayinfo);
        sixClassicArray=arrayinfo;
        
            [_MainTabView reloadData];

        
        
        
    }];
    
    
}


#pragma mark-SGFocusImageItem的代理
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item
{
    
    
    
    NSLog(@"%s \n click===>%@",__FUNCTION__,item.title);
    
    UIViewController *copyRoot=self;
    
    
        int type;
        NSString *string_link_;
        @try {
            type=[item.type intValue];
            
            string_link_=item.link;
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
            return;
            
        }@finally {
            switch (type) {
                case 1:
                {
                    
                    
                    
                    NSLog(@"到商品页面的%@",item.idoftype);
//                    newsdetailViewController *  comment_=[[newsdetailViewController alloc]init];
//                    
//                    comment_.string_Id=item.idoftype;
//                    [copyRoot.leveyTabBarController hidesTabBar:YES animated:YES];
//                    [copyRoot.navigationController pushViewController:comment_ animated:YES];//跳入下一个View
                    
                    
                }
                    break;
                    
                case 2:{
                    NSLog(@"到商铺页面%@",item.idoftype);
//                    bbsdetailViewController *_bbsdetail=[[bbsdetailViewController alloc]init];
//                    _bbsdetail.bbsdetail_tid=item.idoftype;
//                    [copyRoot.navigationController pushViewController:_bbsdetail animated:YES];
                    
                    
                }
                    break;
                case 3:{
                    
                    NSLog(@"外联的");
//                    copyRoot.navigationController.navigationBarHidden=NO;
                    NSLog(@"第三种情况link=%@",string_link_);
                    fbWebViewController *_web=[[fbWebViewController alloc]init];
                    _web.urlstring=item.link;
                    [copyRoot.navigationController pushViewController:_web animated:YES];
                    
                }
                    
                default:
                    break;
            }
            
            
        }
    
}
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index;
{
}
#pragma mark-
-(void)dealloc{
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
