//
//  HirerTradeTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/26.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "HirerTradeTableViewCell.h"
#import "TimeChange.h"
#import "PAImageView.h"
#import "UIImageView+WebCache.h"
@interface HirerTradeTableViewCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) UILabel *tradeLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *iphoneImageView;
@property (nonatomic,strong) UILabel *methodLabel;
@end

@implementation HirerTradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*frameX/320.0,0,300*frameX/320.0, 165*frameY/568.0)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1.0;
        [self.contentView addSubview:imageView];
        
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,5*frameY/568.0, 25*frameY/568.0, 25*frameY/568.0)];
       [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(42*frameY/568.0,1,210*frameX/320.0,33*frameY/568.0)];
        [self.contentView addSubview:_nameLabel];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame),1,60*frameX/320.0, 33*frameY/568.0)];
        [self.contentView addSubview:_stateLabel];
        
        
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(10*frameX/320.0, CGRectGetMaxY(_nameLabel.frame), 300*frameX/320.0, 1)];
        imageViewLine.image = [UIImage imageNamed:@"bg_xiand"];
        [self.contentView addSubview:imageViewLine];
        
        NSArray *array = @[@"起始       :",@"结束       :",@"订单号   :",@"租用方式:",@"价格       :"];
        UILabel *Label;
        for (int i = 0; i<5; i++) {
            Label  = [[UILabel alloc]initWithFrame:CGRectMake(39*frameX/320.0,CGRectGetMaxY(imageViewLine.frame)+25.3*frameY/568.0*i,65*frameX/320.0, 25.3*frameY/568.0)];
            Label.text = array[i];
            Label.font = UIFont(14);
            [self.contentView addSubview:Label];
        }
        
        _startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(imageViewLine.frame), 155*frameX/320.0, 25.3*frameY/568.0)];
        _startLabel.font = UIFont(14);
        [self.contentView addSubview:_startLabel];
        
        
        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_startLabel.frame),155*frameX/320.0, 25.3*frameY/568.0)];
        _endLabel.font = UIFont(14);
        [self.contentView addSubview:_endLabel];
        
        _iphoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_endLabel.frame)+2,CGRectGetMaxY(imageViewLine.frame)+5*frameY/480.0,35*frameY/480.0,35*frameY/480.0)];
        _iphoneImageView.image = [UIImage imageNamed:@"btn_default_bohao"];
        [self.contentView addSubview:_iphoneImageView];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_endLabel.frame)+10,CGRectGetMaxY(imageViewLine.frame)+4*frameY/480.0,35*frameY/480.0,35*frameY/480.0)];
        view2.backgroundColor = [UIColor cyanColor];
        //[self.contentView addSubview:view2];
        
        
        
        _tradeLabel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_endLabel.frame),210*frameX/320.0,25.3*frameY/568.0)];
        _tradeLabel.font = UIFont(14);
        [self.contentView addSubview:_tradeLabel];
        
        
        _methodLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_tradeLabel.frame),210*frameX/320.0, 25.3*frameY/568.0)];
        _methodLabel.font = UIFont(14);
        [self.contentView addSubview:_methodLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_methodLabel.frame),210*frameX/320.0,25.3*frameY/568.0)];
        _priceLabel.font = UIFont(14);
        [self.contentView addSubview:_priceLabel];

    }
    
    return self;
}



- (void)setModel:(CheckModel *)model{

    NSDictionary *dic;
    
    if (model.user) {
        dic = [StringChangeJson jsonDictionaryWithString:model.user];
        
        if (dic[@"username"]) {
            if ([dic[@"username"] isEqualToString:dic[@"mobilePhoneNumber"]]) {
                NSRange range = {8,3};
                NSString *str = [NSString stringWithFormat:@"%@*****%@",[dic[@"username"] substringToIndex:3],[dic[@"username"] substringWithRange:range]];
                _nameLabel.text = [NSString stringWithFormat:@"%@",str];
            }else{
                _nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"username"]];
            }
            
        }else {
            _nameLabel.text = @"";
        }
        
        if (dic[@"image"][@"url"]) {
            //头像
            _headImageView.layer.masksToBounds = YES;
            if (frameX == 320.0) {
                _headImageView.layer.cornerRadius = 12.0;
            }else if ( frameX == 414.0){
              _headImageView.layer.cornerRadius = 15.0;
            }else if (frameX == 375.0){
              _headImageView.layer.cornerRadius = 13.0;
            }
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"][@"url"]] placeholderImage:[UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"]];
            
        }else {
            _headImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
        }
        
    }

   
    //价格
    _priceLabel.text  = [NSString stringWithFormat:@"¥%@",model.price];
    _priceLabel.textColor = RGB(255, 59, 0);
    
    //开始时间
    NSString *startString = [TimeChange timeChange:model.hire_start[@"iso"]];
    _startLabel.text  = [NSString stringWithFormat:@"%@",startString];
    
    //结束时间
    NSString *endString = [TimeChange timeChange:model.hire_end[@"iso"]];
    _endLabel.text  = [NSString stringWithFormat:@"%@",endString];
    
    //订单号
    _tradeLabel.text = [NSString stringWithFormat:@"%@",model.objectId];
    
    //租用方式
    NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:model.hire_method];
    _methodLabel.text = dictionary[@"method"];
    
    
    NSString *stateStr = [NSString stringWithFormat:@"%@",model.trade_state];
    if ([stateStr isEqualToString:@"0"]) {
        _stateLabel.text = @"未完成";
        _stateLabel.font = UIFont(16);
        _stateLabel.textColor = RGB(255, 59, 0);
    }else if ([stateStr isEqualToString:@"1"]){
        _stateLabel.text = @"完成";
        _stateLabel.font = UIFont(16);
        _stateLabel.textColor = RGB(118, 210, 90);
    }

    
}

@end
