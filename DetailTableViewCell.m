//
//  DetailTableViewCell.m
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "QRadioButton.h"
#import "CalculateUnit.h"
#import "CalendarViewController.h"
#import "CalendarHomeViewController.h"
#import "TimeChange.h"
#import "LoginViewController.h"
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3
@interface DetailTableViewCell ()
@property(nonatomic,strong) KongCVHttpRequest *jpushRequest;
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
@property(nonatomic,strong) NSNumber *priceNum;
@property(nonatomic,strong) NSArray *priceArray;
@property(nonatomic,assign) int methods;
@property(nonatomic,strong) UIButton *startBtn;
@property(nonatomic,strong) UIButton *endBtn;
@property(nonatomic,strong) UIView    *views;
@property(nonatomic,strong) QRadioButton *qradioButton;
@property(nonatomic,copy)   NSString *mobileNum;
@property(nonatomic,copy)   NSString *device_token;
@property(nonatomic,copy)   NSString *device_type;
@property(nonatomic,copy)   NSString *user_id;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UIImageView *imageViewLine;

@property(nonatomic,strong) NSMutableArray *fieldArray;
@property(nonatomic,copy)   NSString *hire_field;
@property(nonatomic,copy)   NSString *iphoneString;

@end
@implementation DetailTableViewCell

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
            adressImage.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageViewLine1.frame)+8.65,20,25);
        }
        [self.contentView addSubview:adressImage];
        
        //地址信息
        _addressLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
          _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, 5.6 , frameX-adressImage.frame.size.width,kWidth4s);
        }else if (frameX == 375.0){
         _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5, 6.3 , frameX-adressImage.frame.size.width,kWidth6);
        }else if (frameX == 414.0){
         _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,6.6, frameX-adressImage.frame.size.width,kWidth6p);
        }
        [self.contentView addSubview:_addressLabel];
        
       //详细地址信息
        _detailAddressLabel = [[UILabel alloc]init];
        UIView *detailView = [[UIView alloc]init];
        if (frameX == 320.0) {
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, CGRectGetMaxY(imageViewLine2.frame) , frameX,kWidth4s);
            detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX,kWidth4s);
        }else if (frameX == 375.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5,CGRectGetMaxY(imageViewLine2.frame), frameX,kWidth6);
            detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX,kWidth6);
        }else if (frameX == 414.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,CGRectGetMaxY(imageViewLine2.frame), frameX,kWidth6p);
            detailView.frame = CGRectMake(0,CGRectGetMaxY(imageViewLine2.frame),frameX,kWidth6p);
        }
        detailView.backgroundColor =[ UIColor whiteColor];
        [self.contentView addSubview:detailView];
        [self.contentView addSubview:_detailAddressLabel];
        UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_detailAddressLabel.frame),frameX,1)];
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
            startImageView.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+10, CGRectGetMaxY(imageViewLine3.frame)+12,22,22);
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
           endImageView.frame = CGRectMake(CGRectGetMaxX(startLabel.frame)+125, CGRectGetMaxY(imageViewLine3.frame)+12,22,22);
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
        }else if (frameX == 375.0){
            _timeLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(startImageView.frame)+8,frameX - 2*kGap6, 32);
        }else if (frameX == 414.0){
            _timeLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(startImageView.frame)+8,frameX - 2*kGap6p, 32);
        }
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = RGB(53, 53, 53);
        [self.contentView addSubview:_timeLabel];
        
        //选择起始日期
        UIImageView *chooseImageLine1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageViewLine4.frame)+15.4,frameX, 1)];
        chooseImageLine1.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:chooseImageLine1];
        
        UIView *chooseView = [[UIView alloc]init];
        if (frameX == 320.0) {
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(chooseImageLine1.frame), frameX, kWidth4s*2);
        }else if (frameX == 375.0){
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(chooseImageLine1.frame), frameX, kWidth6*2);
        }else{
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(chooseImageLine1.frame), frameX, kWidth6p);
        }
        chooseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:chooseView];
        
        UILabel *hireStartTime = [[UILabel alloc]init];
        if (frameX == 320.0) {
            hireStartTime.frame = CGRectMake(kGap4s,CGRectGetMaxY(chooseImageLine1.frame),150,kWidth4s);
        }else if (frameX == 375.0){
            hireStartTime.frame = CGRectMake(kGap6,CGRectGetMaxY(chooseImageLine1.frame),150,kWidth6);
        }else{
            hireStartTime.frame = CGRectMake(kGap6p,CGRectGetMaxY(chooseImageLine1.frame),150,kWidth6p);
        }
        hireStartTime.text = @"租用起始时间";
        hireStartTime.font = UIFont(15);
        [self.contentView addSubview:hireStartTime];

        if (frameX == 320.0) {
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(chooseImageLine1.frame),frameX - 150-kGap4s,kWidth4s) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 23, 0, 0);
        }else if (frameX == 375.0){
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(chooseImageLine1.frame),frameX - 150-kGap6,kWidth6) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        }else{
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(chooseImageLine1.frame),frameX - 150-kGap6p,kWidth6p) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _startBtn.titleEdgeInsets = UIEdgeInsetsMake(0,92, 0,0);
        }
        _startBtn.titleLabel.font = UIFont(15);
        _startBtn.titleLabel.textColor = RGB(53, 53, 53);
        [self.contentView addSubview:_startBtn];
       
        //租用结束时间
        UIView *chooseView1 = [[UIView alloc]init];
        if (frameX == 320.0) {
            chooseView1.frame = CGRectMake(0, CGRectGetMaxY(_startBtn.frame), frameX, kWidth4s*2);
        }else if (frameX == 375.0){
            chooseView1.frame = CGRectMake(0, CGRectGetMaxY(_startBtn.frame), frameX, kWidth6*2);
        }else{
            chooseView1.frame = CGRectMake(0, CGRectGetMaxY(_startBtn.frame), frameX, kWidth6p);
        }
        chooseView1.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:chooseView1];
        
        UILabel *endStartLabel = [[UILabel alloc]init];
        if (frameX == 320.0) {
            endStartLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(hireStartTime.frame),150,kWidth4s);
        }else if (frameX == 375.0){
            endStartLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(hireStartTime.frame),150,kWidth6);
        }else {
            endStartLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(hireStartTime.frame),150,kWidth6p);
        }
        endStartLabel.text = @"租用结束时间";
        endStartLabel.font = UIFont(15);
        [self.contentView addSubview:endStartLabel];
        
        if (frameX == 320.0) {
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth4s) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseEndDayClick:)];
            [_endBtn setTitleColor:RGB(53, 53, 53) forState:UIControlStateNormal];
            _endBtn.titleEdgeInsets = UIEdgeInsetsMake(0,23, 0, 0);
        }else if (frameX == 375.0){
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth6) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseEndDayClick:)];
            _endBtn.titleEdgeInsets = UIEdgeInsetsMake(0,60, 0, 0);
        }else{
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth6p) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseEndDayClick:)];
            _endBtn.titleEdgeInsets = UIEdgeInsetsMake(0,90, 0, 0);
        }
        _endBtn.titleLabel.font = UIFont(15);
        _endBtn.titleLabel.textColor = RGB(53, 53, 53);
        [self.contentView addSubview:_endBtn];
        
        //非出租日/周
        UIImageView *imageViewLine5 = [[UIImageView alloc]init];
        if (frameX == 320.0) {
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(endStartLabel.frame), frameX, 1);
        }else if (frameX == 375.0){
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(endStartLabel.frame), frameX, 1);
        }else if (frameX == 414.0){
            imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(endStartLabel.frame), frameX, 1);
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
        _noDayLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            noLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth4s);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap4s*2, kWidth4s);
        }else if (frameX == 375.0){
            noLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth6);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap6*2, kWidth6);
        }else if (frameX == 414.0){
            noLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageViewLine5.frame), 100, kWidth6p);
            _noDayLabel.frame = CGRectMake(CGRectGetMaxX(noLabel.frame), CGRectGetMaxY(imageViewLine5.frame),frameX - noLabel.frame.size.width - kGap6p*2, kWidth6p);
        }
        noLabel.text = @"非出租日/周";
        noLabel.font = UIFont(15);
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
        _arearLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            arealabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth4s);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap4s*2- arealabel.frame.size.width, kWidth4s);
        }else if (frameX == 375.0){
            arealabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth6);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap6*2 - arealabel.frame.size.width, kWidth6);
        }else if (frameX == 414.0){
            arealabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine6.frame), 100, kWidth6p);
            _arearLabel.frame = CGRectMake(CGRectGetMaxX(arealabel.frame), CGRectGetMaxY(imageViewLine6.frame), frameX - kGap6p*2 - arealabel.frame.size.width, kWidth6p);
        }
        arealabel.text = @"车位面积";
        arealabel.font = UIFont(15);
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
        _heightLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            height.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth4s);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap4s*2, kWidth4s);
        }else if (frameX == 375.0){
            height.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth6);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap6*2, kWidth6);
        }else if (frameX == 414.0){
            height.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine7.frame), 100, kWidth6p);
            _heightLabel.frame = CGRectMake(CGRectGetMaxX(height.frame),CGRectGetMaxY(imageViewLine7.frame), frameX - height.frame.size.width - kGap6p*2, kWidth6p);
        }
        height.text = @"车位限高";
        height.font = UIFont(15);
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
        _numLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            numlabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth4s);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap4s*2, kWidth4s);
        }else if (frameX == 375.0){
            numlabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth6);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap6*2, kWidth6);
        }else if (frameX == 414.0){
            numlabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine8.frame), 120, kWidth6p);
            _numLabel.frame = CGRectMake(CGRectGetMaxX(numlabel.frame), CGRectGetMaxY(imageViewLine8.frame), frameX - numlabel.frame.size.width - kGap6p*2, kWidth6p);
        }
        numlabel.text = @"车牌尾号";
        numlabel.font = UIFont(15);
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
        _normalLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            norLabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth4s);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap4s*2, kWidth4s);
        }else if (frameX == 375.0){
            norLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth6);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap6*2, kWidth6);
        }else if (frameX == 414.0){
            norLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine10.frame), 120, kWidth6p);
            _normalLabel.frame = CGRectMake(CGRectGetMaxX(norLabel.frame), CGRectGetMaxY(imageViewLine10.frame), frameX - norLabel.frame.size.width-kGap6p*2, kWidth6p);
        }
        norLabel.text = @"是否是正规车位";
        norLabel.font = UIFont(15);
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
        _groundLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            grLabel.frame = CGRectMake(kGap4s, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth4s);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap4s*2, kWidth4s);
        }else if (frameX == 375.0){
            grLabel.frame = CGRectMake(kGap6, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth6);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap6*2, kWidth6);
        }else if (frameX == 414.0){
            grLabel.frame = CGRectMake(kGap6p, CGRectGetMaxY(imageViewLine11.frame), 100, kWidth6p);
            _groundLabel.frame = CGRectMake(CGRectGetMaxX(grLabel.frame), CGRectGetMaxY(imageViewLine11.frame), frameX - grLabel.frame.size.width-kGap6p*2, kWidth6p);
        }
        grLabel.text = @"地上地下";
        grLabel.font = UIFont(15);
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
        _gateCardLabel.font = UIFont(15);
        _gateCardLabel.textColor = RGB(53, 53, 53);
        [self.contentView addSubview:_gateCardLabel];
        
        //车位描述
        UIImageView *imageViewLine14 = [[UIImageView alloc]init];
        _imageViewLine14 = imageViewLine14;
        imageViewLine14.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine14];
        
        _descritedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _descritedLabel.font = UIFont(15);
        _descritedLabel.textColor = RGB(53, 53, 53);
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
        _iphoneLabel.font = UIFont(15);
        _iphoneLabel.textColor = RGB(53, 53, 53);
        [self.contentView addSubview:_iphoneLabel];
        
    
        _imageViewLine19 = [[UIImageView alloc]init];
        _imageViewLine19.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:_imageViewLine19];
        
    }
    return self;
}


-(void)setModel:(DetailInfoModel *)model{
    
    if (model.address) {
        _addressLabel.text = [[model.address componentsSeparatedByString:@"&"] firstObject];
        _addressLabel.font = UIFont(16);
        _detailAddressLabel.text = [[model.address componentsSeparatedByString:@"&"] lastObject];
        _detailAddressLabel.font = UIFont(15);
    }

    if (model.user) {
        
        NSDictionary *userDictionary = [StringChangeJson jsonDictionaryWithString:model.user];
        
        if (userDictionary[@"mobilePhoneNumber"]) {
            self.mobileNum = userDictionary[@"mobilePhoneNumber"];  //出租人的电话
        }else{
            self.mobileNum = @"";
        }
        
        if (userDictionary[@"device_token"]) {
            self.device_token = userDictionary[@"device_token"];//出租人的RegisterId
        }else{
            self.device_token = @"web";
        }
        
        if (userDictionary[@"device_type"]) {
            self.device_type = userDictionary[@"device_type"];//出租人的设备类型
        }else{
            self.device_type = @"web";
        }
        
        if (userDictionary[@"objectId"]) {
            self.user_id = userDictionary[@"objectId"];//出租人的UserId
        }else{
            self.user_id = @"";
        }
        
    }

    //非出租日
    _noDayLabel.font = UIFont(14);
    _noDayLabel.textAlignment = NSTextAlignmentCenter;
    NSString *noday = @"";
    if (model.no_hire) {
        for (NSString *string in model.no_hire) {
            NSString *str = [NSString stringWithFormat:@"%@,",string];
            noday = [noday stringByAppendingString:str];
        }
        _noDayLabel.textAlignment = NSTextAlignmentRight;
        _noDayLabel.text = noday;
    }

    //时间
    NSArray *startArr;
    if (model.hire_start ) {
        NSDictionary *dic = model.hire_start;
        NSString *startTime = [TimeChange timeChange:dic[@"iso"]];
        startArr = [startTime componentsSeparatedByString:@" "];
    }

    NSArray *endArr;
    if (model.hire_end) {
        NSDictionary *dit   = model.hire_end;
        NSString *endTime = [TimeChange timeChange:dit[@"iso"]];
        endArr = [endTime componentsSeparatedByString:@" "];
    }
    NSString *strings;
    if (frameX==320.0) {
        strings = [NSString stringWithFormat:@"%@                         %@",startArr[0],endArr[0]];
    }else if (frameX == 375.0){
        strings = [NSString stringWithFormat:@"%@                                   %@",startArr[0],endArr[0]];
    }else if (frameX == 414.0){
        strings = [NSString stringWithFormat:@"%@                                         %@",startArr[0],endArr[0]];
    }
    _timeLabel.font = UIFont(15);
    _timeLabel.text = strings;

    
    //门禁描述
    if (model.gate_card) {
        _gateCardLabel.text = [NSString stringWithFormat:@"门禁信息:%@",model.gate_card];
        _gateCardLabel.textColor = RGB(53, 53, 53);
        [_gateCardLabel setNumberOfLines:0];
        CGSize textSize=[model.gate_card boundingRectWithSize:CGSizeMake(frameX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19]} context:nil].size;
        
        if (frameX == 320.0) {
            _gateCardLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap4s , textSize.height+10);
        }else if (frameX == 375.0){
            _gateCardLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap6 , textSize.height+10);
        }else if (frameX == 414.0){
            _gateCardLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap6p , textSize.height+10);
        }
        
        _imageViewLine14.frame = CGRectMake(0, CGRectGetMaxY(_gateCardLabel.frame),frameX,1);
    }else{
        _gateCardLabel.text = [NSString stringWithFormat:@"门禁信息:%@",@"暂无"];
        if (frameX == 320.0) {
            _gateCardLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap4s ,kWidth4s);
        }else if (frameX == 375.0){
            _gateCardLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap6 ,kWidth6);
        }else if (frameX == 414.0){
            _gateCardLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine13.frame), frameX-kGap6p ,kWidth6p);
        }
        
        _imageViewLine14.frame = CGRectMake(0, CGRectGetMaxY(_gateCardLabel.frame),frameX,1);
    }

    //道路描述
    if (model.park_description.length != 0) {
        _descritedLabel.text = [NSString stringWithFormat:@"车位描述:%@",model.park_description];
        [_descritedLabel setNumberOfLines:0];
        _descritedLabel.textColor = RGB(53, 53, 53);
        CGSize descritedSize = [model.park_description boundingRectWithSize:CGSizeMake(frameX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap4s, descritedSize.height+10);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap6, descritedSize.height+10);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap6p, descritedSize.height+10);
        }
         _imageViewLine15.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame),frameX, 1);
    }else{
        _descritedLabel.text = [NSString stringWithFormat:@"车位描述:%@",@"暂无"];
        [_descritedLabel setNumberOfLines:0];
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap4s,kWidth4s);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap6, kWidth6);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine14.frame), frameX-kGap6p,kWidth6p);
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
    
    _typeLbael.font = UIFont(15);
    if (frameX == 320.0) {
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth4s);
        _typeLbael.text = @"     类型                   时间               价格";
    }else if (frameX == 375.0){
        _typeLbael.text = @"     类型                              时间                   价格";
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6);
    }else if (frameX == 414.0){
        _typeLbael.text = @"     类型                                时间                       价格";
        _typeLbael.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine16.frame), frameX, kWidth6p);
    }

    if (model.park_height) {
        _heightLabel.text = [NSString stringWithFormat:@"%@",model.park_height];
        _heightLabel.textAlignment = NSTextAlignmentRight;
        _heightLabel.textColor = RGB(53, 53, 53);
        _heightLabel.font = UIFont(15);
    }
    if (model.park_area) {
        _arearLabel.text   = [NSString stringWithFormat:@"%@",model.park_area];
        _arearLabel.textAlignment   = NSTextAlignmentRight;
        _arearLabel.textColor = RGB(53, 53, 53);
        _arearLabel.font = UIFont(15);
    }
    if (model.tail_num) {
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.text = [NSString stringWithFormat:@"%@",model.tail_num];
        _numLabel.textColor = RGB(53, 53, 53);
        _numLabel.font = UIFont(15);
    }
    
    //NSLog(@"%@",model.park_struct);
    if (model.park_struct) {
        _groundLabel.textAlignment = NSTextAlignmentRight;
        _groundLabel.textColor = RGB(53, 53, 53);
        _groundLabel.font = UIFont(15);
        if ([[NSString stringWithFormat:@"%@",model.park_struct] isEqualToString:@"0"]) {
            _groundLabel.text = @"地上";
        }else{
            _groundLabel.text = @"地下";
        }
    }

    if (model.normal) {
        NSString *normalStr = [NSString stringWithFormat:@"%@",model.normal];
        _normalLabel.textAlignment = NSTextAlignmentRight;
        _normalLabel.textColor = RGB(53, 53, 53);
        _normalLabel.font = UIFont(15);
        if ([normalStr isEqualToString:@"0"]) {
            _normalLabel.text = @"正规车位";
        }else{
            _normalLabel.text = @"非正规车位";
        }
    }

    //租用方式
      NSString *string = model.hire_method;
      NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
     _methodArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _fieldArray = [NSMutableArray array];
    for (NSDictionary *dic in _methodArray) {
        [_fieldArray addObject:dic[@"field"]];
    }
    //_fieldArray = _methodArray[@"field"];
    for (int i = 0; i<_methodArray.count; i++) {
        _qradioButton = [[QRadioButton alloc]initWithDelegate:self groupId:@"groud"];
        [_qradioButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [_qradioButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [_qradioButton setChecked:NO];
        _typeLabel1 = [[UILabel alloc]init];
        
        UIImageView *imageViewLine = [[UIImageView alloc]init];
        _imageViewLine = imageViewLine;
        UIView *view = [[UIView alloc]init];
        _typeLabel1.text = _methodArray[i][@"method"];
        if (frameX == 320.0) {
            _typeLabel1.font = UIFont(15);
            _typeLabel1.frame = CGRectMake(kGap4s, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,90, kWidth4s);
            _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,30,30);
            imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*(i+1),frameX, 1);
            view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,frameX, kWidth4s);
        }else if (frameX == 375.0){
            _typeLabel1.font = UIFont(15);
            _typeLabel1.frame = CGRectMake(kGap6, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,100, kWidth6);
            _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+2)*i,35,35);
            imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*(i+1),frameX, 1);
            view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,frameX, kWidth6);
        }else if (frameX == 414.0){
            _typeLabel1.font = UIFont(16);
            _typeLabel1.frame = CGRectMake(kGap6p, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p)*i,100, kWidth6p);
            _qradioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p)*i,40,40);
            imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*(i+1),frameX, 1);
            view.frame = CGRectMake(0, CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*i,frameX, kWidth6p);
        }
        imageViewLine.image = [UIImage imageNamed:@"720@2x"];
        view.backgroundColor = RGB(255, 255, 255);
        [self.contentView addSubview:view];
        [self.contentView addSubview:imageViewLine];
        [self.contentView addSubview:_typeLabel1];
        [self.contentView addSubview:_qradioButton];
        
    }


    
    //出租时间
    UILabel *timeLabel;
    for (int i = 0; i<model.hire_time.count; i++) {
             timeLabel = [[UILabel alloc]init];
             timeLabel.text = [NSString stringWithFormat:@"%@",model.hire_time[i]];
             timeLabel.textAlignment = NSTextAlignmentCenter;
             timeLabel.font = UIFont(15);
             if (frameX == 320.0) {
                 timeLabel.font = UIFont(15);
                 timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame),CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,100,kWidth4s);
             }else if (frameX == 375.0){
                 timeLabel.font = UIFont(15);
                 timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+10,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,120,kWidth6);
             }else if (frameX == 414.0){
                 timeLabel.font = UIFont(16);
                 timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+20,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*i,120,kWidth6p);
             }
             [self.contentView addSubview:timeLabel];
         }

    //出租价格
    UILabel *priceLabel;
    _priceArray = model.hire_price;
    for (int i = 0; i<model.hire_price.count; i++) {
        priceLabel = [[UILabel alloc]init];
        priceLabel.text = [NSString stringWithFormat:@"%@",_priceArray[i]];
        priceLabel.textAlignment = NSTextAlignmentCenter;
       
        if (frameX == 320.0) {
            priceLabel.font = UIFont(15);
            priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame),CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth4s+1)*i,90,kWidth4s);
        }else if (frameX == 375.0){
            priceLabel.font = UIFont(15);
            priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+10,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6+1)*i,80,kWidth6);
        }else if (frameX == 414.0){
            priceLabel.font = UIFont(16);
            priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+20,CGRectGetMaxY(_imageVIewLine17.frame)+(kWidth6p+1)*i,80,kWidth6p);
        }
        [self.contentView addSubview:priceLabel];
    }
    
    //判断是否显示电话
    NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:model.user];
    UIImageView *iphoneImageView;
    NSString *ruleStr = [NSString stringWithFormat:@"%@",self.ruleStr];
    if ([ruleStr isEqualToString:@"11"]) {
        if (model.user) {
            if (dic[@"mobilePhoneNumber"]) {
                _iphoneString = dic[@"mobilePhoneNumber"];
                UILabel *iphoneNum = [[UILabel alloc]init];
             
                UIView *iphoneView = [[UIView alloc]init];
                
                UIButton *iphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                
                if (frameX == 320.0) {
                    iphoneNum.font = UIFont(15);
                    iphoneNum.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine.frame),140, kWidth4s);
                    iphoneView.frame =CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame), frameX-kGap4s, kWidth4s);
                    iphoneBtn.frame = CGRectMake(CGRectGetMaxX(iphoneNum.frame),CGRectGetMaxY(_imageViewLine.frame), frameX - CGRectGetMaxX(iphoneNum.frame), kWidth4s);
                }else if (frameX == 375.0){
                    iphoneNum.font = UIFont(15);
                    iphoneNum.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine.frame), 140, kWidth6);
                    iphoneView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame), frameX - kGap6,kWidth6);
                    iphoneBtn.frame = CGRectMake(CGRectGetMaxX(iphoneNum.frame),CGRectGetMaxY(_imageViewLine.frame), frameX - CGRectGetMaxX(iphoneNum.frame), kWidth4s);
                }else if (frameX == 414.0){
                    iphoneNum.font = UIFont(16);
                    iphoneNum.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine.frame), 140,kWidth6p);
                    iphoneView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame), frameX - kGap6p,kWidth6p);
                    iphoneBtn.frame = CGRectMake(CGRectGetMaxX(iphoneNum.frame),CGRectGetMaxY(_imageViewLine.frame), frameX - CGRectGetMaxX(iphoneNum.frame), kWidth4s);
                }
                [iphoneBtn addTarget:self action:@selector(iphoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [iphoneBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
                if (frameX == 414.0) {
                    iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-255);
                }else if (frameX == 375.0){
                    iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-185);
                }else if(frameX == 320.0){
                    iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-115);
                }
                iphoneView.backgroundColor = [UIColor whiteColor];
                iphoneNum.text = [NSString stringWithFormat:@"电话:%@",dic[@"mobilePhoneNumber"]];
                [self.contentView addSubview:iphoneView];
                [self.contentView addSubview:iphoneNum];
                [self.contentView addSubview:iphoneBtn];
                
                iphoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iphoneNum.frame),frameX, 1)];
                iphoneImageView.image = [UIImage imageNamed:@"720"];
                [self.contentView addSubview:iphoneImageView];
                
            }
        }
    }
    
    //价格
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.font = UIFont(15);
    UIView *priceView = [[UIView alloc]init];
    if (dic[@"mobilePhoneNumber"]) {
        
        if ([ruleStr isEqualToString:@"11"]) {
            
            if (frameX == 320.0) {
                _priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(iphoneImageView.frame),frameX - kGap4s, kWidth4s);
                priceView.frame =CGRectMake(0,CGRectGetMaxY(iphoneImageView.frame),frameX, kWidth4s);
            }else if (frameX == 375.0){
                _priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(iphoneImageView.frame),frameX - kGap6, kWidth6);
                priceView.frame  =  CGRectMake(0,CGRectGetMaxY(iphoneImageView.frame),frameX, kWidth6);
            }else if (frameX == 414.0){
                _priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(iphoneImageView.frame),frameX - kGap6p, kWidth6p);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(iphoneImageView.frame),frameX, kWidth6p);
            }
            
        }else{
            if (frameX == 320.0) {
                _priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap4s, kWidth4s);
                priceView.frame =CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth4s);
            }else if (frameX == 375.0){
                _priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap6, kWidth6);
                priceView.frame  =  CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6);
            }else if (frameX == 414.0){
                _priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap6p, kWidth6p);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6p);
            }
        }
    
    }else{
        
        if (frameX == 320.0) {
            _priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap4s, kWidth4s);
            priceView.frame =CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth4s);
        }else if (frameX == 375.0){
            _priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap6, kWidth6);
            priceView.frame  =  CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6);
        }else if (frameX == 414.0){
            _priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine.frame),frameX - kGap6p, kWidth6p);
            priceView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6p);
        }
    }
    priceView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:priceView];
    [self.contentView addSubview:_priceLabel];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_priceLabel.frame),frameX, 1)];
    imageView.image = [UIImage imageNamed:@"720"];
    [self.contentView addSubview:imageView];
    
    
    
    if (self.user_id &&  ![self.park_space isEqualToString:@"0"]) {
        
        NSString *ruleStr = [NSString stringWithFormat:@"%@",self.ruleStr];
        if (![ruleStr isEqualToString:@"12"]) {
            
            UIButton *confirButton = [UIButton buttonWithFrame:CGRectMake(50.4,CGRectGetMaxY(_priceLabel.frame)+20, frameX - 2*50.4, 40)type:UIButtonTypeSystem title:@"订  单  确  认" target:self action:@selector(comfirmBtn:)];
            
            confirButton.backgroundColor = RGB(254, 156, 0);
            
            [confirButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            
            confirButton.layer.masksToBounds = YES;
            
            confirButton.layer.cornerRadius = 20.0;
            
            [self.contentView addSubview:confirButton];
            
        }
    }
}


//打电话
- (void)iphoneBtnClick:(UIButton *)btn{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_iphoneString];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.contentView addSubview:callWebview];
}

#pragma mark - QRadioButtonDelegate
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    _methods = [radio.titleLabel.text intValue];
    _method = _methodArray[_methods][@"objectId"];
    _hire_field = _fieldArray[_methods];
    
    if ([_startBtn.titleLabel.text isEqualToString:@"年     月     日"] || [_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择出租时间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [radio setChecked:NO];
        
    }else{
    
        NSArray *strartArr = [_startBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
        NSArray *endArra = [_endBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
        
        NSString *startTimeStr = [NSString stringWithFormat:@"%@-%@-%@",strartArr[0],strartArr[1],strartArr[2]];
        NSString *endTimeStr = [NSString stringWithFormat:@"%@-%@-%@",endArra[0],endArra[1],endArra[2]];
        
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        [gregorian setFirstWeekday:2];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *fromDate = [dateFormatter dateFromString:startTimeStr];
        
        NSDate *toDate = [dateFormatter dateFromString:endTimeStr]; 
        
        NSDateComponents *day = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate  options:0];
        if (day.day <= 0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请重新选择出租时间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [radio setChecked:NO];
        }else{
            CalculateUnit *day = [[CalculateUnit alloc]init];
            NSNumber *number =  [day calculateMoneyWithStartTime:_startBtn.titleLabel.text endTime:_endBtn.titleLabel.text andNoDays:_noDayLabel.text andPrice:_priceArray[_methods]];
            _priceNum = number;
            if (number) {
                _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
            }
        }
    }
}


- (void)comfirmBtn:(UIButton *)btn{
    
    if ([StringChangeJson getValueForKey:kUser_id].length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请注册" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }else if([StringChangeJson getValueForKey:kUser_id] ) {
        
        //&& [StringChangeJson getValueForKey:kRegistationID] &&[StringChangeJson getValueForKey:kMobelNum]
        
        if (_method &&_startBtn.titleLabel.text&&_endBtn.titleLabel.text) {
            
            //计算时间
            CalculateUnit *ca = [[CalculateUnit alloc]init];
            
            NSString *price = _priceArray[_methods];
            
            NSNumber *num = [ca calculateMoneyWithStartTime:_startBtn.titleLabel.text   endTime:_endBtn.titleLabel.text andNoDays:nil andPrice:price];
            
            //租用类型,判断是按天还是按月
            NSString *string = [[self.hire_field componentsSeparatedByString:@"_"] lastObject];
            
            if ([string isEqualToString:@"day"]) {
                
                [self sendJpush];
                
            }else{
                
                 if ([ca.string intValue] >= 30 ) {
                     
                     [self sendJpush];
                     
                 }else{
                     
                     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您租用的时间少于一个月" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     
                     [alertView show];
                     
                }
            }

        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择租用方式和时间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
            
        }
    }
}



//下单
- (void)sendJpush{

    //判断对方发布车位信息时的设备类型

     NSArray *strartArr = [_startBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
    
     NSArray *endArra = [_endBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
     
     NSString *startTime = [NSString stringWithFormat:@"%@-%@-%@",strartArr[0],strartArr[1],strartArr[2]];
    
     NSString *endTime = [NSString stringWithFormat:@"%@-%@-%@",endArra[0],endArra[1],endArra[2]];
    
    
    NSString *registS = [StringChangeJson getValueForKey:kRegistationID];
    
    if (registS.length == 0) {
        
        registS = @"";
        
    }
    
    
     NSDictionary *extras = @{@"park_id":self.park_id,@"hire_method_id":_method,@"own_device_token":registS,@"own_device_type":@"ios",@"own_mobile":[StringChangeJson getValueForKey:kMobelNum] ,@"hire_start":[NSString stringWithFormat:@"%@ 00:00:00",startTime],@"hire_end":[NSString stringWithFormat:@"%@ 00:00:00",endTime],@"push_type":@"verify_request",@"mode":@"community",@"address":self.addressLabel.text,@"price":_priceNum,@"hire_method_field":self.hire_field};
     
     NSDictionary *dictionary = @{@"mobilePhoneNumber":_mobileNum,@"push_type":@"verify_request",@"device_token":_device_token,@"device_type":_device_type,@"user_id":[StringChangeJson getValueForKey:kUser_id],@"extras":extras};
     
     _jpushRequest  = [[KongCVHttpRequest alloc]initWithRequests:kToJPushUrl sessionToken:nil dictionary:dictionary andBlock:^(NSDictionary *data) {
         
         NSString *str = data[@"result"];
         
         NSData *datas = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
         
         if ([dic[@"msg"] isEqualToString:@"成功"]) {
             
             UIAlertViewShow(@"发送成功");
             
         }else{
             
             UIAlertViewShow(dic[@"error"]);
             
         }
         
     }];
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


//选择租用日期
- (void)chooseDayClick:(UIButton *)btn{
    
    UIViewController *controller = [self getCurrentVC];
    CalendarHomeViewController *home = [[CalendarHomeViewController alloc]init];
    [home setAirPlaneToDay:365 ToDateforString:nil];
    home.calendarblock = ^(CalendarDayModel *model){
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject]];
        [btn setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
        
        if (_method) {
            if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"] && ![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
                CalculateUnit *day = [[CalculateUnit alloc]init];
                NSNumber *number =  [day calculateMoneyWithStartTime:[NSString stringWithFormat:@"%@",time]endTime:_endBtn.titleLabel.text andNoDays:_noDayLabel.text andPrice:_priceArray[_methods]];
                _priceNum = number;
                if (number) {
                    _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
                }
            }
        }
    };
    //home.string = @"string";
    [controller presentViewController:home animated:YES completion:nil];
}

- (void)chooseEndDayClick:(UIButton *)endbtn{

    UIViewController *controller = [self getCurrentVC];
    CalendarHomeViewController *home = [[CalendarHomeViewController alloc]init];
    [home setAirPlaneToDay:365 ToDateforString:nil];
    home.calendarblock = ^(CalendarDayModel *model){
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject]];
        [endbtn setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        [endbtn setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
        
        if (_method) {
            if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"] && ![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
                CalculateUnit *day = [[CalculateUnit alloc]init];
                NSNumber *number =  [day calculateMoneyWithStartTime:_startBtn.titleLabel.text endTime:[NSString stringWithFormat:@"%@",time] andNoDays:_noDayLabel.text andPrice:_priceArray[_methods]];
                _priceNum = number;
                if (number) {
                    _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
                }
            }
        }
    };
    //home.string = @"string";
    [controller presentViewController:home animated:YES completion:nil];
}



@end
