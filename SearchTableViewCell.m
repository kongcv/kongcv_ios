//
//  SearchTableViewCell.m
//  kongchewei
//
//  Created by 空车位 on 15/10/31.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "SearchTableViewCell.h"

@interface SearchTableViewCell()
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *preiceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *isHIreLabel;
@property (nonatomic,strong) UILabel *unitLabel;
@end
@implementation SearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, frameX, 1)];
        imageViewLine.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageViewLine];
        
        

        
        if (frameX == 320.0) {
            _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,2.5,frameX - 70,25)];
            _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressLabel.frame),220,20)];
        }else if (frameX == 375.0){
            _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,2.5,frameX - 60,25)];
            _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressLabel.frame),270,20)];
        }else if (frameX == 414.0){
            _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,2.5,frameX - 90,25)];
            _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressLabel.frame),300,20)];
        }
        _addressLabel.font = UIFont(16);
        [self.contentView addSubview:_addressLabel];
        
        _detailLabel.font = UIFont(14);
        [self.contentView addSubview:_detailLabel];
        
        _isHIreLabel = [[UILabel alloc]init];
        //_isHIreLabel.backgroundColor = [UIColor redColor];
        if (frameX == 414.0) {
            _isHIreLabel.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame)+10,2.5,40,20);
        }else{
            _isHIreLabel.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame),2.5,40,20);
        }
        _isHIreLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_isHIreLabel];

        
        if (frameX ==414.0) {
            _preiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressLabel.frame)-40,CGRectGetMaxY(_addressLabel.frame), 100, 20)];
        }else if(frameX == 320.0){
            _preiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressLabel.frame)-40,CGRectGetMaxY(_addressLabel.frame), 80, 20)];
        }else{
            _preiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressLabel.frame)-50,CGRectGetMaxY(_addressLabel.frame), 90, 20)];
        }
        //_preiceLabel.backgroundColor = [UIColor redColor];
        _preiceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_preiceLabel];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame)+2.5, frameX, 1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView];
        
    }
    
    return self;
}

-(void)setModel:(SearchModel *)model{
    
    if (model.address) {
        NSString *address = model.address;
        NSArray *array = [address componentsSeparatedByString:@"&"];
        _addressLabel.text = [array firstObject];
        _detailLabel.text = [array lastObject];
        _detailLabel.textColor = RGB(53,53,53);
    }

    
    NSString *string = [NSString stringWithFormat:@"%@",model.park_space];
    _isHIreLabel.textColor = RGB(86, 86, 86);
    _isHIreLabel.font = UIFont(14);
    if ([string isEqualToString:@"0"]) {
        _isHIreLabel.text = @"已租";
    }else{
        _isHIreLabel.text = @"";
    }
  
    NSArray *priceArray = model.hire_price;
    NSArray  *methodArray = model.hire_method;
    for (int i = 0;i<methodArray.count;i++) {
        NSDictionary *dictionary = methodArray[i];
        if ([dictionary[@"objectId"] isEqualToString:self.hire_method_id]) {
            _preiceLabel.text = [NSString stringWithFormat:@"¥ %@",priceArray[i]];
            _preiceLabel.textColor = RGB(255,0,0);
            _preiceLabel.font = UIFont(16);
        }
    }
    
}

@end
