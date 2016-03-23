//
//  AboutTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/29.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "AboutTableViewCell.h"
@interface AboutTableViewCell()

@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UIImageView *qqImageView;
@property (nonatomic,strong) UIImageView *emailImageView;
@property (nonatomic,strong) UIImageView *wechatImageView;
@property (nonatomic,strong) UIImageView *sinaImageView;
@property (nonatomic,strong) UIImageView *webImageView;
@property (nonatomic,strong) UILabel *qqlabel;
@property (nonatomic,strong) UILabel *wechatLabel;
@property (nonatomic,strong) UILabel *emailLabel;
@property (nonatomic,strong) UILabel *webLabel;
@property (nonatomic,strong) UILabel *sinaLabel;
@property (nonatomic,strong) UILabel *versionLabel;

@end
@implementation AboutTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGB(247, 247, 247);
        
        //logo
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frameX,180*frameX/320.0)];
        [self.contentView addSubview:view];
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frameX/2-90*frameX/320.0/2,40,90*frameX/320.0,90*frameX/320.0 )];
        _logoImageView.image = [UIImage imageNamed:@"app"];
        [view addSubview:_logoImageView];
        
        //网站
        _webImageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            _webImageView.frame = CGRectMake(40*frameX/320.0 ,CGRectGetMaxY(view.frame)+7*frameY/480.0,15,16);
        }else if(frameX == 375.0){
            _webImageView.frame = CGRectMake(60*frameX/320.0 ,CGRectGetMaxY(view.frame)+9*frameY/480.0,15,16);
        }else{
            _webImageView.frame = CGRectMake(70*frameX/320.0 ,CGRectGetMaxY(view.frame)+9*frameY/480.0,15,16);
        }
        _webImageView.image = [UIImage imageNamed:@"icon_wangzhi"];
        [self.contentView addSubview:_webImageView];
        
        _webLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_webImageView.frame)+5*frameX/320.0,CGRectGetMaxY(view.frame)+5*frameY/480.0,220*frameX/320.0,20*frameY/480.0)];
        _webLabel.textColor = RGB(53,53,53);
        _webLabel.font = UIFont(16);
        [self.contentView addSubview:_webLabel];
        
        //邮箱
        _emailImageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            _emailImageView.frame = CGRectMake(40*frameX/320.0 ,CGRectGetMaxY(_webLabel.frame)+10*frameY/480.0,15*frameX/320.0,10*frameX/320.0);
        }else if (frameX == 375.0){
           _emailImageView.frame = CGRectMake(60*frameX/320.0 ,CGRectGetMaxY(_webLabel.frame)+11*frameY/480.0,15*frameX/320.0,10*frameX/320.0);
        }else{
           _emailImageView.frame = CGRectMake(70*frameX/320.0 ,CGRectGetMaxY(_webLabel.frame)+11*frameY/480.0,15*frameX/320.0,10*frameX/320.0);
        }
        _emailImageView.image = [UIImage imageNamed:@"icon_youxiang"];
        [self.contentView addSubview:_emailImageView];
        
        _emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_emailImageView.frame)+5*frameX/320.0,CGRectGetMaxY(_webLabel.frame)+5*frameY/480,220*frameX/320.0,20*frameY/480)];
        _emailLabel.textColor = RGB(53,53, 53);
        [self.contentView addSubview:_emailLabel];

        
        //qq
        _qqImageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            _qqImageView.frame = CGRectMake(40*frameX/320.0, CGRectGetMaxY(_emailImageView.frame)+15*frameY/480,14*frameX/320.0, 15*frameX/320.0);
        }else if (frameX == 375.0){
            _qqImageView.frame = CGRectMake(60*frameX/320.0, CGRectGetMaxY(_emailImageView.frame)+15*frameY/480,14*frameX/320.0, 15*frameX/320.0);
        }else{
            _qqImageView.frame = CGRectMake(70*frameX/320.0, CGRectGetMaxY(_emailImageView.frame)+15*frameY/480,14*frameX/320.0, 15*frameX/320.0);
        }
        _qqImageView.image = [UIImage imageNamed:@"icon_qq"];
        [self.contentView addSubview:_qqImageView];
        
        _qqlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_emailImageView.frame)+5*frameX/320.0, CGRectGetMaxY(_emailLabel.frame)+5*frameY/480,230*frameX/320.0, 20*frameY/480)];
        _qqlabel.textColor = RGB(53,53,53);
        [self.contentView addSubview:_qqlabel];
        
        
        //weixin
        _wechatImageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            _wechatImageView.frame = CGRectMake(40*frameX/320.0,CGRectGetMaxY(_qqImageView.frame)+12*frameY/480.0,18,13);
        }else if (frameX == 375.0){
            _wechatImageView.frame = CGRectMake(60*frameX/320.0,CGRectGetMaxY(_qqImageView.frame)+12.5*frameY/480.0,18,13);
        }else{
            _wechatImageView.frame = CGRectMake(70*frameX/320.0,CGRectGetMaxY(_qqImageView.frame)+14*frameY/480.0,18,13);
        }
        _wechatImageView.image  = [UIImage imageNamed:@"icon_weixin"];
        [self.contentView addSubview:_wechatImageView];
        
        _wechatLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_emailImageView.frame)+5*frameX/320.0, CGRectGetMaxY(_qqlabel.frame)+5*frameY/480.0,220*frameX/320.0, 20*frameY/480.0)];
        _wechatLabel.textColor = RGB(53,53,53);
        [self.contentView addSubview:_wechatLabel];
        
        _sinaImageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            _sinaImageView.frame = CGRectMake(40*frameX/320.0,CGRectGetMaxY(_wechatImageView.frame)+15*frameY/480.0,18,13);
        }else if (frameX == 375.0){
            _sinaImageView.frame = CGRectMake(60*frameX/320.0,CGRectGetMaxY(_wechatImageView.frame)+15.5*frameY/480.0,18,13);
        }else{
            _sinaImageView.frame = CGRectMake(70*frameX/320.0,CGRectGetMaxY(_wechatImageView.frame)+15.5*frameY/480.0,18,13);
        }
        _sinaImageView.image = [UIImage imageNamed:@"icon_weibo"];
        [self.contentView addSubview:_sinaImageView];
        
        _sinaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_emailImageView.frame)+5*frameX/320.0,CGRectGetMaxY(_wechatLabel.frame)+5*frameY/480.0,220*frameY/480.0,20*frameY/480.0)];
        _sinaLabel.textColor = RGB(53,53,53);
        [self.contentView addSubview:_sinaLabel];
        
        
        _versionLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            _versionLabel.frame = CGRectMake(frameX/2.0-100/2.0, CGRectGetMaxY(_sinaLabel.frame),100,30);
            _versionLabel.font = UIFont(15);
        }else if(frameX == 375.0){
            _versionLabel.frame = CGRectMake(frameX/2.0-100/2.0, CGRectGetMaxY(_sinaLabel.frame),100,30);
            _versionLabel.font = UIFont(15);
        }else{
            _versionLabel.frame = CGRectMake(frameX/2.0-100/2.0, CGRectGetMaxY(_sinaLabel.frame),100,30);
            _versionLabel.font = UIFont(16);
        }
        NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        _versionLabel.text = [NSString stringWithFormat:@"版本号:%@",version];
        _versionLabel.textColor = RGB(53, 53, 53);
       // [self.contentView addSubview:_versionLabel];
        
    }
    
    return self;
}

-(void)setModel:(AboutCompanyModel *)model{
    
    NSArray *array = model.result;
    
    _qqlabel.text =  [NSString stringWithFormat:@"QQ:%@",array[2][@"info"]];
    
    _wechatLabel.text = [NSString stringWithFormat:@"公众号:%@",array[3][@"info"]];
    
    _emailLabel.text = [NSString stringWithFormat:@"邮箱:%@",array[1][@"info"]];
    
    _webLabel.text = [NSString stringWithFormat:@"网址:%@",array[0][@"info"]];
    
    _sinaLabel.text = [NSString stringWithFormat:@"微博:%@",array[4][@"info"]];
    
}

@end
