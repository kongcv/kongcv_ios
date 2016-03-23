//
//  CheckTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CheckTableViewCell.h"
#import "TimeChange.h"
@interface CheckTableViewCell()

@property (nonatomic,strong) UILabel *hourLabel;
@property (nonatomic,strong) UILabel *yearLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end
@implementation CheckTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, frameX, 1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView];
        
        _hourLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*frameX/320.0, 0,frameX/2-40*frameX/320.0,27.5*frameY/480.0)];
        [self.contentView addSubview:_hourLabel];
        
        _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*frameX/320.0, CGRectGetMaxY(_hourLabel.frame), frameX/2-40*frameX/320.0,27.5*frameY/480.0)];
        [self.contentView addSubview:_yearLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_hourLabel.frame),0 , frameX/2+50*frameX/320.0, 27.5*frameY/480.0)];
        [self.contentView addSubview:_priceLabel];
    
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_yearLabel.frame), CGRectGetMaxY(_priceLabel.frame),frameX/2+50*frameX/320.0,27.5*frameY/480.0)];
        //_addressLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_addressLabel];
        
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_addressLabel.frame), frameX, 1)];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView1];
        
    }
    return self;
}

- (void)setModel:(CheckModel *)model{

    //价格
    _priceLabel.text = [NSString stringWithFormat:@"%@  元",model.price];
    _priceLabel.textColor = RGB(255, 156, 0);
    
    //地址
    if (model.park_community) {
        NSDictionary *communityDic = [StringChangeJson jsonDictionaryWithString:model.park_community];
        NSArray *addArr = [communityDic[@"address"] componentsSeparatedByString:@"&" ];
        _addressLabel.text = [NSString stringWithFormat:@"%@",[addArr firstObject]];
    }else if(!model.park_community){
        _addressLabel.text = @"";
    }
    
    if(model.park_curb){
        NSDictionary *curbDic = [StringChangeJson jsonDictionaryWithString:model.park_curb];
        NSArray *addArr = [curbDic[@"address"] componentsSeparatedByString:@"&" ];
        _addressLabel.text = [NSString stringWithFormat:@"%@",[addArr firstObject]];
    }
    
    NSString *string = [TimeChange timeChange:model.createdAt];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *hourArr = [[array objectAtIndex:1] componentsSeparatedByString:@":"];
    _hourLabel.text = [NSString stringWithFormat:@"%@ : %@",[hourArr firstObject], [hourArr objectAtIndex:1]];
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    _yearLabel.text = [array firstObject];
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

-(void)setCurbModel:(CurbModel *)curbModel{
    //价格
    _priceLabel.text = [NSString stringWithFormat:@"%@  元",curbModel.price];
    _priceLabel.textColor = RGB(255, 156, 0);
    
    //地址
    NSDictionary *communityDic = [StringChangeJson jsonDictionaryWithString:curbModel.park_curb];
    NSArray *addArr = [communityDic[@"address"] componentsSeparatedByString:@"&" ];
    _addressLabel.text = [NSString stringWithFormat:@"%@",[addArr firstObject]];
    
    NSString *string = [TimeChange timeChange:curbModel.createdAt];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *hourArr = [[array objectAtIndex:1] componentsSeparatedByString:@":"];
    _hourLabel.text = [NSString stringWithFormat:@"%@ : %@",[hourArr firstObject], [hourArr objectAtIndex:1]];
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    _yearLabel.text = [array firstObject];
    _yearLabel.textAlignment = NSTextAlignmentCenter;
}

@end
