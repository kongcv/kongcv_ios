//
//  GetParkingViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "GetParkingViewController.h"
#import "ParkingTableViewCell.h"
#import "GetParkingModel.h"
#import "PublishViewController.h"
@interface GetParkingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) KongCVHttpRequest *hiddenRequest;
@property (nonatomic,assign) int skip;
@property (nonatomic,strong) NSNumber *number;
@end

@implementation GetParkingViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"TwentyonePage"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TwentyonePage"];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav:@"车位管理" andButton:@"fh" andColor:RGB(247,156,0)];
 
    [self layoutUI];
    
    _skip = 0;
    _number = [NSNumber numberWithInt:_skip];
    
    _dataArray = [NSMutableArray array];
}

//下载数据
- (void)downloadData{
    
    //得到停车位列表
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        
        NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"mobile":[StringChangeJson getValueForKey:kMobelNum],@"skip":_number,@"limit":@10,@"mode":@"community",@"action":@"userid"};
        
        _request = [[KongCVHttpRequest alloc]initWithRequests:kGetParkingUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

            NSArray *array = data[@"result"];
            
            if (array.count != 0) {
                
                  [_dataArray removeAllObjects];
                
                for (NSDictionary *diction in array) {
                    
                    GetParkingModel *model = [GetParkingModel modelWithDictionary:diction];
                    
                    [_dataArray addObject:model];
                    
                }
                
                [self.tableView reloadData];
            }

            [self.tableView.mj_header endRefreshing];
            
            [self.tableView.mj_footer endRefreshing];
          
        }];

    }
}

//布局UI
- (void)layoutUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10+64, frameX, frameY - 10-64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 150)];
    
    self.tableView.tableFooterView = view;
    
    [self.view addSubview:_tableView];
    
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _skip = 0;
        
        _number = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _skip += 10;
        
        _number = [NSNumber numberWithInt:_skip];
        
        [self downloadData];
        
    }];

}


#pragma mark --- <UITableViewDazzaSource,UITableViewDelegate>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ident = @"cell";
    
    ParkingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (cell == nil) {
        
        cell = [[ParkingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
        GetParkingModel *model = _dataArray[indexPath.row];
        
        UIButton *isHideBtn = [UIButton buttonWithFrame:CGRectMake(240*frameX/320.0,2,60,31*frameY/568.0) type:UIButtonTypeCustom title:nil target:self action:@selector(btnClick:)];
        
        isHideBtn.tag = indexPath.row;
        
        isHideBtn.titleLabel.font = UIFont(16);
        
        isHideBtn.selected = NO;
        
        NSString *isHideStr = [NSString stringWithFormat:@"%@",model.park_hide];
        
        isHideBtn.backgroundColor =RGB(255, 147, 0);
        
        isHideBtn.layer.masksToBounds = YES;
        
        isHideBtn.layer.cornerRadius = 5.0;
        
        if ([isHideStr isEqualToString:@"0"]) {
            
            [isHideBtn setTitle:@"屏蔽" forState:UIControlStateNormal];
            
            [isHideBtn setTitle:@"发布" forState:UIControlStateSelected];
            
        }else if ([isHideStr isEqualToString:@"1"]){
            
            [isHideBtn setTitle:@"发布" forState:UIControlStateNormal];
            
            [isHideBtn setTitle:@"屏蔽" forState:UIControlStateSelected];
        }
        
        [cell.contentView addSubview:isHideBtn];
        
    }
    
    GetParkingModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90*frameY/480;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GetParkingModel *model = _dataArray[indexPath.row];
    
    PublishViewController *changeInfoController = [[PublishViewController alloc]init];
    
    changeInfoController.string = @"change";
    
    changeInfoController.model = model;
    
    changeInfoController.objectId = model.objectId;
    
   [self.navigationController pushViewController:changeInfoController animated:YES];

}


//屏蔽车位
- (void)btnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    GetParkingModel *model = _dataArray[btn.tag];
    
    NSNumber *number;
    
    NSString *string = [NSString stringWithFormat:@"%@",model.park_hide];
    
    if ([string isEqualToString:@"1"]) {
        
        number = @0;
    }else if ([string isEqualToString:@"0"]){
        
        number = @1;
    }
    NSDictionary *dic = @{@"park_id":model.objectId,@"mode":@"community",@"hide":number};
    
    _hiddenRequest = [[KongCVHttpRequest alloc]initWithRequests:kHiddenParkUrl sessionToken:nil dictionary:dic andBlock:^(NSDictionary *data) {
        
        NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
        
        if ([dictionary[@"msg"] isEqualToString:@"成功"]) {
            
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
            
        }
        
    }];
    
}
@end
