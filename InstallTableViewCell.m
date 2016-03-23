//
//  InstallTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 16/3/16.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "InstallTableViewCell.h"

@implementation InstallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *topImageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
        
        topImageViewLine.image = [UIImage imageNamed:@"720@2x"];
        
        [self.contentView addSubview:topImageViewLine];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,1,frameX-30,45*frameX/320.0)];
        self.titleLabel.font = UIFont(15);
        [self.contentView addSubview:self.titleLabel];
        
        
        UIImageView *btomImageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,47*frameX/320.0, frameX, 1)];
        
        btomImageViewLine.image = [UIImage imageNamed:@"720@2x"];
        
        [self.contentView addSubview:btomImageViewLine];
        
    }
    
    return self;
}



@end
