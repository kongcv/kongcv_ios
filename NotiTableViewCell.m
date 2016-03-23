//
//  NotiTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 16/1/7.
//  Copyright © 2016年 空车位. All rights reserved.
//

#import "NotiTableViewCell.h"
#import "QRadioButton.h"
#import "CalculateUnit.h"
#import "TimeChange.h"
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3
@interface NotiTableViewCell ()
@property(nonatomic,strong) KongCVHttpRequest *jpushRequest;
@property(nonatomic,strong) KongCVHttpRequest *insertRequest;
@property(nonatomic,strong) KongCVHttpRequest *changeMessRequest;
@property(nonatomic,strong) KongCVHttpRequest *acceptRequest;
@property(nonatomic,copy)   NSString *method;
@property(nonatomic,strong) NSArray *methodArray;
@property(nonatomic,strong) UILabel  *addressLabel;
@property(nonatomic,strong) UILabel  *detailAddressLabel;
@property(nonatomic,strong) UILabel  *timeLabel;
@property(nonatomic,strong) UILabel  *noDayLabel;
@property(nonatomic,strong) UILabel  *arearLabel;
@property(nonatomic,strong) UILabel  *heightLabel;
@property(nonatomic,strong) UILabel  *numLabel;
@property(nonatomic,strong) UILabel  *normalLabel;
@property(nonatomic,strong) UILabel  *groundLabel;
@property(nonatomic,strong) UILabel  *gateCardLabel;
@property(nonatomic,strong) UILabel  *descritedLabel;
@property(nonatomic,strong) UILabel  *typeLbael;
@property(nonatomic,strong) UILabel  *typeLabel1;
@property(nonatomic,strong) UILabel  *iphoneLabel;
@property(nonatomic,strong) UIImageView *imageViewLine13;
@property(nonatomic,strong) UIImageView *imageViewLine14;
@property(nonatomic,strong) UIImageView *imageViewLine15;
@property(nonatomic,strong) UIImageView *imageViewLine16;
@property(nonatomic,strong) UIImageView *imageVIewLine17;
@property(nonatomic,strong) UIImageView *imageViewLine18;
@property(nonatomic,strong) UIImageView *imageViewLine19;
@property(nonatomic,strong) UIView *view4;
@property(nonatomic,strong) UIView *view5;
@property(nonatomic,strong) UIView *view6;

@property(nonatomic,strong) QRadioButton *qradioButton;

@property(nonatomic,copy)   NSString *mobileNum;

@property(nonatomic,copy)   NSString *device_Token;

@property(nonatomic,copy)   NSString *owndevice_type;

@property(nonatomic,copy)   NSString *user_id;

@property(nonatomic,strong) NSArray *priceArray;

@property(nonatomic,copy)   NSString *unitPrice;

@property(nonatomic,copy)   NSString *property_id; //物业Id

@property(nonatomic,copy)   NSString *hire_filed_id;

@property(nonatomic,strong) NSMutableArray *fieldArray;

@end
@implementation NotiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //Iphone4s /3.375   Iphone6 /2.8  Ipone6p/2.6
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = RGB(247, 247, 247);
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = RGB(255, 255, 255);
        if (frameX == 320.0) {
            view.frame = CGRectMake(0, 3.6, frameX, kWidth4s+2);
        }else if (frameX == 375.0){
            view.frame = CGRectMake(0,4.3, frameX, kWidth6+2);
        }else if (frameX == 414.0){
            view.frame = CGRectMake(0,4.6, frameX, kWidth6p+2);
        }
        [self.contentView addSubview:view];
        
        UIImageView *imageViewLine1 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine1.frame = CGRectMake(0,3.6, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine1.frame = CGRectMake(0,4.3, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine1.frame = CGRectMake(0, 4.6, frameX, 1);
        }
        imageViewLine1.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine1];
        UIImageView *imageViewLine2 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine1.frame)+kWidth4s+1, frameX,1);
        }else if (frameX == 375.0){
            imageViewLine2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine1.frame)+kWidth6+1, frameX,1);
        }else if (frameX == 414.0){
            imageViewLine2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine1.frame)+kWidth6p+1, frameX,1);
        }
        imageViewLine2.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine2];
        
        //地址图片
        UIImageView *adressImage = [[UIImageView alloc]init];
        adressImage.image = [UIImage imageNamed:@"dwf@2x"];
        if (frameX == 320.0) {
            adressImage.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageViewLine1.frame)+6.3,15,20);
        }else if (frameX == 375.0){
            adressImage.frame = CGRectMake(kGap6,CGRectGetMaxY(imageViewLine1.frame)+10,15,20);
        }else if (frameX == 414.0){
            adressImage.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageViewLine1.frame)+8.65,18,25);
        }
        [self.contentView addSubview:adressImage];
        
        //地址信息
        _addressLabel = [[UILabel alloc]init];
         _addressLabel.font = UIFont(17);
        if (frameX == 320.0) {
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, 5.6 , frameX-adressImage.frame.size.width,kWidth4s);
        }else if (frameX == 375.0){
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5, 6.3 , frameX-adressImage.frame.size.width,kWidth6);
        }else if (frameX == 414.0){
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,6.6, frameX-adressImage.frame.size.width,kWidth6p);
           
        }
        [self.contentView addSubview:_addressLabel];
        
        _detailAddressLabel = [[UILabel alloc]init];
        UIView *detailView = [[UIImageView alloc]init];
        
        if (frameX == 320.0) {
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, CGRectGetMaxY(imageViewLine2.frame) , frameX-adressImage.frame.size.width,kWidth4s);
            detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX,kWidth4s);
            _detailAddressLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5, CGRectGetMaxY(imageViewLine2.frame) , frameX-adressImage.frame.size.width,kWidth6);
             detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX,kWidth6);
            _detailAddressLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,CGRectGetMaxY(imageViewLine2.frame), frameX-adressImage.frame.size.width,kWidth6p);
             detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX, kWidth6p);
            _detailAddressLabel.font = UIFont(16);
        }
        detailView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:detailView];
        [self.contentView addSubview:_detailAddressLabel];
        UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailAddressLabel.frame),frameX,1)];
        detailImage.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:detailImage];
        
        
        //起始时间
        UIImageView *imageViewLine3 = [[UIImageView alloc]init];
        if (frameX == 320) {
            imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_detailAddressLabel.frame)+11.85, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_detailAddressLabel.frame)+14.3, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_detailAddressLabel.frame)+15.4, frameX, 1);
        }
        imageViewLine3.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine3];
        
        UIImageView *imageViewLine4 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine4.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame)+66.8, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine4.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame)+80.3, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine4.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame)+86.4, frameX, 1);
        }
        imageViewLine4.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine4];
        
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = RGB(255, 255, 255);
        if (frameX == 320.0) {
            view1.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame), frameX,66.8);
        }else if (frameX == 375.0){
            view1.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame), frameX,80.3);
        }else if (frameX == 414.0){
            view1.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine3.frame), frameX,86.4);
        }
        [self.contentView addSubview:view1];
        // 9 34.4 352 52.4
        //开始图片
        UIImageView *startImageView = [[UIImageView alloc]init];
        UILabel *startLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            startImageView.frame = CGRectMake(CGRectGetMaxX(adressImage.frame), CGRectGetMaxY(imageViewLine3.frame)+6.5,20,20);
            startLabel.frame = CGRectMake(CGRectGetMaxX(startImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+4,60,25);
            startLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            startImageView.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5, CGRectGetMaxY(imageViewLine3.frame)+12,22,22);
            startLabel.frame = CGRectMake(CGRectGetMaxX(startImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+7.5,70,30);
            startLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            startImageView.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+10, CGRectGetMaxY(imageViewLine3.frame)+11,24,24);
            startLabel.frame = CGRectMake(CGRectGetMaxX(startImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+7.5,70,30);
            startLabel.font = UIFont(16);
        }
        startLabel.text = @"起始时间";
        startImageView.image = [UIImage imageNamed:@"icon_qishi"];
        [self.contentView addSubview:startLabel];
        [self.contentView addSubview:startImageView];
        //结束图片
        UIImageView *endImageView = [[UIImageView alloc]init];
        UILabel *endLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            endImageView.frame = CGRectMake(CGRectGetMaxX(startLabel.frame)+108, CGRectGetMaxY(imageViewLine3.frame)+6.5,20,20);
            endLabel.frame = CGRectMake(CGRectGetMaxX(endImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+4,60,25);
            endLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            endImageView.frame = CGRectMake(CGRectGetMaxX(startLabel.frame)+135, CGRectGetMaxY(imageViewLine3.frame)+12,22,22);
            endLabel.frame = CGRectMake(CGRectGetMaxX(endImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+7.5,60,30);
            endLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            endImageView.frame = CGRectMake(CGRectGetMaxX(startLabel.frame)+150, CGRectGetMaxY(imageViewLine3.frame)+11,24,24);
            endLabel.frame = CGRectMake(CGRectGetMaxX(endImageView.frame)+2,CGRectGetMaxY(imageViewLine3.frame)+7.5,70,30);
            endLabel.font = UIFont(16);
        }
        endImageView.image = [UIImage imageNamed:@"icon_jieshu"];
        endLabel.text = @"结束时间";
        [self.contentView addSubview:endImageView];
        [self.contentView addSubview:endLabel];
        
        _timeLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            _timeLabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(startImageView.frame)+5,frameX - 2*kGap4s, 32);
            _timeLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _timeLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(startImageView.frame)+8,frameX - 2*kGap6, 32);
            _timeLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _timeLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(startImageView.frame)+8,frameX - 2*kGap6p, 32);
            _timeLabel.font = UIFont(16);
        }
        [self.contentView addSubview:_timeLabel];
        
        //非出租日/周
        UIImageView *imageViewLine5 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine4.frame)+15.4, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine4.frame)+18.6, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine4.frame)+20, frameX, 1);
        }
        imageViewLine5.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine5];
        
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = RGB(255, 255, 255);
        if (frameX == 320.0) {
            view2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame), frameX,kWidth4s*4+3);
        }else if (frameX == 375.0){
            view2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame), frameX,kWidth6*4+3);
        }else if (frameX == 414.0){
            view2.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame), frameX,kWidth6p*4+3);
        }
        [self.contentView addSubview:view2];
        
        UIImageView *imageViewLine6 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame)+kWidth4s +1, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame)+kWidth6+1, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine5.frame)+kWidth6p+1, frameX, 1);
        }
        imageViewLine6.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine6];
        
        
        UILabel *noLabel = [[UILabel alloc]init];
        _noDayLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            noLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth4s);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap4s*2, kWidth4s);
            _noDayLabel.font = UIFont(15);
            noLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            noLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth6);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap6*2, kWidth6);
            _noDayLabel.font = UIFont(15);
            noLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            noLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth6p);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap6p*2, kWidth6p);
            _noDayLabel.font = UIFont(16);
            noLabel.font = UIFont(16);
        }
        noLabel.text = @"非出租日/周";
        [self.contentView addSubview:noLabel];
        [self.contentView addSubview:_noDayLabel];
        
        //车位面积
        UIImageView *imageViewLine7 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine7.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine6.frame)+kWidth4s,frameX,1);
        }else if (frameX == 375.0){
            imageViewLine7.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine6.frame)+kWidth6,frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine7.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine6.frame)+kWidth6p,frameX,1);
        }
        imageViewLine7.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine7];
        
        
        UILabel *arealabel = [[UILabel alloc]init];
        _arearLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            arealabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth4s);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap4s*2 - arealabel.frame.size.width, kWidth4s);
            _arearLabel.font = UIFont(15);
            arealabel.font = UIFont(15);
        }else if (frameX == 375.0){
            arealabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth6);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap6*2 - arealabel.frame.size.width, kWidth6);
            _arearLabel.font = UIFont(15);
            arealabel.font = UIFont(15);
        }else if (frameX == 414.0){
            arealabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth6p);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap6p*2 - arealabel.frame.size.width, kWidth6p);
            _arearLabel.font = UIFont(16);
            arealabel.font = UIFont(16);
        }
        arealabel.text = @"车位面积";
        [self.contentView addSubview:arealabel];
        [self.contentView addSubview:_arearLabel];
        
        //车位限高
        UIImageView *imageViewLine8 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine8.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine7.frame)+kWidth4s, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine8.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine7.frame)+kWidth6, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine8.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine7.frame)+kWidth6p, frameX, 1);
        }
        imageViewLine8.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine8];
        
        UILabel *height = [[UILabel alloc]init];
        _heightLabel = [[UILabel alloc]init];
        
        if (frameX == 320.0) {
            height.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth4s);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap4s*2, kWidth4s);
            _heightLabel.font = UIFont(15);
            height.font = UIFont(15);
        }else if (frameX == 375.0){
            height.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth6);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap6*2, kWidth6);
            _heightLabel.font = UIFont(15);
            height.font = UIFont(15);
        }else if (frameX == 414.0){
            height.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth6p);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap6p*2, kWidth6p);
            _heightLabel.font = UIFont(16);
            height.font = UIFont(16);
        }
        height.text = @"车位限高";
        [self.contentView addSubview:height];
        [self.contentView addSubview:_heightLabel];
        
        //添加车牌尾号
        UIImageView *imageViewLine9 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine9.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine8.frame)+kWidth4s, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine9.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine8.frame)+kWidth6, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine9.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine8.frame)+kWidth6p, frameX, 1);
        }
        imageViewLine9.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine9];
        
        UILabel *numlabel = [[UILabel alloc]init];
        _numLabel  = [[UILabel alloc]init];
        if (frameX == 320.0) {
            numlabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth4s);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap4s*2, kWidth4s);
            _numLabel.font = UIFont(15);
            numlabel.font = UIFont(15);
        }else if (frameX == 375.0){
            numlabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth6);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap6*2, kWidth6);
            _numLabel.font = UIFont(15);
            numlabel.font = UIFont(15);
        }else if (frameX == 414.0){
            numlabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth6p);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap6p*2, kWidth6p);
            _numLabel.font = UIFont(16);
            numlabel.font = UIFont(16);
        }
        numlabel.text = @"车牌尾号";
        [self.contentView addSubview:numlabel];
        [self.contentView addSubview:_numLabel];
        
        //是否是正规车位
        UIImageView *imageViewLine10 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine10.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine9.frame)+15.4,frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine10.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine9.frame)+18.6,frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine10.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine9.frame)+20,frameX, 1);
        }
        imageViewLine10.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine10];
        
        
        UIView *view3 = [[UIView alloc]init];
        view3.backgroundColor = RGB(255, 255, 255);
        if (frameX == 320.0) {
            view3.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame), frameX, 2*kWidth4s+1);
        }else if (frameX == 375.0){
            view3.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame), frameX, 2*kWidth6+1);
        }else if (frameX == 414.0){
            view3.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame), frameX, 2*kWidth6p+1);
        }
        [self.contentView addSubview:view3];
        
        UIImageView *imageViewLine11 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine11.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame)+kWidth4s, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine11.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame)+kWidth6, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine11.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine10.frame)+kWidth6p, frameX, 1);
        }
        imageViewLine11.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine11];
        
        UILabel *norLabel = [[UILabel alloc]init];
        _normalLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            norLabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth4s);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap4s*2, kWidth4s);
            _normalLabel.font = UIFont(15);
            norLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            norLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth6);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap6*2, kWidth6);
            _normalLabel.font = UIFont(15);
            norLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            norLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth6p);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap6p*2, kWidth6p);
            _normalLabel.font = UIFont(16);
            norLabel.font = UIFont(16);
        }
        norLabel.text = @"是否正规车位";
        [self.contentView addSubview:norLabel];
        [self.contentView addSubview:_normalLabel];
        
        //地上地下
        UIImageView *imageViewLine12 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine12.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine11.frame)+kWidth4s, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine12.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine11.frame)+kWidth6, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine12.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine11.frame)+kWidth6p, frameX, 1);
        }
        imageViewLine12.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine12];
        
        UILabel *grLabel = [[UILabel alloc]init];
        _groundLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            grLabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth4s);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap4s*2, kWidth4s);
            _groundLabel.font = UIFont(15);
            grLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            grLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth6);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap6*2, kWidth6);
            _groundLabel.font = UIFont(15);
            grLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            grLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth6p);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap6p*2, kWidth6p);
            _groundLabel.font = UIFont(16);
            grLabel.font = UIFont(16);
        }
        grLabel.text = @"地上地下";
        [self.contentView addSubview:grLabel];
        [self.contentView addSubview:_groundLabel];
        
        
        //有无门禁卡
        UIImageView *imageViewLine13 = [[UIImageView alloc]init];
        _imageViewLine13 = imageViewLine13;
        if (frameX == 320.0) {
            imageViewLine13.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine12.frame)+11.9, frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine13.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine12.frame)+14.2, frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine13.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine12.frame)+15.4, frameX, 1);
        }
        imageViewLine13.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine13];
        
        UIView *view4 = [[UIView alloc]init];
        view4.backgroundColor = RGB(255, 255, 255);
        _view4 = view4;
        [self.contentView addSubview:view4];
        
        _gateCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:_gateCardLabel];
        
        //车位描述
        UIImageView *imageViewLine14 = [[UIImageView alloc]init];
        _imageViewLine14 = imageViewLine14;
        imageViewLine14.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine14];
        
        _descritedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:_descritedLabel];
        
        
        UIImageView *imageViewLine15 = [[UIImageView alloc]init];
        _imageViewLine15 = imageViewLine15;
        imageViewLine15.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine15];
        
        //出租类型
        UIImageView *imageViewLine16 = [[UIImageView alloc]init];
        _imageViewLine16 = imageViewLine16;
        imageViewLine16.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine16];
        
        
        UIView *view5 = [[UIView alloc]init];
        _view5 = view5;
        [self.contentView addSubview:view5];
        
        UIImageView *imageViewLine17 = [[UIImageView alloc]init];
        _imageVIewLine17 = imageViewLine17;
        imageViewLine17.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine17];
        
        UILabel *typeLbael = [[UILabel alloc]init];
        _typeLbael = typeLbael;
        [self.contentView addSubview:typeLbael];
        
        //电话号码
        _view6 = [[UIView alloc]init];
        [self.contentView addSubview:_view6];
        
        
        _imageViewLine18 = [[UIImageView alloc]init];
        _imageViewLine18.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:_imageViewLine18];
        
        _iphoneLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_iphoneLabel];
        
        
        
        _imageViewLine19 = [[UIImageView alloc]init];
        _imageViewLine19.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:_imageViewLine19];
        
        //
    }
    return self;
}


-(void)setModel:(DetailInfoModel *)model{
    
    //物业Id
    if (model.property) {
        
        _property_id = model.property[@"objectId"];
        
    }else {
        
        _property_id = @"";
        
    }

    if (model.user) {
        
        NSDictionary *userDictionary = [StringChangeJson jsonDictionaryWithString:model.user];
        
        if (userDictionary[@"mobilePhoneNumber"]) {
            self.mobileNum = userDictionary[@"mobilePhoneNumber"];
        }else{
            self.mobileNum = @"";
        }
        
        if (userDictionary[@"device_token"]) {
            self.device_Token = userDictionary[@"device_token"];
        }else{
            self.device_Token = @"";
        }
        
        if (userDictionary[@"device_type"]) {
            self.owndevice_type = userDictionary[@"device_type"];
        }else{
            self.owndevice_type = @"";
        }
        
        if (userDictionary[@"objectId"]) {
            self.user_id = userDictionary[@"objectId"];
        }else{
            self.user_id = @"";
        }
        
    }

    
    NSArray *array = [model.address componentsSeparatedByString:@"&"];
    
    _addressLabel.text = [array firstObject];
    
    _detailAddressLabel.text = [array lastObject];

    _noDayLabel.font = UIFont(16);
    
    _noDayLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *noday = @"";
    
    for (NSString *string in model.no_hire) {
        
        NSString *str = [NSString stringWithFormat:@"%@,",string];
        
        noday = [noday stringByAppendingString:str];
        
    }
    
    _noDayLabel.textAlignment = NSTextAlignmentRight;
    
    _noDayLabel.text = noday;
    
    
    //时间
    if (self.hire_start && self.hire_end) {

        //NSString *startTime = [TimeChange timeChange:self.hire_start];
        NSArray *startArr = [self.hire_start componentsSeparatedByString:@" "];
        //NSString *endTime = [TimeChange timeChange:self.hire_end];
        NSArray *endArr = [self.hire_end componentsSeparatedByString:@" "];
        NSString *strings;
        if (frameX == 414.0) {
            strings = [NSString stringWithFormat:@"%@                                     %@",startArr[0],endArr[0]];
        }else if (frameX == 320.0){
            strings = [NSString stringWithFormat:@"%@                          %@",startArr[0],endArr[0]];
        }else if (frameX == 375.0){
            strings = [NSString stringWithFormat:@"%@                                    %@",startArr[0],endArr[0]];
        }
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel.text = strings;
    }

    //门禁描述
    if (model.gate_card) {
        [_gateCardLabel setNumberOfLines:0];
        NSString *string = [NSString stringWithFormat:@"门禁描述:%@",model.gate_card];
        _gateCardLabel.text = string;
        CGSize textSize=[string boundingRectWithSize:CGSizeMake(frameX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} context:nil].size;
        if (frameX == 320.0) {
            _gateCardLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine13.frame), frameX , textSize.height+10);
            _gateCardLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _gateCardLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine13.frame), frameX , textSize.height+15);
            _gateCardLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _gateCardLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine13.frame), frameX , textSize.height+18);
            _gateCardLabel.font = UIFont(16);
        }
        _imageViewLine14.frame = CGRectMake(0, CGRectGetMaxY(_gateCardLabel.frame),frameX,1);
    }else{
        _gateCardLabel.text = [NSString stringWithFormat:@"门禁信息:%@",@"暂无"];
        if (frameX == 320.0) {
            _gateCardLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine13.frame), frameX ,kWidth4s);
            _gateCardLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _gateCardLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine13.frame), frameX ,kWidth6);
            _gateCardLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _gateCardLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine13.frame), frameX ,kWidth6p);
            _gateCardLabel.font = UIFont(16);
        }
        _imageViewLine14.frame = CGRectMake(0, CGRectGetMaxY(_gateCardLabel.frame),frameX,1);
    }

    //道路描述
    if (model.park_description) {
        [_descritedLabel setNumberOfLines:0];
        NSString *string = [NSString stringWithFormat:@"道路描述:%@",model.park_description];
        _descritedLabel.text = string;
        CGSize descritedSize = [string boundingRectWithSize:CGSizeMake(frameX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine14.frame), frameX, descritedSize.height+10);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine14.frame), frameX, descritedSize.height+15);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine14.frame), frameX, descritedSize.height+18);
            _descritedLabel.font = UIFont(16);
        }
        _imageViewLine15.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame),frameX, 1);
    }else{
        _descritedLabel.text = [NSString stringWithFormat:@"车位描述:%@",@"暂无"];
        [_descritedLabel setNumberOfLines:0];
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine14.frame), frameX,kWidth4s);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine14.frame), frameX, kWidth6);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine14.frame), frameX,kWidth6p);
            _descritedLabel.font = UIFont(16);
        }
        _imageViewLine15.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame),frameX, 1);
    }

    //门禁 车位描述背景图
    _view4.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine13.frame),frameX, _gateCardLabel.frame.size.height+_descritedLabel.frame.size.height);
    
    //出租类型
    if (frameX == 320.0) {
        _imageViewLine16.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+13.6, frameX, 1);
    }else if (frameX == 375.0){
        _imageViewLine16.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+16.4, frameX, 1);
    }else if (frameX == 414.0){
        _imageViewLine16.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+17.7, frameX, 1);
    }
    
    _view5.backgroundColor = RGB(255, 255, 255);
    if (frameX == 320.0) {
        _view5.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth4s);
    }else if (frameX == 375.0){
        _view5.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6);
    }else if (frameX == 414.0){
        _view5.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6p);
    }
    
    if (frameX == 320.0) {
        _imageVIewLine17.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame)+kWidth4s, frameX, 1);
    }else if (frameX == 375.0){
        _imageVIewLine17.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame)+kWidth6, frameX, 1);
    }else if (frameX == 414.0){
        _imageVIewLine17.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame)+kWidth6p, frameX, 1);
    }
    
    if (frameX == 320.0) {
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth4s);
        _typeLbael.text = @"        类型                  时间           价格";
        _typeLbael.font = UIFont(15);
    }else if (frameX == 375.0){
        _typeLbael.text = @"         类型                       时间                   价格";
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6);
        _typeLbael.font = UIFont(15);
    }else if (frameX == 414.0){
        _typeLbael.text = @"     类型                                时间                       价格";
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6p);
        _typeLbael.font = UIFont(16);
    }
    
    if (model.park_height) {
        _heightLabel.text = [NSString stringWithFormat:@"%@",model.park_height];
        _heightLabel.textAlignment = NSTextAlignmentRight;
        _heightLabel.textColor = RGB(53, 53, 53);
    }
    if (model.park_area) {
        _arearLabel.text   = [NSString stringWithFormat:@"%@",model.park_area];
        _arearLabel.textAlignment = NSTextAlignmentRight;
        _arearLabel.textColor = RGB(53, 53, 53);
    }
    if (model.tail_num) {
        _numLabel.text = [NSString stringWithFormat:@"%@",model.tail_num];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.textColor = RGB(53, 53, 53);
    }

    
    _groundLabel.textColor = RGB(53, 53, 53);
    if ([[NSString stringWithFormat:@"%@",model.park_struct] isEqualToString:@"0"]) {
        _groundLabel.text = @"地上";
    }else{
        _groundLabel.text = @"地下";
    }
    _groundLabel.textAlignment = NSTextAlignmentRight;
    NSString *normalStr = [NSString stringWithFormat:@"%@",model.normal];
    _normalLabel.textColor = RGB(53, 53, 53);
    if ([normalStr isEqualToString:@"0"]) {
        _normalLabel.text = @"正规车位";
    }else{
        _normalLabel.text = @"非正规车位";
    }
    _normalLabel.textAlignment = NSTextAlignmentRight;
    
    //租用方式
    
    _priceArray = model.hire_price;
    NSString *string = model.hire_method;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    _methodArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //出租时间
    UILabel *timeLabel;
    //出租价格
    UILabel *priceLabel;
    
    //租用方式
    NSString *stringField = model.hire_method;
    NSData *dataField = [stringField dataUsingEncoding:NSUTF8StringEncoding];
    _methodArray = [NSJSONSerialization JSONObjectWithData:dataField options:NSJSONReadingMutableContainers error:nil];
    _fieldArray = [NSMutableArray array];
    for (NSDictionary *dic in _methodArray) {
        [_fieldArray addObject:dic[@"field"]];
    }
    
    for (int i = 0; i<_methodArray.count; i++) {
    
        if ([_methodArray[i][@"objectId"] isEqualToString:self.hire_method_id]) {
            
            _hire_filed_id = _fieldArray[i];
            
            UIView *views = [[UIView alloc]init];
            views.backgroundColor = [UIColor clearColor];
            _qradioButton = [[QRadioButton alloc]initWithDelegate:self groupId:@"groud"];
            [_qradioButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [_qradioButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [_qradioButton setChecked:YES];
            _typeLabel1 = [[UILabel alloc]init];
            UIImageView *imageViewLine = [[UIImageView alloc]init];
            UIView *view = [[UIView alloc]init];
            _typeLabel1.text = _methodArray[i][@"method"];
            if (frameX == 320.0) {
                _typeLabel1.font = UIFont(15);
                _typeLabel1.frame = CGRectMake(kGap4s, CGRectGetMaxY(_imageVIewLine17.frame)+1,90, kWidth4s);
                _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+1,30,30);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, 1);
                view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, kWidth4s);
                views.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+1,30,30);
            }else if (frameX == 375.0){
                _typeLabel1.font = UIFont(15);
                _typeLabel1.frame = CGRectMake(kGap6, CGRectGetMaxY(_imageVIewLine17.frame)+1,100, kWidth6);
                _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+2,35,35);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, 1);
                view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, kWidth6);
                views.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+2,35,35);
            }else if (frameX == 414.0){
                _typeLabel1.font = UIFont(16);
                _typeLabel1.frame = CGRectMake(kGap6p, CGRectGetMaxY(_imageVIewLine17.frame)+1,100, kWidth6p);
                _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+1,40,40);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, 1);
                view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+1,frameX, kWidth6p);
                views.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+1,40,40);
            }
            imageViewLine.image = [UIImage imageNamed:@"720@2x"];
            view.backgroundColor = RGB(255, 255, 255);
            [self.contentView addSubview:view];
            [self.contentView addSubview:imageViewLine];
            [self.contentView addSubview:_typeLabel1];
            //[self.contentView addSubview:_qradioButton];
            [self.contentView addSubview:views];
            
            //租用时间
            timeLabel = [[UILabel alloc]init];
            timeLabel.text = [NSString stringWithFormat:@"%@",model.hire_time[i]];
            timeLabel.textAlignment = NSTextAlignmentCenter;
            if (frameX == 320.0) {
                timeLabel.font = UIFont(15);
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame),CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,110,kWidth4s);
            }else if (frameX == 375.0){
                timeLabel.font = UIFont(15);
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+5,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,110,kWidth6);
            }else if (frameX == 414.0){
                timeLabel.font = UIFont(16);
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+28,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*i,120,kWidth6p);
            }
            [self.contentView addSubview:timeLabel];

            
            //租用价格
            priceLabel = [[UILabel alloc]init];
            priceLabel.text = [NSString stringWithFormat:@"%@",model.hire_price[i]];
            priceLabel.textAlignment = NSTextAlignmentCenter;
            if (frameX == 320.0) {
                priceLabel.font = UIFont(15);
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+10,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,80,kWidth4s);
            }else if (frameX == 375.0){
                priceLabel.font = UIFont(15);
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+5,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,90,kWidth6);
            }else if (frameX == 414.0){
                priceLabel.font = UIFont(16);
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+20,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*i,110,kWidth6p);
            }
            [self.contentView addSubview:priceLabel];

        }
        
    }
    
    _priceArray = model.hire_price;
    _unitPrice = [[NSString alloc]init];
    if ([self.push_type isEqualToString:@"verify_accept"]) {
        //查找租用价格
        for (int i = 0; i<_methodArray.count; i++) {
            if ([_methodArray[i][@"objectId" ] isEqualToString:self.hire_method_id]) {
                NSString *string = [NSString stringWithFormat:@"%d",i];
                _unitPrice = [NSString stringWithFormat:@"%@",_priceArray[i]];
                if ([_qradioButton.titleLabel.text isEqualToString:string]) {
                    _qradioButton.selected = YES;
                }else {
                    _qradioButton.selected = NO;
                }
            }
        }
    }


      if ([self.push_type isEqualToString:@"verify_accept"]) {
    
      _imageViewLine18.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame)+kGap4s, frameX, 1);
      _view6.backgroundColor = [UIColor whiteColor];
      if (frameX == 320.0) {
          _view6.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine18.frame),frameX, kWidth4s);
          _iphoneLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine18.frame),150,kWidth4s);
      }else if (frameX == 375.0){
          _view6.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine18.frame),frameX, kWidth6);
          _iphoneLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine18.frame),150,kWidth6);
      }else{
          _view6.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine18.frame),frameX, kWidth6p);
          _iphoneLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine18.frame),150,kWidth6p);
      }
      
      NSDictionary *user = [StringChangeJson jsonDictionaryWithString:model.user];
      _iphoneLabel.text = user[@"mobilePhoneNumber"];
          
      _imageViewLine19.frame = CGRectMake(0, CGRectGetMaxY(_view6.frame), frameX, 1);
      
      UIButton *iphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      if (frameX == 320.0) {
          iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_imageViewLine18.frame),180,kWidth4s);
          iphoneBtn.titleLabel.font = UIFont(15);
          _iphoneLabel.font = UIFont(15);
      }else if (frameX == 375.0){
          iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_imageViewLine18.frame),180,kWidth6);
           iphoneBtn.titleLabel.font = UIFont(15);
          _iphoneLabel.font = UIFont(15);
      }else{
          iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_imageViewLine18.frame),180,kWidth6p);
           iphoneBtn.titleLabel.font = UIFont(16);
          _iphoneLabel.font = UIFont(16);
      }
      [iphoneBtn addTarget:self action:@selector(callMobile:) forControlEvents:UIControlEventTouchUpInside];
    
      [iphoneBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
      if (frameX == 414.0) {
          iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-255);
      }else if (frameX == 375.0){
          iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-185);
      }else if(frameX == 320.0){
          iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-85);
      }
      [self.contentView addSubview:iphoneBtn];
        
            UILabel *priceLabel = [[UILabel alloc]init];
            UIView *view = [[UIView alloc]init];
            if (frameX == 320.0) {
                priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine19.frame), frameX - kGap4s, kWidth4s);
                priceLabel.font = UIFont(15);
                view.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine19.frame), frameX, kWidth4s);
            }else if (frameX == 375.0){
                priceLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(_imageViewLine19.frame), frameX - kGap6, kWidth6);
                priceLabel.font = UIFont(15);
                view.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine19.frame), frameX, kWidth6);
            }else if (frameX == 414.0){
                priceLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(_imageViewLine19.frame), frameX - kGap6p, kWidth6p);
                priceLabel.font = UIFont(16);
                view.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine19.frame), frameX, kWidth6p);
            }
            if (self.price) {
                priceLabel.text = [NSString stringWithFormat:@"总价:%@",self.price];
            }
            view.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:view];
            [self.contentView addSubview:priceLabel];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(priceLabel.frame),frameX, 1)];
            imageView.image =[ UIImage imageNamed:@"720"];
            [self.contentView addSubview:imageView];
          
          
            if (![self.trade_state isEqualToString:@"1"]) {
                
                if ( ![[NSString stringWithFormat:@"%@",model.park_space] isEqualToString:@"0"]) {
                    UIButton *payButton = [UIButton buttonWithFrame:CGRectMake(50.4,CGRectGetMaxY(priceLabel.frame)+20, frameX - 2*50.4, 40) type:UIButtonTypeCustom title:@"支付" target:self action:@selector(payButtonClick:)];
                    payButton.backgroundColor = RGB(254, 156, 0);
                    [payButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                    payButton.layer.masksToBounds = YES;
                    payButton.layer.cornerRadius = 20.0;
                    [self.contentView addSubview:payButton];
                }else{
                    UIButton *payButton  = [UIButton buttonWithType:UIButtonTypeCustom];
                    payButton.frame = CGRectMake(50.4,CGRectGetMaxY(priceLabel.frame)+20, frameX - 2*50.4, 40);
                    [payButton setTitle:@"此车位已被租用" forState:UIControlStateNormal];
                    payButton.backgroundColor = RGB(254, 156, 0);
                    [payButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                    payButton.layer.masksToBounds = YES;
                    payButton.layer.cornerRadius = 20.0;
                    payButton.selected = NO;
                    [self.contentView addSubview:payButton];
                }
            }else{
                if ([[NSString stringWithFormat:@"%@",model.park_space] isEqualToString:@"0"]) {
                    UIButton *payButton  = [UIButton buttonWithType:UIButtonTypeCustom];
                    payButton.frame = CGRectMake(50.4,CGRectGetMaxY(priceLabel.frame)+20, frameX - 2*50.4, 40);
                    [payButton setTitle:@"此车位已被租用" forState:UIControlStateNormal];
                    payButton.backgroundColor = RGB(254, 156, 0);
                    [payButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                    payButton.layer.masksToBounds = YES;
                    payButton.layer.cornerRadius = 20.0;
                    payButton.selected = NO;
                    [self.contentView addSubview:payButton];
                }
            }

            if (self.tradeItem) {
                UIView *view =[[ UIView alloc]initWithFrame:CGRectMake(50.4, CGRectGetMaxY(priceLabel.frame)+20, frameX - 2*50.4,40)];
                [self.contentView addSubview:view];
            }
        
    }else if ([self.push_type isEqualToString:@"verify_request"]){
        
        UIImageView *imageView = [[UIImageView alloc]init];
        UIImageView *imageView1 = [[UIImageView alloc]init];
        UIView *view =[[ UIView alloc]init];
        if (frameX == 320.0) {
            imageView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame)+5, frameX,1);
            view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth4s);
            imageView1.frame = CGRectMake(0, CGRectGetMaxY(view.frame), frameX,1);
        }else if (frameX == 375.0){
             imageView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame)+5, frameX,1);
             view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth6);
            imageView1.frame = CGRectMake(0, CGRectGetMaxY(view.frame), frameX,1);
        }else if (frameX == 414.0){
             imageView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame)+5, frameX,1);
             view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth6p);
             imageView1.frame = CGRectMake(0, CGRectGetMaxY(view.frame), frameX,1);
        }
        
        view.backgroundColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:@"720"];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:view];
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:imageView1];
        
        
        UILabel *priceLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageView.frame),frameX - 2*kGap4s,kWidth4s);
            priceLabel.font = UIFont(15);
        }else if(frameX == 375.0) {
            priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(imageView.frame),frameX - 2*kGap6,kWidth6);
             priceLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageView.frame),frameX - 2*kGap6p, kWidth6p);
             priceLabel.font = UIFont(16);
        }
        if ([self.hire_method_id isEqualToString:@"56373f1100b0ee7f5ee8355c"]) {
            priceLabel.text = [NSString stringWithFormat:@"定金: %@",self.price];
        }else{
            priceLabel.text = [NSString stringWithFormat:@"总价: %@",self.price];
        }
        [self.contentView addSubview:priceLabel];
        
        NSArray *array = @[@"同意出租",@"拒绝出租"];
        for (int i = 0; i<array.count; i++) {
            UIButton *didHireButton = [UIButton buttonWithFrame:CGRectMake(20+((frameX - 60)/2+20)*i,CGRectGetMaxY(view.frame)+40,(frameX - 60)/2, 40) type:UIButtonTypeCustom title:nil target:self action:@selector(didHire:)];
            [didHireButton setTitle:array[i] forState:UIControlStateNormal];
            didHireButton.backgroundColor = RGB(254, 156, 0);
            [didHireButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            didHireButton.layer.masksToBounds = YES;
            didHireButton.layer.cornerRadius = 20.0;
            didHireButton.tag = 100+i;
            [self.contentView addSubview:didHireButton];
            
        }
    }
}

//打电话
- (void)callMobile:(UIButton *)btn{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_iphoneLabel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.contentView addSubview:callWebview];
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    int method = [radio.titleLabel.text intValue];
    _method = _methodArray[method][@"objectId"];
    //_unitPrice = _priceArray[method];
}


- (void)didHire:(UIButton *)btn{
    switch (btn.tag - 100) {
        case 0:
        {
            //[self getAccept];
            
            [self insertJPushMessage];
        }
            break;
        case 1:
        {
            
         NSDictionary *dictionary;
            
         if ([self.pushMessage isEqualToString:@"pushMessage"]) {
             dictionary   = @{@"mobilePhoneNumber":@"",@"push_type":@"verify_reject",@"device_token":@"",@"device_type":@"",@"user_id":[StringChangeJson getValueForKey:kUser_id],@"extras":@{@"push_type":@"verify_reject"}};
         }else{
            dictionary= @{@"mobilePhoneNumber":self.own_mobile,@"push_type":@"verify_reject",@"device_token":self.device_token,@"device_type":self.device_type,@"user_id":[StringChangeJson getValueForKey:kUser_id],@"extras":@{@"push_type":@"verify_reject"}};
         }
    
         _jpushRequest  = [[KongCVHttpRequest alloc]initWithRequests:kToJPushUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
             
             UIAlertView *alertVIew = [[UIAlertView alloc]initWithTitle:nil message:@"您拒绝了对方的租用请求" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             [alertVIew show];
             
         }];
         
            //改变消息状态
            NSDictionary *dictionarys = @{@"message_id":self.message_id,@"state":@2};
            _changeMessRequest = [[KongCVHttpRequest alloc]initWithRequests:kChangeMessageUrl sessionToken:nil dictionary:dictionarys andBlock:^(NSDictionary *data) {
             
           }];
            
            
            UIViewController *control = [self getCurrentVC];
            
            [control dismissViewControllerAnimated:YES completion:nil];
         
        }
            break;
            
        default:
            break;
    }

}

//插入通知接受数据
- (void)insertJPushMessage{
    
    if ([StringChangeJson getValueForKey:kMobelNum]  && [StringChangeJson getValueForKey:kUser_id]) {
        
        NSDictionary *acceptDic = @{@"req_mobile":[StringChangeJson getValueForKey:kMobelNum],
                                    @"user_mobile":self.own_mobile,
                                    @"park_id":self.park_id,
                                    @"mode":self.mode
                                    };
        
        _insertRequest = [[KongCVHttpRequest alloc]initWithRequests:kInsertAccept sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:acceptDic andBlock:^(NSDictionary *data) {
            
            NSString *string = data[@"result"];
            
            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:string];
            
            if ([dic[@"msg"] isEqualToString:@"成功"]) {
                
                [self pushMessages];
                
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:dic[@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertView show];
                
            }
            
            
        }];

    }
    
}

//发送jPush通知
- (void)pushMessages{
    if ([StringChangeJson getValueForKey:kUser_id] && [StringChangeJson getValueForKey:kMobelNum]) {
        //发送通知  同意出租
        NSDictionary *extras = @{@"park_id":self.park_id,
                                                        @"hire_method_id":self.hire_method_id,
                                                        @"own_device_token":[StringChangeJson getValueForKey:kRegistationID],
                                                        @"own_device_type":@"ios",
                                                        @"own_mobile":[StringChangeJson getValueForKey:kMobelNum],
                                                        @"hire_start":[NSString stringWithFormat:@"%@",self.hire_start],
                                                        @"hire_end":[NSString stringWithFormat:@"%@",self.hire_end],
                                                        @"push_type":@"verify_accept",
                                                        @"address":_addressLabel.text,
                                                        @"mode":self.mode,
                                                        @"price":self.price,
                                                        @"hire_method_field":self.hire_filed_id};

        NSDictionary *dictionary;
        if (self.device_token && self.own_mobile && self.device_type ) {
            
            dictionary = @{@"mobilePhoneNumber":self.own_mobile,
                                         @"push_type":@"verify_accept",
                                         @"device_token":self.device_token,
                                         @"device_type":self.device_type,
                                         @"user_id":[StringChangeJson getValueForKey:kUser_id],
                                         @"extras":extras};
            
        }else{
            dictionary = @{ @"mobilePhoneNumber":@"",
                                         @"push_type":@"verify_accept",
                                         @"device_token":@"",
                                         @"device_type":@"",
                                         @"user_id":[StringChangeJson getValueForKey:kUser_id],@"extras":extras};
        }
        
        
        if ([self.device_type isEqualToString:@"web"]  || [self.device_token isEqualToString:@"web"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您同意了对方的租用请求" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
            
        }else{
            _jpushRequest  = [[KongCVHttpRequest alloc]initWithRequests:kToJPushUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
                
                UIAlertView *alertVIew = [[UIAlertView alloc]initWithTitle:nil message:@"您同意了对方的租用请求" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alertVIew show];
                
            }];
            
        }
        
        
        //改变消息状态
        NSDictionary *dictionarys = @{@"message_id":self.message_id,
                                                                  @"state":@1};
        
        _changeMessRequest = [[KongCVHttpRequest alloc]initWithRequests:kChangeMessageUrl sessionToken:nil dictionary:dictionarys andBlock:^(NSDictionary *data) {
        
            
        }];
        
        
        UIViewController *control = [self getCurrentVC];
        
        [control dismissViewControllerAnimated:YES completion:nil];

    }
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//getAccept
- (void)getAccept{
    
    NSDictionary *dictionary =  @{@"user_mobile":self.own_mobile,
                                                             @"park_id":self.park_id,
                                                             @"mode":@"community"};

    _acceptRequest = [[KongCVHttpRequest alloc]initWithRequests:kFindHire sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {

    }];
}

//支付
- (void)payButtonClick:(UIButton *)btn{
    
    NSString *string;
    
    if (self.hire_start && self.hire_end) {
        
        NSArray *startArr  = [self.hire_start componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
        NSArray *endArr  = [self.hire_end componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
        
        NSString *timeS = [NSString stringWithFormat:@"%@年%@月%@日",[startArr firstObject],startArr[1],startArr[2]];
        NSString *timeE = [NSString stringWithFormat:@"%@年%@月%@日",[endArr firstObject],endArr[1],endArr[2]];
        
        NSNumber *number;
        if (!self.tradePrice) {
            //        NSArray *startArr  = [self.hire_start componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
            //        NSArray *endArr  = [self.hire_end componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
            //        NSString *timeS = [NSString stringWithFormat:@"%@年%@月%@日",[startArr firstObject],startArr[1],startArr[2]];
            //        NSString *timeE = [NSString stringWithFormat:@"%@年%@月%@日",[endArr firstObject],endArr[1],endArr[2]];
            CalculateUnit *day = [[CalculateUnit alloc]init];
            number =  [day calculateMoneyWithStartTime:timeS endTime:timeE andNoDays:_noDayLabel.text andPrice:_unitPrice];
            string = day.string;
            
        }else{
            CalculateUnit *day = [[CalculateUnit alloc]init];
            NSNumber *numbers =  [day calculateMoneyWithStartTime:timeS endTime:timeE andNoDays:_noDayLabel.text andPrice:_unitPrice];
            string = day.string;
            number = [NSNumber numberWithInt:[self.price intValue]];
        }
        
    }else{
    
        string = @"";
    }
    


    //NSLog(@"%@---%@----%@",self.mobileNum,self.owndevice_type,self.device_Token);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"payButtonClick" object:nil userInfo:@{@"day":[NSString stringWithFormat:@"%@",string],@"hirer_id":self.user_id,@"price":self.price,@"unit_price":_unitPrice,@"property":_property_id,@"mobile":self.mobileNum,@"type":self.owndevice_type,@"token":self.device_Token}];
}
@end
