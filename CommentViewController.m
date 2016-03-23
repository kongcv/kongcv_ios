//
//  CommentViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/12/1.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CommentViewController.h"

#import "RatingBar.h"

#define kGap4s 11.9

#define kGap6   14.3

#define kGap6p  15.4

@interface CommentViewController ()<UITextViewDelegate>

//星星
@property (nonatomic,strong) RatingBar *bar;
//评论内容
@property (nonatomic,strong) UITextView *commentText;
//星星个数
@property (nonatomic,assign) NSInteger starNum;
//网络请求
@property (nonatomic,strong) KongCVHttpRequest *request;
//placeHolder
@property (nonatomic,strong) UILabel *label;

@end

@implementation CommentViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"SevenPage"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"SevenPage"];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(247,247, 247);
   
    //布局UI
    [self layOut];
    
}

- (void)layOut{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frameX, 64)];
    view.backgroundColor = RGB(247, 156, 0);
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frameX/2.0 - 22, 25, 60, 30)];
    label.text = @"评论";
    label.font = UIFont(20);
    label.textColor = RGB(254, 254, 254);
    [self.view addSubview:label];
    
    UIView *cView = [[UIView alloc]init];
    UILabel *cLabel = [[UILabel alloc]init];
    _commentText = [[UITextView alloc]init];
    _commentText.delegate = self;
    _commentText.hidden = NO;
    _commentText.font = UIFont(16);
    _label = [[UILabel alloc]init];
    if (frameX == 320.0) {
        cView.frame = CGRectMake(0, CGRectGetMaxY(view.frame)+kGap4s, frameX, 44.4);
        cLabel.frame = CGRectMake(8.9, 10.7,85 ,23);
        cLabel.font = UIFont(16);
        _bar = [[RatingBar alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cLabel.frame)-26,13.7,180,17)];
        _commentText.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap4s, frameX, 100);
        _label.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap4s, frameX, 30);
        _label.enabled = NO;
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"请写下您的评论内容";
        _label.font = UIFont(15);
        
    }else if (frameX == 375.0){
        cView.frame = CGRectMake(0, CGRectGetMaxY(view.frame)+kGap6, frameX, 53.6);
        cLabel.frame = CGRectMake(10.7,12.4,105,26.8);
        cLabel.font = UIFont(21);
        _bar = [[RatingBar alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cLabel.frame)-15,15.4,180,22.8)];
        _commentText.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap6, frameX, 100);
        _label.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap6, frameX, 30);
        _label.enabled = NO;
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"请写下您的评论内容";
        _label.font = UIFont(15);
    }else if (frameX == 414.0){
        cView.frame = CGRectMake(0, CGRectGetMaxY(view.frame)+kGap6p, frameX, 57.7);
        cLabel.frame = CGRectMake(11.5, 13.5,115,30.7);
        cLabel.font = UIFont(22);
        _bar = [[RatingBar alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cLabel.frame)-20,16.5,180,24.7)];
        _commentText.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap6p, frameX, 100);
        _label.frame = CGRectMake(0, CGRectGetMaxY(cView.frame)+kGap6p, frameX, 30);
        _label.enabled = NO;
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"请写下您的评论内容";
    }
    cView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cView];
    cLabel.text = @"总体评价";
    cLabel.font = UIFont(16);
    [cView addSubview:_bar];
    [cView addSubview:cLabel];
    _commentText.font = UIFont(15);
    [self.view addSubview:_commentText];
    
    _bar.block = ^(NSInteger inter){
        _starNum  = inter;
    };
    
    //提交
    UIButton *button = [UIButton buttonWithFrame:CGRectMake(0, frameY -CGRectGetMaxY(_commentText.frame), frameX, 40) type:UIButtonTypeCustom title:@"提       交" target:self action:@selector(tijiao:)];
    button.backgroundColor = RGB(254, 156, 0);
    [button setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *lbutton = [UIButton buttonWithFrame:CGRectMake(0,5,85,70) type:UIButtonTypeCustom title:nil target:self action:@selector(leftBack)];
    [lbutton setBackgroundImage:[UIImage imageNamed:@"fh"] forState:UIControlStateNormal];
    [self.view addSubview:lbutton];
    [self.view addSubview:_label];

}


- (void)leftBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)tijiao:(UIButton *)button{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        if ( _commentText.text.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入您的评论!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            NSNumber *starNm = [NSNumber numberWithInteger:_starNum];
            NSDictionary *dictionary = @{@"user_id":[StringChangeJson getValueForKey:kUser_id],@"park_id":self.parkId,@"grade":starNm,@"comment":_commentText.text,@"mode":self.mode};
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kPubCommentUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
                
                NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
               
                if ([dic[@"msg"] isEqualToString:@"成功"]) {

                    [[NSNotificationCenter defaultCenter]postNotificationName:@"comment" object:nil];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
    
            }];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请注册" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_commentText resignFirstResponder];

}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if (![text isEqualToString:@""]) {
        _label.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _label.hidden = NO;
    }
    
    if (textView.contentSize.height > 100) {
        textView.text = [textView.text substringToIndex:[textView.text  length] - 1];
        return NO;
    }
    
    return YES;
}

#pragma mark ---- <UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView{
    
    _label.hidden = YES;
    
    if (textView.text.length >= 120) {
        
        textView.text = [textView.text substringToIndex:80];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _label.hidden = NO;
    }
}

@end
