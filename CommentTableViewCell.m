//
//  CommentTableViewCell.m
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PAImageView.h"
#import "TimeChange.h"
#define kLeftGap4s 14.2
#define kLeftGap6    17.1
#define kLeftGap6p  18.5
#define ktopGap4s  8.3
#define ktopGap6    10
#define ktopGap6p  10.8
#define kImageWidth4s   44
#define kImageWidth6     38
#define kImageWidth6p  45
#define kLabelWidth4s
#define kLabelWidth6
#define kLabelWidth6p
#define kUIColorFromRGB(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF0000) >> 8))/255.0 blue:((float)(rgbValue & 0xFF0000))/255.0 alpha:1.0]
@interface CommentTableViewCell()
@property (nonatomic,strong) PAImageView *ImageView;//头像
@property (nonatomic,strong) UILabel *nameLabel;//名字
@property (nonatomic,strong) UIImageView *gradeImageView;//评分级别
@property (nonatomic,strong) UILabel *describeLabel;//评论内容
@property (nonatomic,strong) UILabel *dateLabel;//时间
@property (nonatomic,strong) UIImageView *imageViewLine;
@property (nonatomic,strong) UIImageView *headImageView;
@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        UIImageView *imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
        imageLine.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageLine];
        
        //头像
        if (frameX == 320.0) {
            _ImageView    = [[PAImageView alloc]initWithFrame:CGRectMake(5,ktopGap4s,kImageWidth4s, kImageWidth4s) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,ktopGap4s,kImageWidth4s, kImageWidth4s)];
        }else if (frameX == 375.0){
            _ImageView    = [[PAImageView alloc]initWithFrame:CGRectMake(5,ktopGap6,kImageWidth6, kImageWidth6) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];

            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,ktopGap6,kImageWidth6, kImageWidth6)];
        }else if (frameX == 414.0){
            _ImageView    = [[PAImageView alloc]initWithFrame:CGRectMake(5,ktopGap6p,kImageWidth6p, kImageWidth6p) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
            _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,ktopGap6p,kImageWidth6p, kImageWidth6p)];
        }
        [self.contentView addSubview:_headImageView];
        [self.contentView addSubview:_ImageView];
        //名字
        _nameLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            _nameLabel.frame = CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3,9.5,frameX - CGRectGetMaxY(_ImageView.frame)+5.3-125,20);
        }else if (frameX == 375.0){
            _nameLabel.frame = CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.4,11.4,frameX - CGRectGetMaxY(_ImageView.frame)+6.4-135, 15);
        }else if (frameX == 414.0){
            _nameLabel.frame = CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.9,12.3,frameX - CGRectGetMaxY(_ImageView.frame)+6.9-150, 15);
        }
        [self.contentView addSubview:_nameLabel];
        
        //时间
        _dateLabel = [[UILabel alloc]init];
        if ( frameX == 320.0) {
            _dateLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame),12,120,15);
        }else if (frameX == 375.0){
           _dateLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame),12,120,15);
        }else{
           _dateLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame),12,120,15);
        }
        [self.contentView addSubview:_dateLabel];
        
    
        //评分级别
        for (int i = 0; i<5; i++) {
            if (frameX == 320.0) {
                _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3+15*i,CGRectGetMaxY(_nameLabel.frame)+6.2 , 13, 13)];
            }else if (frameX == 375.0){
                _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.4+15*i,CGRectGetMaxY(_nameLabel.frame)+7.5 , 13, 13)];
            }else if (frameX == 414.0){
                _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.9+15*i,CGRectGetMaxY(_nameLabel.frame)+8.1 , 13, 13)];
            }
            _gradeImageView.image = [UIImage imageNamed:@"xxh"];
            [self.contentView addSubview:_gradeImageView];
        }
   
        [self.contentView addSubview:_gradeImageView];
        
        //评论内容
        _describeLabel = [[UILabel alloc]init];

        _describeLabel.textColor = RGB(133, 133, 133);
        
        _describeLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_describeLabel];
        
        _imageViewLine = [[UIImageView alloc]init];
        
        _imageViewLine.image = [UIImage imageNamed:@"720@2x"];
        
        [self.contentView addSubview:_imageViewLine];
        
    }
    return self;
}

-(void)setModel:(CommentModel *)model{
    _headImageView.layer.masksToBounds = YES;
    if (frameX == 320.0) {
        _headImageView.layer.cornerRadius = 27.0;
    }else if (frameX == 375.0){
        _headImageView.layer.cornerRadius = 22.0;
    }else{
        _headImageView.layer.cornerRadius = 27.0;
    }
    //头像
    if (model.user) {
        NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:model.user];
        if (dictionary[@"image"][@"url"]) {

            [_headImageView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"image"][@"url"]]];
        }else{
            _headImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
            [self bringSubviewToFront:_headImageView];
        }
    }

    
    //名字
    if (model.user) {
        NSData *data = [model.user dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *userDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([userDic[@"mobilePhoneNumber"] isEqualToString:userDic[@"username"]]) {
            NSString *string =  userDic[@"username"];
            NSString *s = [string substringWithRange:NSMakeRange(0, 3)];
            NSString *str = [string substringWithRange:NSMakeRange(7, 4)];
            _nameLabel.text = [NSString stringWithFormat:@"%@****%@",s,str];
        }else{
            _nameLabel.text = userDic[@"username"];
        }
        _nameLabel.font = UIFont(14);
    }

    //时间
    NSString *string = [TimeChange timeChange:model.createdAt];
    _dateLabel.text = [[string componentsSeparatedByString:@" "] firstObject];
    _dateLabel.font = UIFont(14);
    
    int grade = [model.grade intValue];
    //评级
    for (int i = 0; i<grade; i++) {
        if (frameX == 320.0) {
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3+15*i,CGRectGetMaxY(_nameLabel.frame)+6.2 , 13, 13)];
        }else if (frameX == 375.0){
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.4+15*i,CGRectGetMaxY(_nameLabel.frame)+7.5 , 13, 13)];
        }else if (frameX == 414.0){
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.9+15*i,CGRectGetMaxY(_nameLabel.frame)+8.1 , 13, 13)];
        }
        _gradeImageView.image = [UIImage imageNamed:@"xx"];
        [self.contentView addSubview:_gradeImageView];
    }
    
    //评论内容@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=5454ab5e0bf7905我撒娇南昌机场出口继续增加博采众长继续展开比赛快结束吧擦机场巴士灿烂呢"
    _describeLabel.text = model.comment;
    _describeLabel.font = UIFont(15);
    _describeLabel.textColor = RGB(53, 53, 53);
    CGFloat width ;
    if (frameX == 320.0) {
        width = CGRectGetMaxX(_ImageView.frame)+5.3;
    }else if (frameX == 375.0){
        width = CGRectGetMaxX(_ImageView.frame)+6.4;
    }else if (frameX == 414.0){
        width = CGRectGetMaxX(_ImageView.frame)+6.9;
    }

    CGSize textSize=[_describeLabel.text boundingRectWithSize:CGSizeMake(frameX - CGRectGetMaxX(_ImageView.frame)+5.3-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} context:nil].size;
    
    _describeLabel.frame = CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3,CGRectGetMaxY(_gradeImageView.frame)+17.2, frameX -width, textSize.height);
    
    _imageViewLine.frame = CGRectMake(0, CGRectGetMaxY(_describeLabel.frame)+16.6, frameX, 1);
    
    //高度
    _cellHeight  = CGRectGetMaxY(_describeLabel.frame);
}

- (void)setRouteModel:(RouteCommentModel *)routeModel{
    
    if (routeModel.user) {
        NSDictionary *dictionary = [StringChangeJson jsonDictionaryWithString:routeModel.user];
        if (dictionary[@"image"][@"url"]) {
            _headImageView.layer.masksToBounds = YES;
            if (frameX == 320.0) {
                _headImageView.layer.cornerRadius = 27.0;
            }else if (frameX == 375.0){
                _headImageView.layer.cornerRadius = 39.0;
            }else{
                _headImageView.layer.cornerRadius = 39.0;
            }
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"image"][@"url"]]];
        }else{
            _headImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
            [self bringSubviewToFront:_headImageView];
        }
    }
    
    
    //名字
    if (routeModel.user) {
        NSData *data = [routeModel.user dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *userDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([userDic[@"mobilePhoneNumber"] isEqualToString:userDic[@"username"]]) {
            NSString *string =  userDic[@"username"];
            NSString *s = [string substringWithRange:NSMakeRange(0, 3)];
            NSString *str = [string substringWithRange:NSMakeRange(7, 4)];
            _nameLabel.text = [NSString stringWithFormat:@"%@****%@",s,str];
        }else{
            _nameLabel.text = userDic[@"username"];
        }
        _nameLabel.font = UIFont(14);
    }
    
    //时间
    NSString *string = [TimeChange timeChange:routeModel.createdAt];
    _dateLabel.text = [[string componentsSeparatedByString:@" "] firstObject];
    _dateLabel.font = UIFont(15);
    
    int grade = [routeModel.grade intValue];
    //评级
    for (int i = 0; i<grade; i++) {
        if (frameX == 320.0) {
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3+15*i,CGRectGetMaxY(_nameLabel.frame)+6.2 , 13, 13)];
        }else if (frameX == 375.0){
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.4+15*i,CGRectGetMaxY(_nameLabel.frame)+7.5 , 13, 13)];
        }else if (frameX == 414.0){
            _gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ImageView.frame)+6.9+15*i,CGRectGetMaxY(_nameLabel.frame)+8.1 , 13, 13)];
        }
        _gradeImageView.image = [UIImage imageNamed:@"xx"];
        [self.contentView addSubview:_gradeImageView];
    }
    
    _describeLabel.text = routeModel.comment;
    _describeLabel.font = UIFont(15);
    _describeLabel.textColor = RGB(53, 53, 53);
    CGFloat width ;
    if (frameX == 320.0) {
        width = CGRectGetMaxX(_ImageView.frame)+5.3;
    }else if (frameX == 375.0){
        width = CGRectGetMaxX(_ImageView.frame)+6.4;
    }else if (frameX == 414.0){
        width = CGRectGetMaxX(_ImageView.frame)+6.9;
    }
    
    CGSize textSize=[_describeLabel.text boundingRectWithSize:CGSizeMake(frameX - CGRectGetMaxX(_ImageView.frame)+5.3-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} context:nil].size;
    
    _describeLabel.frame = CGRectMake(CGRectGetMaxX(_ImageView.frame)+5.3,CGRectGetMaxY(_gradeImageView.frame)+17.2, frameX -width, textSize.height);
    
    _imageViewLine.frame = CGRectMake(0, CGRectGetMaxY(_describeLabel.frame)+16.6, frameX, 1);
    
    //高度
    _cellHeight  = CGRectGetMaxY(_describeLabel.frame);
}

@end
