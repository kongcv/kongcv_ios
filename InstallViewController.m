//
//  InstallViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "InstallViewController.h"

#import "FeedBackViewController.h"

#import "AboutCompanyViewController.h"

#import "ChangePhoneNumViewController.h"

#import "AddCarNumViewController.h"

#import "LoginViewController.h"

#import "InstallTableViewCell.h"

@interface InstallViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *titleArray;

@end

@implementation InstallViewController
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-fivePage"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-fivePage"];
    
}


-(NSArray *)titleArray{

    if (_titleArray == nil) {
        
        _titleArray = @[@[@"信息反馈",@"添加车牌号",@"变更手机号",@"关于我们",@"关闭位置信息"], @[@"退出"]];
        
    }
    
    return _titleArray;
    
}

-(UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10+64, frameX, frameY - 64 - 49) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.delegate = self;
    
        _tableView.scrollEnabled = NO;
        
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNav:@"设置" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self.tableView reloadData];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.titleArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *array = self.titleArray[section];
    
    return array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"cell";
    
    InstallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        
        cell = [[InstallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
    }
    
    if (indexPath.section == 0) {
        
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        
        if (indexPath.row != 4) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
        
            UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(frameX - 60,6*frameX/320.0,100,35*frameX/320.0)];
            
            switchView.onTintColor = RGB(247, 156, 0);
            
            if ( [[StringChangeJson getValueForKey:@"isOn"] isEqualToString:@"no"]) {
                
                 switchView.on = NO;
                
            }else{
                
                switchView.on = YES;
            
            }
            
            [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:switchView];
            
        }
        
    }else if (indexPath.section == 1){
    
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        
        cell.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
    
}

- (void)switchAction:(UISwitch *)sw{
    
    StringChangeJson *stringJson = [[StringChangeJson alloc]init];
    
    if (sw.isOn) {
        
        [stringJson saveValue:@"yes" key:@"isLoaction"];
        
        [stringJson saveValue:@"yes" key:@"isOn"];
        
    }else{
        
        UIAlertViewShow(@"已关闭");
        
        [stringJson saveValue:@"no" key:@"isLoaction"];
        
        [stringJson saveValue:@"no" key:@"isOn"];
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 51*frameX/320.0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return 0;
        
    }else{
    
        if (frameX == 320 && frameY == 480) {
             return 20;
        }
        
        return 80;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *controllers = @[@"FeedBackViewController",@"AddCarNumViewController",@"ChangePhoneNumViewController",@"AboutCompanyViewController"];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row != 4) {
            
            Class class = NSClassFromString(controllers[indexPath.row]);
            
            RootViewController *controller = [[class alloc]init];
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }else{
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:kUser_id] && [defaults objectForKey:kSessionToken]) {
            
            [defaults removeObjectForKey:kSessionToken];
            
            [defaults removeObjectForKey:kMobelNum];
            
            [defaults removeObjectForKey:kUser_id];
            
            [defaults removeObjectForKey:@"name"];
            
            [defaults removeObjectForKey:@"url"];
            
            UIAlertViewShow(@"您已退出登录");

            [[NSNotificationCenter defaultCenter]postNotificationName:@"deleateName" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}




@end
