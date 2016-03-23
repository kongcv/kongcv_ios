//
//  TipTableViewCell.m
//  kongchewei
//
//  Created by 空车位 on 15/10/29.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "TipTableViewCell.h"
@interface TipTableViewCell ()
{

    UILabel *_label;
    UILabel *_cityLabel;
}
@end

@implementation TipTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageViewLine1 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine1.frame = CGRectMake(0, 0, frameX, 1);
        }
        imageViewLine1.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageViewLine1];
        
        UIImageView *imageViewLine2 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine1.frame)+39,frameX, 1);
        }else {
            imageViewLine2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine2.frame)+44, frameX, 1);
        }
        imageViewLine2.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageViewLine2];
        
       //图标
        UIImageView *imageView = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageView.frame = CGRectMake(10,CGRectGetMaxY(imageViewLine1.frame)+10, 15, 20);
        }else{
            imageView.frame = CGRectMake(10, CGRectGetMaxY(imageViewLine1.frame)+10, 18, 25);
        }
        imageView.image = [UIImage imageNamed:@"33"];
        [self.contentView addSubview:imageView];
        
        //地址
        _label = [[UILabel alloc]init];
        //_label.backgroundColor = [UIColor redColor];
        _cityLabel = [[UILabel alloc]init];
        //_cityLabel.backgroundColor = [UIColor cyanColor];
        if (frameX == 320.0) {
            _label.frame = CGRectMake(40,CGRectGetMaxY(imageViewLine1.frame), frameX-150, 37);
            _cityLabel.frame = CGRectMake(CGRectGetMaxX(_label.frame),CGRectGetMaxY(imageViewLine1.frame)+10,80,27);
        }else{
            _label.frame = CGRectMake(40, CGRectGetMaxY(imageViewLine1.frame), frameX-150, 42);
            _cityLabel.frame = CGRectMake(CGRectGetMaxX(_label.frame),CGRectGetMaxY(imageViewLine1.frame)+15,80 ,27 );
        }
        [self.contentView addSubview:_cityLabel];
        [self.contentView addSubview:_label];
        
        //尖头
        UIImageView *imageView2 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageView2.frame = CGRectMake(CGRectGetMaxX(_cityLabel.frame)+5, CGRectGetMaxY(imageViewLine1.frame)+12.5,15, 15);
        }else{
            imageView2.frame = CGRectMake(CGRectGetMaxX(_cityLabel.frame)+5, CGRectGetMaxY(imageViewLine1.frame)+13.5, 18, 18);
        }
        imageView2.image = [UIImage imageNamed:@"45"];
        [self.contentView addSubview:imageView2];

        
    }
    
    return self;
}

- (void)setModel:(TipModel *)model{
    _model = model;
    
    _label.text = model.name;
    _label.font = UIFont(16);
    
    NSString *pStr = [[model.district componentsSeparatedByString:@"市"] firstObject];
    NSString *city = [[pStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"省区"]] lastObject];
    
    _cityLabel.text = [NSString stringWithFormat:@"%@市",city];
    _cityLabel.font   =  UIFont(12);
    _cityLabel.textAlignment = NSTextAlignmentCenter;
}

@end
