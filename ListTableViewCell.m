//
//  ListTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/11.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ListTableViewCell.h"
@interface ListTableViewCell()

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *price;
@property (nonatomic,strong) UILabel *time;

@end
@implementation ListTableViewCell

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
        //self.contentView.backgroundColor = [UIColor redColor];
        UIImageView *imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, frameX-10, 1)];
        imageViewLine.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine];
        
        //出租名称
        _name = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(imageViewLine.frame), 100,33*frameX/320.0)];
        
        [self.contentView addSubview:_name];
        
        //出租时间段
        _time = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_name.frame)+5,CGRectGetMaxY(imageViewLine.frame), 110,33*frameX/320.0)];

        [self.contentView addSubview:_time];
        
        //出租价格
        _price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_time.frame),CGRectGetMaxY(imageViewLine.frame), 100,33*frameX/320.0)];

        [self.contentView addSubview:_price];
        

        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,CGRectGetMaxY(_price.frame), frameX-10, 1)];
        imageView.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView];
        
    }
    
    return self;
}

-(void)setModel:(ListModel *)model{

    _name.text = model.objectName;
    if (![model.hire_time isEqualToString:@"0"]) {
        _time.text    = model.hire_time;
    }else{
        _time.text = @"";
    }
    _price.text   =  model.price;
    
}

@end
