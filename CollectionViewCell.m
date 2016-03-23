//
//  CollectionViewCell.m
//  kongcv
//
//  Created by 空车位 on 16/3/9.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "CollectionViewCell.h"

#import "UIImageView+WebCache.h"
@interface CollectionViewCell()

@property (nonatomic,strong) UIImageView *imageView;   //图片

@property (nonatomic,strong) UIImageView *methodImageView;

@end
@implementation CollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,frameX/2.0 - 0.5,60)];
            
        [self.contentView addSubview:_imageView];

    }
    
    return self;
}


-(void)setModel:(PicturesModel *)model{

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.picture_small[@"url"]]];

}






@end
