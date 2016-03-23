//
//  ParkingTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ParkingTableViewCell.h"
#import "TimeChange.h"
@interface ParkingTableViewCell()

@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *endLabel;

@end
@implementation ParkingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*frameX/320.0,0,300*frameX/320.0, 91*frameY/568.0)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5.0;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1.0;
        [self.contentView addSubview:imageView];
        
        UIImageView *navImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,7.5*frameY/568.0, 15*frameY/568.0, 20*frameY/568.0)];
        navImageView.image = [UIImage imageNamed:@"dwf@2x"];
        [self.contentView addSubview:navImageView];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(navImageView.frame)+5,1,250*frameX/320.0,33*frameY/568.0)];
        //_addressLabel.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_addressLabel];
        
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(10*frameX/320.0, CGRectGetMaxY(_addressLabel.frame), 300*frameX/320.0, 1)];
        imageViewLine.image = [UIImage imageNamed:@"bg_xiand"];
        [self.contentView addSubview:imageViewLine];
        
        NSArray *array = @[@"起始    :",@"结束    :"];
        UILabel *Label;
        for (int i = 0; i<2; i++) {
            Label  = [[UILabel alloc]initWithFrame:CGRectMake(24*frameX/320.0,CGRectGetMaxY(imageViewLine.frame)+25.3*frameY/568.0*i,80*frameX/320.0, 25.3*frameY/568.0)];
            Label.text = array[i];
            Label.font = UIFont(14);
            [self.contentView addSubview:Label];
        }
        
        _startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_addressLabel.frame),200*frameX/320.0, 25.3*frameY/568.0)];
        //_startLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_startLabel];
        
        _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Label.frame), CGRectGetMaxY(_startLabel.frame),200*frameX/320.0,25.3*frameY/568.0)];
        [self.contentView addSubview:_endLabel];

    }
    
    return self;
}



-(void)setModel:(GetParkingModel *)model{

    _model = model;
    
    NSArray *array = [model.address componentsSeparatedByString:@"&"];
    _addressLabel.text = [array firstObject];
    _addressLabel.font =UIFont(16);
 
    NSString *strartStr = [[[TimeChange timeChange:model.hire_start[@"iso"]] componentsSeparatedByString:@" "] firstObject];
    _startLabel.text = strartStr;
    _startLabel.font = UIFont(14);
    
    NSString *endStr = [[[TimeChange timeChange:model.hire_end[@"iso"]] componentsSeparatedByString:@" "] firstObject];
    _endLabel.text = endStr;
    _endLabel.font = UIFont(14);
    
}


@end
