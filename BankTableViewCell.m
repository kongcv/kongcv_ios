//
//  BankTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/17.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "BankTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface BankTableViewCell()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *logoimageView;

@end
@implementation BankTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
        imageLine.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageLine];
        
        _logoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(70,10, 30, 30)];
        //_logoimageView.image = [UIImage imageNamed:@"btn_jiahao@2x"];
        [self.contentView addSubview:_logoimageView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_logoimageView.frame)+35, 0, 200, 50)];
        [self.contentView addSubview:_label];
        
        UIImageView *imageLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_label.frame), frameX, 1)];
        imageLine1.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageLine1];
        
    }
    
    return self;
}

-(void)setModel:(BankModel *)model{

    _model = model;
    _label.text = model.bank;
    [_logoimageView sd_setImageWithURL:[NSURL URLWithString:model.picture[@"url"]]];
}

@end
