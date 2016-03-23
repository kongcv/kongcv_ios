//
//  FeedBackViewController.m
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) KongCVHttpRequest *request;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *label;
@end

@implementation FeedBackViewController
- (void)viewWillAppear:(BOOL)animated{
    UIImage *image = [[UIImage alloc]init];
    UIImage *tabBarImage = [image scaleFromImage:[UIImage imageNamed:@"640h"] toSize:CGSizeMake(self.view.frame.size.width,64)];
    [self.navigationController.navigationBar setBackgroundImage:tabBarImage forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"Twenty-SevenPage"];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"Twenty-SevenPage"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(247,247,247);

    [self initNav:@"信息反馈" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(frameX - 50,20,40,40);
    [btn addTarget:self action:@selector(sendItem) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font = UIFont(19);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    //初始化UItextView
    [self initTextView];

}

- (void)initTextView{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, frameX, frameY - 64-49)];
    if (frameX != 414.0) {
        _textView.font = UIFont(15);
    }else{
        _textView.font = UIFont(16);
    }
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0,64,200, 30)];
    _label.text = @"请输入您要反馈的信息";
    _label.textColor = RGB(210, 210, 210);
    [self.view addSubview:_label];
}


- (void)sendItem{
    
    if (_textView.text.length != 0) {
        NSDictionary *dictionary = @ {@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:kUser_id],@"feedback":_textView.text};
        _request = [[KongCVHttpRequest alloc]initWithRequests:kFeedBackUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
            if ([dic[@"msg"] isEqualToString:@"成功"]) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"发送成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入内容" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (![text isEqualToString:@""]) {
        _label.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _label.hidden = NO;
    }
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    _label.hidden = YES;
}

@end
