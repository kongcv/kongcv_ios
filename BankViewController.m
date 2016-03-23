//
//  BankViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "BankViewController.h"
#import "StringChangeJson.h"
#import "BankInfoViewController.h"
#import "UIImageView+WebCache.h"
@interface BankViewController ()
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,strong) NSDictionary *dic;
@end

@implementation BankViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"SeventeenPage"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick endLogPageView:@"SeventeenPage"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(254, 254, 254);

    [self initNav:@"银行卡" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(frameX - 50,20,40,40);
    [btn addTarget:self action:@selector(addBankCard) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = UIFont(19);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadBankInfo) name:@"reloadBank" object:nil];
    
    [self downloadData];
}

- (void)reloadBankInfo{
    [self downloadData];
}

- (void)downloadData{
    if ([StringChangeJson getValueForKey:kUser_id]) {
        NSDictionary *dic = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"skip":@0,@"limit":@10};
        _request = [[KongCVHttpRequest alloc]initWithRequests:kGetPurse sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            NSDictionary *dic  = [data[@"result"] firstObject ];
            
            if (dic) {
                _array = dic[@"bank_card"];
                _dic = dic;
            }
            [self performSelectorOnMainThread:@selector(layoutUI) withObject:nil waitUntilDone:YES];
        }];
    }
}

- (void)layoutUI{
    if (_array.count != 0) {

        NSDictionary *dic = [_array firstObject];
        UIImageView *backImageView =[[UIImageView alloc]init];
        backImageView.frame = CGRectMake(0,11+64, frameX, 100*frameY/568.0);
        backImageView.image = [UIImage imageNamed:@"bg"];
        backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBankCard)];
        [backImageView addGestureRecognizer:tap];
        [self.view addSubview:backImageView];
        
        //银行图标
        UIImageView *logoImageView;
        if (dic[@"bank_icon"]) {
            logoImageView = [[UIImageView alloc]init];
            logoImageView.frame = CGRectMake(20, 18+64, 40*frameY/568.0, 40*frameY/568.0);
            [logoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"bank_icon"]]];
            [self.view addSubview:logoImageView];
        }

        //银行名称
        if (dic[@"bank"]) {
            UILabel *bankName = [[UILabel alloc]init];
            bankName.frame = CGRectMake(CGRectGetMaxX(logoImageView.frame)+18, 20+64, 180,35);
            bankName.textColor = [UIColor whiteColor];
            bankName.text = [NSString stringWithFormat:@"%@",dic[@"bank"]];
            bankName.font = UIFont(26);
            bankName.font = [UIFont systemFontOfSize:28];
            [self.view addSubview:bankName];
        }

        //银行卡号
        if (dic[@"card"]) {
            UILabel *bankCard = [[UILabel alloc]init];
            bankCard.frame = CGRectMake(CGRectGetMaxX(logoImageView.frame)+18, 60*frameY/568.0+64, 230, 30);
            bankCard.textColor = [UIColor whiteColor];
            NSString *string = dic[@"card"];

            bankCard.text = [NSString stringWithFormat:@"*** **** **** %@",[string substringFromIndex:string.length-4]];
            bankCard.font = UIFont(18);
            [self.view addSubview:bankCard];
        }
    }
}

- (void)backItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加银行卡
- (void)addBankCard{
    BankInfoViewController *bankInfoController = [[BankInfoViewController alloc]init];
    if (_array) {
        bankInfoController.string = @"yes";
        bankInfoController.bankDictionary = _dic;
    }
    [self.navigationController pushViewController:bankInfoController animated:YES];
}



@end
