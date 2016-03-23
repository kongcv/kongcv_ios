//
//  PaymentViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/3.
//  Copyright © 2015年 空车位. All rights reserved.
//

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "PaymentViewController.h"
#import "Pingpp.h"
#import "CouponViewController.h"
#import "AFNetworking.h"
#import "ZHXDataCache.h"

#define kUrlScheme      @"kongchewei"   // 这个是你定义的 URL Scheme，支付宝、微信支付和测试模式需要。
@interface PaymentViewController ()
@property (nonatomic,copy)   NSString *channel;
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) KongCVHttpRequest *insertRequest;
@property (nonatomic,strong) KongCVHttpRequest *pingRequset;
@property (nonatomic,strong) KongCVHttpRequest *versionRequest;
@property (nonatomic,copy)   NSString *charge;

@property (nonatomic,copy)  NSString *license_plate;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)UIImageView *headImageview;
@end
///Users/kongchewei/Desktop/资料/pingpp-ios-master/VERSION
@implementation PaymentViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TenPage"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TenPage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutUI];
    
    if ([StringChangeJson getValueForKey:@"license_plate"]) {
        self.license_plate = [StringChangeJson getValueForKey:@"license_plate"];
    }else{
        self.license_plate = @"";
    }

    [self downLoad];
    
}

-(void)downLoad{
    if ([StringChangeJson getValueForKey:kUser_id] && [StringChangeJson getValueForKey:kMobelNum]) {
        NSDictionary *dic = @{@"mobilePhoneNumber":[StringChangeJson getValueForKey:kMobelNum],@"user_id":[StringChangeJson getValueForKey:kUser_id]};
        _versionRequest = [[KongCVHttpRequest alloc]initWithRequests:kGetUserInfoUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            _dic = data[@"result"];
            [self performSelectorOnMainThread:@selector(refreshImage) withObject:nil waitUntilDone:YES];
        }];
    }
}

- (void)refreshImage{
    if ([StringChangeJson getValueForKey:@"image"]) {
        NSURL *url = [NSURL URLWithString:[StringChangeJson getValueForKey:@"image"]];
        _headImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }else if (_dic) {
        NSURL *url = [NSURL URLWithString:_dic[@"image"][@"url"]];
        if (url) {
            _headImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        }else{
            _headImageview.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
        }
    }else{
        _headImageview.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
    }
}

//布局UI
- (void)layoutUI{
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX,64)];
    view.backgroundColor = RGB(255, 147, 0);
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2.0 - 22, 25, 60, 30)];
    label.text = @"";
    label.font = UIFont(20);
    label.textColor = RGB(254, 254, 254);
    [self.view addSubview:label];
    
    
    //背景
    UIView *viewT = [[UIView alloc]init];
    
    //头像
    UIImageView *imageview = [[UIImageView alloc]init];
    _headImageview = imageview;
    imageview.layer.masksToBounds = YES;
    UIView *Iview = [[UIView alloc]init];
    
    //支付方式
    UILabel *tradeMethod = [[UILabel alloc]init];
    
    //支付宝
    UIButton *alipay = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    //微信支付
    UIButton *wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    

    
    if (frameX == 320.0) {
        viewT.frame = CGRectMake(0, CGRectGetMaxY(view.frame), frameX, 184);
        imageview.frame = CGRectMake(121.2, CGRectGetMaxY(view.frame)+29.6, 77.6, 77.6);
        
        imageview.layer.cornerRadius = 39.0;
        Iview.frame = CGRectMake(119.1,CGRectGetMaxY(view.frame)+29.6,79.6,79.6);
        Iview.layer.cornerRadius = 39.0;
        tradeMethod.frame =  CGRectMake(80, CGRectGetMaxY(viewT.frame)+44.2,frameX - 80*2,40);
        alipay.frame = CGRectMake(59.6, CGRectGetMaxY(tradeMethod.frame)+40, 64, 64);
        wxButton.frame = CGRectMake(CGRectGetMaxX(alipay.frame)+68.7,CGRectGetMaxY(tradeMethod.frame)+40,64, 64);
    }else if (frameX == 375.0){
        viewT.frame = CGRectMake(0, CGRectGetMaxY(view.frame), frameX, 221.78);
        
        imageview.frame = CGRectMake(145.7, CGRectGetMaxY(view.frame)+35.7, 83.6, 83.6);
        imageview.layer.cornerRadius = 44.0;
        
        Iview.frame = CGRectMake(143.7,CGRectGetMaxY(view.frame)+35.7,85.6,85.6);
        Iview.layer.cornerRadius = 44.0;
        tradeMethod.frame =  CGRectMake(80, CGRectGetMaxY(viewT.frame)+44.2,frameX - 80*2,40);
        
        alipay.frame = CGRectMake(66, CGRectGetMaxY(tradeMethod.frame)+40,77.1,77.1);
        
        wxButton.frame = CGRectMake(CGRectGetMaxX(alipay.frame)+82.9,CGRectGetMaxY(tradeMethod.frame)+40,77.1, 77.1);
    }else if (frameX == 414.0){
        
        viewT.frame = CGRectMake(0, CGRectGetMaxY(view.frame),frameX, 238.85);
        
        imageview.frame = CGRectMake(156.9, CGRectGetMaxY(view.frame)+38.5,100.2, 100.2);
        
        imageview.layer.cornerRadius = 50.0;
        
        Iview.frame = CGRectMake(154.9,CGRectGetMaxY(view.frame)+38.5,102.2,102.2);
        
        Iview.layer.cornerRadius = 50.0;
        
        tradeMethod.frame =  CGRectMake(80, CGRectGetMaxY(viewT.frame)+44.2,frameX - 80*2,40);
        
        tradeMethod.font = UIFont(20);
        
        alipay.frame = CGRectMake(75, CGRectGetMaxY(tradeMethod.frame)+40,83.1,83.1);
        
        wxButton.frame = CGRectMake(CGRectGetMaxX(alipay.frame)+89.2,CGRectGetMaxY(tradeMethod.frame)+40,83.1,83.1);
        
    }

    
    Iview.layer.masksToBounds = YES;
    Iview.layer.borderWidth = 2.0;
    Iview.layer.borderColor = [UIColor redColor].CGColor;
    
    viewT.backgroundColor = RGB(255,147, 0);
    
    tradeMethod.text = @"请 选 择 支 付 方 式";
    
    tradeMethod.textAlignment = NSTextAlignmentCenter;
    
    [alipay setBackgroundImage:[UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
    
    [alipay addTarget:self action:@selector(alipayTrade:) forControlEvents:UIControlEventTouchUpInside];
    
    [wxButton setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    
    [wxButton addTarget:self action:@selector(wxButtonTrade:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:viewT];
    [self.view addSubview:imageview];
    [self.view addSubview:Iview];
    [self.view addSubview:tradeMethod];
    
    if ([self.mode isEqualToString:@"curb"]) {
        if (![self.priceNum isEqualToNumber:@0 ]) {
            [self.view addSubview:alipay];
            [self.view addSubview:wxButton];
        }
    }else if ([self.mode isEqualToString:@"community"]){
        [self.view addSubview:alipay];
        [self.view addSubview:wxButton];
    }

    //当是计时差额付款,支付方式已经确定
    if (![self.priceNum isEqual:@0]) {
        
        if ([self.pay_tool isEqualToString:@"alipay"]) {
            
            [wxButton setBackgroundImage:[UIImage imageNamed:@"weixinh"] forState:UIControlStateNormal];
            
        }else if ([self.pay_tool isEqualToString:@"wx"]){
            
            [alipay setBackgroundImage:[UIImage imageNamed:@"zhifubaoh"] forState:UIControlStateNormal];
            
        }
       
    }

    //支付金额
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(imageview.frame)+20,100,30)];
    priceLabel.text = [NSString stringWithFormat:@"¥ %@",self.priceNum];
    priceLabel.font = UIFont(28);
    priceLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:priceLabel];
    
    UILabel *labels = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+130,CGRectGetMaxY(imageview.frame)+30,40,20)];
    
    if (![self.hire_field isEqualToString:@"hour_meter"]) {
        
        labels.text = @"全额";
        
    }else{
        
        if ([self.hire_field isEqualToString:@"hour_meter"]) {
            
            if (self.pay_tool) {
                
                labels.text = @"差额";
                
            }else{
                
                labels.text = @"定金";
                
            }
        }
    }
    
    [self.view addSubview:labels];
    
    //优惠卷
//    if ([self.mode isEqualToString:@"curb"]) {
//        UIButton *btn = [UIButton buttonWithFrame:CGRectMake(35,CGRectGetMaxY(viewT.frame)+10,200,40) type:UIButtonTypeCustom title:nil target:self action:@selector(btnCl)];
//        btn.backgroundColor = [UIColor cyanColor];
//        [btn setTitle:@"优惠卷" forState:UIControlStateNormal];
//        [self.view addSubview:btn];
//    }
    
    //返回箭头
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(15,18,75,45) type:UIButtonTypeCustom title:nil target:self action:@selector(backBtn:)];
    [button setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    [self.view addSubview:button];

}

////优惠卷
//- (void)btnCl{
//    self.navigationController.navigationBarHidden = NO;
//    CouponViewController *couponController = [[CouponViewController alloc]init];
//    [self.navigationController pushViewController:couponController animated:YES];
//}

- (void)backBtn:(UIButton *)btn{
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//支付宝
- (void)alipayTrade:(UIButton *)button{
    self.channel = @"alipay";
    if (self.trade_id) {
        [self getTradeBillData:self.trade_id payChannel:self.channel];
    }else{
        [self getTradeId:self.channel];
    }
}

//微信支付
- (void)wxButtonTrade:(UIButton *)btn{
    self.channel = @"wx";
    if (self.trade_id) {
        [self getTradeBillData:self.trade_id payChannel:self.channel];
    }else{
        [self getTradeId:self.channel];
    }
}

//获取trade_id
- (void)getTradeId:(NSString *)channel{

    NSDictionary *diction;
    if ([self.mode isEqualToString:@"community"]) {
        if (self.license_plate.length == 0) {
            diction = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"hirer_id":self.hirer_id,@"park_id":self.park_id,@"hire_start":self.start_time,@"hire_end":self.end_time,@"hire_method_id":self.hire_methold_id,@"price":self.priceNum,@"mode":self.mode,@"extra_flag":self.extra_flag,@"unit_price":self.unit_price,@"property_id":self.property_id,@"curb_rate":@"",@"license_plate":@""};
        }else{
            diction = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"hirer_id":self.hirer_id,@"park_id":self.park_id,@"hire_start":self.start_time,@"hire_end":self.end_time,@"hire_method_id":self.hire_methold_id,@"price":self.priceNum,@"mode":self.mode,@"extra_flag":self.extra_flag,@"unit_price":self.unit_price,@"property_id":self.property_id,@"curb_rate":@"",@"license_plate":self.license_plate};
        }

    }else{
        if (self.license_plate.length != 0) {
            diction = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"hirer_id":self.hirer_id,@"park_id":self.park_id,@"hire_start":self.start_time,@"hire_end":self.end_time,@"hire_method_id":self.hire_methold_id,@"price":self.priceNum,@"mode":self.mode,@"extra_flag":self.extra_flag,@"unit_price":self.unit_price,@"property_id":@"",@"curb_rate":[NSNumber numberWithFloat:[self.curb_rate floatValue]],@"license_plate":self.license_plate};
        }else{
            diction = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"hirer_id":self.hirer_id,@"park_id":self.park_id,@"hire_start":self.start_time,@"hire_end":self.end_time,@"hire_method_id":self.hire_methold_id,@"price":self.priceNum,@"mode":self.mode,@"extra_flag":self.extra_flag,@"unit_price":self.unit_price,@"property_id":@"",@"curb_rate":[NSNumber numberWithFloat:[self.curb_rate floatValue]],@"license_plate":self.license_plate};
        }

    }
    
    //NSLog(@"diction --- %@",diction);
    
    //获取交易Id
    _insertRequest = [[KongCVHttpRequest alloc]initWithRequests:kTradeDataUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:diction andBlock:^(NSDictionary *data) {
        
        NSString *string = data[@"result"];
        
        NSLog(@"%@",string);
        
        NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:string];
        //保存交易ID
        if (dic[@"trade_id"]) {
            [self getTradeBillData:dic[@"trade_id"]payChannel:channel];
        }else if(dic[@"error"]){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:dic[@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    
}

//插入交易数据
- (void)getTradeBillData:(NSString *)string payChannel:(NSString *)channel{
    
    NSDictionary *dictonary = @{@"trade_id":string};
    
    _request = [[KongCVHttpRequest alloc]initWithRequests:kInsertZhiFuUrl sessionToken:nil dictionary:dictonary andBlock:^(NSDictionary *data) {
        
        NSString *string = data[@"result"];
        
        NSData *datas = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
      
        int amount = [self.priceStr intValue];
        NSNumber *am = [NSNumber numberWithInt:amount];
        NSString *pay_type = @"";
        if (![self.hire_field isEqualToString:@"hour_meter"]) {
            pay_type = @"money";
        }else{
            if ([self.hire_field isEqualToString:@"hour_meter"]) {
                
                if (self.pay_tool) {
                    pay_type = @"balance";
                }else{
                    pay_type = @"handsel";
                }
            }
        }
        
        NSString *str = [NSString stringWithFormat:@"{'cp':%@,'pt':'%@','md':'%@','tk':'%@','tp':'%@','mb':'%@'}",am,pay_type,self.mode,self.device_token,self.device_type,self.mobile];
        
        NSDictionary *payDic = @{@"order_no":dic[@"bill_id"],
                                 @"channel":channel,
                                 @"amount":self.priceNum,
                                 @"open_id":@"654321",
                                 @"subject":@"空车位订单",
                                 @"pay_info":str
                                 };
        
        //NSLog(@"paydic ----- %@",payDic);
    
        [self payTrade:payDic];
        
    }];
}

//ping++支付
- (void)payTrade:(NSDictionary *)dic{
    
    NSURL* url = [NSURL URLWithString:kzhiFuUrl1];
    
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    [postRequest setHTTPMethod:@"POST"];
    
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [postRequest setValue:@"80b5b4e822f60d0254d885a7c20f7a87" forHTTPHeaderField:@"x-kongcv-key-signatures"];
    
    //PaymentViewController * __weak weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        
        if (httpResponse.statusCode != 200) {
            return;
        }
        if (connectionError != nil) {
            NSLog(@"error = %@", connectionError);
            return;
        }
        NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //NSLog(@"charge = %@", charge);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [Pingpp createPayment:charge appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                
                //NSLog(@"completion block: %@", result);
                
                if ([result isEqualToString:@"success"]) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
                if (error == nil) {
                    NSLog(@"PingppError is nil");
                } else {
                    
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                }
                //[weakSelf showAlertMessage:result];
            }];
            
//            [Pingpp createPayment:charge viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
//
//            }];
        });
    }];
    
    
}
@end
