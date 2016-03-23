//
//  SearchParkViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/28.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "SearchParkViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapListViewController.h"
#import "TipTableViewCell.h"
#import "TipModel.h"
#import "POIModel.h"
#import "POITableViewCell.h"
#import "UIImage+navationBar.h"

@interface SearchParkViewController ()<AMapSearchDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) AMapInputTipsSearchRequest *request;
@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) NSMutableArray *tips;

@property (nonatomic,copy) NSString *string;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,strong) UITableView *tipsTableView;
@property (nonatomic,strong) UIButton *button;

@end


@implementation SearchParkViewController

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
        
        self.array = [NSMutableArray array];
        
    }
    
    return _array;
}

-(NSMutableArray *)tips{
    
    if (_tips == nil) {
        
        self.tips = [NSMutableArray array];
        
    }
    
    return _tips;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"Twenty-twoPage"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Twenty-twoPage"];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [AMapSearchServices sharedServices].apiKey = amapAppKey;

    [self initNav:@"" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self initSearchBar];
    
}


#pragma mark --  buttonClick
- (void)buttonClick:(UIButton *)button{
    
    [self.array removeAllObjects];
    
    [self.tableView removeFromSuperview];
    
    [self.searchBar resignFirstResponder];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX, frameY) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    UIView *view = [[UIView alloc]init];
    if (frameX == 320.0) {
        view.frame = CGRectMake(0, 0, frameX, 85);
    }else{
        view.frame = CGRectMake(0, 0, frameX, 120);
    }
    self.tableView.tableFooterView = view;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    [NSThread detachNewThreadSelector:@selector(newThread) toTarget:self withObject:nil];
    
}

//高德地图POI关键字搜索
- (void)newThread{
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc]init];
    
    request.offset = 20;
    
    request.keywords = self.searchBar.text;
    
    request.city = [StringChangeJson getValueForKey:@"city"];
    
    [self.search AMapPOIKeywordsSearch:request];
    
}

//高德地图POI关键字搜索回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    [self.array removeAllObjects];
    
    [self.array setArray:response.pois];
    
    [self.tableView reloadData];
    
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
    
    [self.tipsTableView bringSubviewToFront:self.view];
    
}


- (void)initSearchBar{
    
    if (frameX == 320.0) {
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(35,20,frameX-100*frameX/320.0,43)];
    }else if (frameX == 375.0){
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(35,20,frameX-100,43)];
    }else if (frameX == 414.0){
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(35,20,frameX-100,43)];
    }
    self.searchBar.backgroundImage = [UIImage imageNamed:@"BEIJING@2x"];
    self.searchBar.barStyle = UISearchBarStyleDefault;
    self.searchBar.showsSearchResultsButton = NO;
    self.searchBar.placeholder = @"不输入即搜索周边车位";
    self.searchBar.delegate = self;
    
    self.searchBar.showsCancelButton = NO;
    
    [self.view addSubview:self.searchBar];
    
    
    //搜索
    if (frameX == 320.0) {
        _button = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.searchBar.frame), 26 ,54,30) type:UIButtonTypeCustom title:@"搜 索" target:self action:@selector(buttonClick:)];
        _button.titleLabel.font = UIFont(14);
    }else if (frameX == 375.0){
        _button = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.searchBar.frame), 26 ,54,30) type:UIButtonTypeCustom title:@"搜 索" target:self action:@selector(buttonClick:)];
        _button.titleLabel.font = UIFont(14);
    }else{
        _button = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(self.searchBar.frame), 26 ,54,30) type:UIButtonTypeCustom title:@"搜 索" target:self action:@selector(buttonClick:)];
        _button.titleLabel.font = UIFont(16);
    }
    _button.backgroundColor = RGB(64, 135, 222);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 5.0;
    [self.view addSubview:self.button];
    

    self.tipsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, frameX, frameY - 44) style:UITableViewStylePlain];
    self.tipsTableView.backgroundColor = [UIColor whiteColor];
    self.tipsTableView.delegate = self;
    
    self.tipsTableView.dataSource = self;
    UIView *view1 = [[UIView alloc]init];
    if (frameX == 320.0) {
        view1.frame = CGRectMake(0, 64, frameX, 85);
    }else{
        view1.frame = CGRectMake(0, 64, frameX, 120);
    }
    self.tipsTableView.tableFooterView = view1;
    
    [self.view addSubview:self.tipsTableView];
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self.array removeAllObjects];
    
    [self.tips removeAllObjects];
    
    [self searchDisplay:searchBar.text];
    
    [self.tipsTableView reloadData];
    
    [self.tableView reloadData];
    
    [self.tableView removeFromSuperview];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger rows = 0;
    
    if ([tableView isEqual:self.tipsTableView]) {
        
        rows =  self.tips.count;
        
    }else if ([tableView isEqual:self.tableView]){
        
        rows = self.array.count;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:_tipsTableView]) {
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
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    
    static NSString *ident = @"ident";
    POITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cells) {
        cells = [[POITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    
    AMapPOI *poi = self.array[indexPath.row];
    
    cells.model = (POIModel *)poi;
    
    return cells;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if ([tableView isEqual:_tipsTableView]) {
            AMapTip *tip = self.tips[indexPath.row];
            NSNumber *laNum = [NSNumber numberWithFloat:tip.location.latitude];
            NSNumber *loNum = [NSNumber numberWithFloat:tip.location.longitude];
            NSString *city = [[tip.district componentsSeparatedByString:@"市"] firstObject];
            NSString *c = [[city componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"省区"]] lastObject];
            NSArray *array = @[tip.name,laNum,loNum,c];
            _block(array);

        }else{
            AMapPOI *poi = self.array[indexPath.row];
            NSNumber *laNum = [NSNumber numberWithFloat:poi.location.latitude];
            NSNumber *loNum = [NSNumber numberWithFloat:poi.location.longitude];
            NSString *address = [[poi.district componentsSeparatedByString:@"市"] firstObject];
            NSArray *citys = [address componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"省区"]];
            NSString *str = [citys lastObject];
            NSArray *array;
            if (str.length != 0 ) {
              array  = @[poi.name,laNum,loNum,str];
            }else{
              array  = @[poi.name,laNum,loNum,@""];
            }
            
            
            _block(array);
            //NSLog(@"%@",poi.district);
        }
        [self.navigationController popViewControllerAnimated:YES];
     
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightRow;
    if ([tableView isEqual:_tableView] || [tableView isEqual:_tipsTableView]) {
        if (frameX == 320.0) {
            heightRow = 40;
        }else {
            heightRow = 45;
        }
    }
    return heightRow;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self.searchBar resignFirstResponder];
    self.searchBar.text = nil;
    
    [self.tips removeAllObjects];
    
    [_array removeAllObjects];
    
    [self.tableView reloadData];
    
    [self.tipsTableView reloadData];
    
}



@end

