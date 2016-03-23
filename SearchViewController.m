//
//  SearchViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/11/9.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "SearchViewController.h"

#import <AMapSearchKit/AMapSearchKit.h>

#import "MapListViewController.h"

#import "TipModel.h"

#import "POIModel.h"

#import "POITableViewCell.h"

#import "TipTableViewCell.h"

@interface SearchViewController ()<AMapSearchDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
/// 搜索类
@property (nonatomic,strong) AMapSearchAPI *search;
/// 搜索提示请求
@property (nonatomic,strong) AMapInputTipsSearchRequest *request;
//
@property (nonatomic,strong) UISearchBar *searchBar;
//搜索提示数组
@property (nonatomic,strong) NSMutableArray *tips;
//地图POI搜索数组
@property (nonatomic,strong) NSMutableArray *array;
//搜索提示tableView
@property (nonatomic,strong) UITableView *tipsTableView;
//按距离按价格切换
@property (nonatomic,strong) UIButton *button;
//导航栏view
@property (nonatomic,strong) UIView *naview;

@property (nonatomic,assign) CGFloat  la;

@property (nonatomic,assign) CGFloat  lo;
//判断是什么类型的搜索
@property (nonatomic,copy)   NSString *poiOrTip;
//poi搜索页数
@property (nonatomic,assign) int page;

@end


@implementation SearchViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _search = [[AMapSearchAPI alloc]init];
        
        _search.delegate = self;
        
        _request = [[AMapInputTipsSearchRequest alloc]init];
        
    }
    return self;
}

-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(NSMutableArray *)tips{
    if (_tips == nil) {
        _tips = [NSMutableArray array];
    }
    return _tips;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [MobClick beginLogPageView:@"ThreePage"];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ThreePage"];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBarHidden = YES;
//    
//    //设置导航栏View
//    self.naview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
//    
//    self.naview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BEIJING@2x"]];
//    
//    [self.view addSubview:_naview];
//    
//    UIButton *button = [UIButton buttonWithFrame:CGRectMake(-2,5,85,70)type:UIButtonTypeCustom title:nil target:self action:@selector(backButtonClick:)];
//    
//    [button setBackgroundImage:[UIImage imageNamed:@"fh"] forState:UIControlStateNormal];
//    
//    [self.naview addSubview:button];
    
    [self initNav:@"" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    //设置appkey
    [AMapSearchServices sharedServices].apiKey = amapAppKey;
    
    //初始化searchBar
    [self initSearchBar];
    
}


- (void)backButtonClick:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --  buttonClick 关键字搜索
- (void)buttonClick{
    
    self.poiOrTip = @"poi";
    
    self.page = 1;
    
    if (_searchBar.text.length ==0) {
        
        MapListViewController *listController = [[MapListViewController alloc]init];
        
        listController.mode = self.mode;
        
        listController.hire_method_id = self.hire_method_id;
        
        listController.hire_field = self.hire_field;
        
        listController.hire_type = self.hire_type;
        
         listController.ruleStr = self.ruleStr;
        
        listController.name = [StringChangeJson getValueForKey:@"address"];
        
        listController.latitude = [[NSString stringWithFormat:@"%@",[StringChangeJson getValueForKey:@"la"]] floatValue];
        
        listController.longitude = [[NSString stringWithFormat:@"%@",[StringChangeJson getValueForKey:@"lo"]] floatValue];
        
        if ([StringChangeJson getValueForKey:@"lo"] && [StringChangeJson getValueForKey:@"la"]) {
            
            [self.navigationController pushViewController:listController animated:YES];
            
        }
        
    }else{
        
        [self.tips removeAllObjects];
        
        [self.searchBar resignFirstResponder];
        
        [self.tipsTableView reloadData];
        
        //上拉刷新
        self.tipsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.page = 1;
            
            [self newThread];
            
        }];
        //下拉加载
        self.tipsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.page += 1;
            [self newThread];
        }];
        
        [NSThread detachNewThreadSelector:@selector(newThread) toTarget:self withObject:nil];
    }
}

//高德地图POI关键字搜索
- (void)newThread{
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc]init];
    
    request.offset = 20;//返回的数据个数
    
    request.page = self.page;
    
    request.city = [StringChangeJson getValueForKey:@"city"]; //设置搜索城市
    
    if (self.searchBar.text.length != 0) {
        
         request.keywords = self.searchBar.text;
        
    }else{
        
        request.keywords = [StringChangeJson getValueForKey:@"address"];
        
    }
    [self.search AMapPOIKeywordsSearch:request];
}

//高德地图POI搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    [self.array removeAllObjects];
    
    [self.array setArray:response.pois];
    
    [self.tipsTableView reloadData];
    
    [self.tipsTableView.mj_footer endRefreshing];
    
    [self.tipsTableView.mj_header endRefreshing];
    
}

//高德地图输入提示搜索
- (void)searchDisplay:(NSString *)string{
    
    if (string.length == 0) {
        
        return;
    }
    
    _request.keywords = string;
    
    _request.city = [StringChangeJson getValueForKey:@"city"];
    
    [_search AMapInputTipsSearch:_request];
    
}

//高德地图输入提示搜索回调
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    
    [self.tips removeAllObjects];
    
    [self.tips setArray:response.tips];
    
    [self.tipsTableView reloadData];
    
}

//初始化SearchBar
- (void)initSearchBar{
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(35,20,frameX-100,43)];
    
    self.searchBar.backgroundImage = [UIImage imageNamed:@"BEIJING@2x"];
    
    self.searchBar.barStyle = UISearchBarStyleDefault;
    
    self.searchBar.showsSearchResultsButton = NO;
    
    self.searchBar.placeholder = @"不输入即搜索周边车位";
    
    self.searchBar.delegate = self;
    
    self.searchBar.showsCancelButton = NO;
    
    [self.view addSubview:self.searchBar];
    
    //搜索按钮
    _button = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.searchBar.frame), 26 ,54,30) type:UIButtonTypeCustom title:@"搜 索" target:self action:@selector(buttonClick)];
    
    _button.titleLabel.font = UIFont(15);
    
    _button.backgroundColor = RGB(64, 135, 222);
    
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _button.layer.masksToBounds = YES;
    
    _button.layer.cornerRadius = 5.0;
    
    [self.view addSubview:_button];
    
    
    //搜索提示tableView
    self.tipsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX, frameY - 49-64) style:UITableViewStylePlain];
    
    self.tipsTableView.backgroundColor = [UIColor whiteColor];
    
    self.tipsTableView.dataSource = self;
    
    self.tipsTableView.delegate = self;
    
    self.tipsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frameX,100)];
    
    self.tipsTableView.tableFooterView = footerView;
    
    [self.view addSubview:self.tipsTableView];
    
}

#pragma mark ---- UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.poiOrTip = @"tip";
    
    [self.array removeAllObjects];
    
    [self.tips removeAllObjects];
    
    [self searchDisplay:searchBar.text];
    
    [self.tipsTableView reloadData];
    
}

#pragma mark ---- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    
    if ([self.poiOrTip isEqualToString:@"tip"]) {
        
        rows =  self.tips.count;
        
    }else if ([self.poiOrTip isEqualToString:@"poi"]){
        
        rows = self.array.count;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.poiOrTip isEqualToString:@"tip"]) {
        
        static NSString *tipCellIdentifier = @"tipCellIdentifier";
        
        TipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
        
        if (cell == nil)
        {
            cell = [[TipTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                           reuseIdentifier:tipCellIdentifier];
        }
        
        AMapTip *tip = self.tips[indexPath.row];
        
        cell.model = (TipModel *)tip;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }

    static NSString *ident = @"ident";
    
    POITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cells) {
        
        cells = [[POITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        
    }
    
    AMapPOI *poi = self.array[indexPath.row];
    
    cells.model = (POIModel *)poi;
    
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cells;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MapListViewController *listController = [[MapListViewController alloc]init];
     
    listController.mode = self.mode;
     
    listController.hire_method_id = self.hire_method_id;
     
    listController.hire_field = self.hire_field;
     
    listController.hire_type = self.hire_type;
     
    listController.ruleStr = self.ruleStr;
     
    if ([self.poiOrTip isEqualToString:@"tip"]) {
         
        AMapTip *tip = self.tips[indexPath.row];
         
        listController.name = tip.name;
         
        listController.latitude = tip.location.latitude;
         
        listController.longitude = tip.location.longitude;

    }else if ([self.poiOrTip isEqualToString:@"poi"]){
         
        AMapPOI *poi = self.array[indexPath.row];
         
        listController.name = poi.name;
         
        listController.latitude = poi.location.latitude;
         
        listController.longitude = poi.location.longitude;
    }
    
    [self.navigationController pushViewController:listController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightRow;

    if (frameX == 320.0) {
        heightRow = 40;
    }else {
        heightRow = 45;
    }
    
    return heightRow;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self buttonClick];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self.searchBar resignFirstResponder];
    
    self.searchBar.text = nil;
    
    [self.tips removeAllObjects];
    
    [self.array removeAllObjects];
    
    [self.tipsTableView reloadData];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}


@end