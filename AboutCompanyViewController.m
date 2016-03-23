//
//  AboutCompanyViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "AboutCompanyViewController.h"
#import "AboutTableViewCell.h"
#import "AboutCompanyModel.h"
@interface AboutCompanyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) KongCVHttpRequest *request;
@end

@implementation AboutCompanyViewController
- (void)viewWillAppear:(BOOL)animated{
    UIImage *image = [[UIImage alloc]init];
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"640h"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-SixPage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-SixPage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav:@"关于我们" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self initTableView];
    
    [self downloadData];
    
    _dataArray = [NSMutableArray array];
}


//下载数据
- (void)downloadData{

    _request = [[KongCVHttpRequest alloc]initWithRequests:kaboutCompany sessionToken:nil dictionary:nil andBlock:^(NSDictionary *data) {
        
        [self.dataArray removeAllObjects];
        
        AboutCompanyModel *model = [AboutCompanyModel modelWithDic:data];
            
        [_dataArray addObject:model];
        
        [self.tableView reloadData];
        
    }];
    
}


//初始化tableView
-(void)initTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, frameX, frameY-64-44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ident = @"cell";
    AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[AboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    AboutCompanyModel *model = _dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return frameY;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
