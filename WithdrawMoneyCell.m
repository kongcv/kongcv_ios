//
//  WithdrawMoneyCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/16.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "WithdrawMoneyCell.h"
@interface WithdrawMoneyCell()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *timeLabel;
@end
@implementation WithdrawMoneyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frameX, 1)];
        imageView.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageView];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,0, frameX/2+40,50)];
        [self.contentView addSubview:_timeLabel];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, frameX/2-60,50)];
        _label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_label];
        
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,50, frameX, 1)];
        imageView1.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageView1];
        
    }
    return self;
}


-(void)setModel:(WithdrawModel *)model{

    _model = model;
    
    //2015-12-17T01:54:20.407Z
    
    NSArray *array = [model.createdAt componentsSeparatedByString:@"."];
    
    NSString *dateStr  =  [[array firstObject] stringByAppendingString:@"+0000"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *localDate = [dateFormatter dateFromString:dateStr];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:localDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:localDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:localDate];
    
    NSString *string = [NSString stringWithFormat:@"%@",destinationDateNow];
    
    NSArray *dateArray = [string componentsSeparatedByString:@"+"];
    
    _label.text = [NSString stringWithFormat:@"¥ %@",model.money];

    _timeLabel.text  = [NSString stringWithFormat:@"%@",[dateArray firstObject]];
}

@end
