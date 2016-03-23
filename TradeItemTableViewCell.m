//
//  TradeItemTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/21.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "TradeItemTableViewCell.h"
#import "TimeChange.h"
@interface TradeItemTableViewCell()
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) UILabel *tradeLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UILabel *methodLabel;

@property (nonatomic,strong) UILabel *pLabel;
@end
@implementation TradeItemTableViewCell

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
        
        
        UIImageView *navImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18,7.5*frameY/568.0, 15*frameY/568.0, 20*frameY/568.0)];
        navImageView.image = [UIImage imageNamed:@"dwf@2x"];
        [self.contentView addSubview:navImageView];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(39*frameX/320.0,1,210*frameX/320.0,33*frameY/568.0)];
        [self.contentView addSubview:_addressLabel];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressLabel.frame),1,60*frameX/320.0, 33*frameY/568.0)];
        [self.contentView addSubview:_stateLabel];
        
        
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(10*frameX/320.0, CGRectGetMaxY(_addressLabel.frame), 300*frameX/320.0, 1)];
        imageViewLine.image = [UIImage imageNamed:@"bg_xiand"];
        [self.contentView addSubview:imageViewLine];
        
        NSArray *array = @[@"起始       :",@"结束       :",@"订单号   :",@"租用方式:"];
        UILabel *Label;
        
        for (int i = 0; i<array.count; i++) {
            Label  = [[UILabel alloc]initWithFrame:CGRectMake(39*frameX/320.0,CGRectGetMaxY(imageViewLine.frame)+25.3*frameY/568.0*i,65*frameX/320.0, 25.3*frameY/568.0)];
            Label.text = array[i];
            Label.font = UIFont(14);
            [self.contentView addSubview:Label];
        }
        
        self.pLabel = [UILabel labelWithFrame:CGRectMake(39*frameX/320.0,CGRectGetMaxY(Label.frame), 65*frameX/320.0, 25.3*frameY/568.0) text:nil Color:nil Font:UIFont(14)];
        
        [self.contentView addSubview:self.pLabel];
        
        
        _startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(imageViewLine.frame), 210*frameX/320.0, 25.3*frameY/568.0)];
        _startLabel.font = UIFont(14);
        [self.contentView addSubview:_startLabel];
        
        
        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_startLabel.frame),210*frameX/320.0, 25.3*frameY/568.0)];
        _endLabel.font = UIFont(14);
        [self.contentView addSubview:_endLabel];
        
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


-(void)setModel:(CheckModel *)model{

    _model = model;
    

    if (model.park_community) {
       NSDictionary *dictionary  = [StringChangeJson jsonDictionaryWithString:model.park_community];
       NSArray *arr = [dictionary[@"address"] componentsSeparatedByString:@"&"];
       _addressLabel.text = [NSString stringWithFormat:@"%@",[arr firstObject]];
    }else {
       _addressLabel.text = @"";
    }

    if (model.park_curb){
        NSDictionary *dictionary  = [StringChangeJson jsonDictionaryWithString:model.park_curb];
        NSArray *arr = [dictionary[@"address"] componentsSeparatedByString:@"&"];
        _addressLabel.text = [NSString stringWithFormat:@"%@",[arr firstObject]];
    }

    
    //价格
    _priceLabel.text  = [NSString stringWithFormat:@"¥%@",model.money];
    _priceLabel.textColor = RGB(255, 59, 0);
    
    //开始时间
    if (model.hire_start[@"iso"]) {
        NSString *startString = [[[TimeChange timeChange:model.hire_start[@"iso"]] componentsSeparatedByString:@" "] firstObject];
        _startLabel.text  = [NSString stringWithFormat:@"%@",startString];
    }

    //结束时间
    if (model.hire_end[@"iso"]) {
        NSString *endString = [[[TimeChange timeChange:model.hire_end[@"iso"]] componentsSeparatedByString:@" "] firstObject];
        _endLabel.text  = [NSString stringWithFormat:@"%@",endString];
    }

    
    //订单号
    _tradeLabel.text = model.objectId;
    
    NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:model.hire_method];
    
    _methodLabel.text = dic[@"method"];
    
     NSString *handsel_state  = [NSString stringWithFormat:@"%@",model.handsel_state];
    
    NSString *trade_state = [NSString stringWithFormat:@"%@",model.trade_state];
    
    if ([trade_state isEqualToString:@"0"]) {
        
        if ([handsel_state isEqualToString:@"1"]) {
            
            _stateLabel.text = @"已支付定金";
            
        }else{
        
            _stateLabel.text = @"未完成";
            
        }
        
        _stateLabel.font = UIFont(16);
        
        _stateLabel.textColor = RGB(255, 59, 0);
        
    }else if ([trade_state isEqualToString:@"1"]){
        
        _stateLabel.text = @"完成";
        
        _stateLabel.font = UIFont(16);
        
        _stateLabel.textColor = RGB(118, 210, 90);
        
    }
    
    //总钱数价格
    NSString *price = [NSString stringWithFormat:@"%@",model.price];
    //定金数
    NSString *money = [NSString stringWithFormat:@"%@",model.money];
    
    //trade_state = 0  handsel-state = 1//支付定金
    //trade_state = 0  handsel-state = 0//没有支付
    
    //trade_state = 1 //开始  定金 差额都支付玩
    
    //handsel-state =0 ;//没有支付定金
    //handsel-state = 1; //支付定金

    
    NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:model.hire_method];
    
    NSString *fieldStr = dictionary[@"field"];
    
    if ([fieldStr isEqualToString:@"hour_meter"]) {
        
        //这笔单子全部完成
        if ([trade_state isEqualToString:@"1"]) {
            
            self.pLabel.text = @"价格    :";
            
            self.priceLabel.text = [NSString stringWithFormat:@"%@元",price];
            
        }else if([trade_state isEqualToString:@"0"]){
        
            //支付定金
            if ([handsel_state isEqualToString:@"1"]) {
                
                self.pLabel.text = @"定金    :";
                
                self.priceLabel.text = [NSString stringWithFormat:@"%@元",money];
                
            }else{
            
                self.pLabel.text = @"定金    :";
                
                self.priceLabel.text = [NSString stringWithFormat:@"%@元",money];
                
            }
            
        }
        
    }else{
    
        self.pLabel.text = @"价格    :";
        
        self.priceLabel.text = [NSString stringWithFormat:@"%@元",price];
        
    }

}
@end
