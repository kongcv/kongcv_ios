//
//  PushMessageTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/22.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "PushMessageTableViewCell.h"
#import "TimeChange.h"
@interface PushMessageTableViewCell()

@property (nonatomic,strong) UIImageView *categoryImage;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *label;

@end
@implementation PushMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView =[[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView];
        
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 72, frameX, 1)];
        imageView2.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView2];
        
        _categoryImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,4.5,24,27)];
        [self.contentView addSubview:_categoryImage];
        
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_categoryImage.frame)+9,0,frameX - CGRectGetMaxY(_categoryImage.frame)-10,36)];
        _addressLabel.font = UIFont(15);
        [self.contentView addSubview:_addressLabel];
        
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_categoryImage.frame)+9,CGRectGetMaxY(_addressLabel.frame),200*frameX/320.0,36)];
        _timeLabel.font = UIFont(15);
        [self.contentView addSubview:_timeLabel];
        
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeLabel.frame)+5,CGRectGetMaxY(_addressLabel.frame),70,36)];
        _label.font = UIFont(15);
        [self.contentView addSubview:_label];
        
    }
    
    return self;
}

-(void)setModel:(PushMessageModel *)model{
    NSString *string = [TimeChange timeChange:model.createdAt];
    _timeLabel.text = string;
    
    _addressLabel.text = model.extras[@"address"];
    
    if ([model.extras[@"mode"] isEqualToString:@"community"]) {
        _categoryImage.image = [UIImage imageNamed:@"bg_shequ"];
    }else if ([model.extras[@"mode"]  isEqualToString:@"curb"]){
        _categoryImage.image = [UIImage imageNamed:@"bg_daolu"];
    }
    
    NSString *state = [NSString stringWithFormat:@"%@",model.state];
    
    if (self.recv) {
        if ([state  isEqualToString:@"0"] ) {
            _label.text = @"未处理";
            _label.textColor = RGB(216, 216, 216);
        }else if ([state isEqualToString:@"1"]){
            _label.text = @"已接受";
            _label.textColor = RGB(118, 210, 90);
        }else{
            _label.text = @"拒绝";
            _label.textColor = RGB(225, 69, 55);
        }
    }else if (self.send){
        if ([state  isEqualToString:@"0"] ) {
            _label.text = @"未处理";
            _label.textColor = RGB(216, 216, 216);
        }else if ([state isEqualToString:@"1"]){
            _label.text = @"已接受";
            _label.textColor = RGB(118, 210, 90);
        }else{
            _label.text = @"拒绝";
            _label.textColor = RGB(225, 69, 55);
        }
    }
}

@end
