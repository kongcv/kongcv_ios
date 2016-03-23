//
//  RouteTableViewCell.m
//  kongcv
//
//  Created by 空车位 on 15/12/8.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RouteTableViewCell.h"
#import "QRadioButton.h"
#import "PaymentViewController.h"
#import "CalculateUnit.h"
#import "CalendarViewController.h"
#import "CalendarHomeViewController.h"
#define kGap4s     8.9
#define kGap6       10.8
#define kGap6p    11.5
#define kWidth4s   32.6
#define kWidth6     39.3
#define kWidth6p  42.3

@interface RouteTableViewCell ()
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *detailAddressLabel;
@property(nonatomic,strong) UILabel *descritedLabel;
@property(nonatomic,strong) UILabel *typeLabel;
@property(nonatomic,strong) UILabel *typeLabel1;
@property(nonatomic,strong) UIImageView *imageViewLine2;
@property(nonatomic,strong) UIImageView *imageViewLine3;
@property(nonatomic,strong) UIImageView *imageViewLine4;
@property(nonatomic,strong) UIImageView *imageViewLine5;
@property(nonatomic,strong) UIImageView *imageViewLine6;
@property(nonatomic,strong) UIView *view2;
@property(nonatomic,strong) UIView *view3;
@property(nonatomic,strong) NSMutableArray *methodArray;
@property(nonatomic,copy)   NSString  *method;
@property(nonatomic,strong) UILabel   *iphoneLabel;
@property(nonatomic,strong) UILabel   *iphoneGroup;
@property(nonatomic,strong) UIButton *iphoneBtn;
@property(nonatomic,strong) UIButton *iphoneGroupBtn;
@property(nonatomic,strong) NSNumber   *priceNum;
//价格数组
@property(nonatomic,strong) NSArray *priceArray;
@property(nonatomic,assign) int methods;
//选择起始结束租用时间
@property(nonatomic,strong) UIButton *startBtn;
@property(nonatomic,strong) UIButton *endBtn;
//辅助车位管理
@property(nonatomic,strong) NSArray  *userGroupArr;
//单选按钮
@property(nonatomic,strong) QRadioButton *qradioButton;

@property(nonatomic,strong) UIView *iphoneView;
//网络请求
@property(nonatomic,strong) KongCVHttpRequest *jPushRequest;

@property(nonatomic,strong) UIView *descritedView;

@property(nonatomic,strong) UILabel *priceLabel;

@property(nonatomic,strong) UIImageView *imageViewLine;

@property(nonatomic,strong) UIImageView *detailImage;
//单价
@property(nonatomic,copy)   NSString *unitPrice;
//费率
@property(nonatomic,copy)   NSString *curb_rate;
//别名数组
@property(nonatomic,strong) NSMutableArray *fieldArray;
//选择租用方式的别名
@property(nonatomic,copy)   NSString *hire_field;
//电话
@property(nonatomic,copy)   NSString *iphoneString;
//车牌号
@property (nonatomic,copy)   NSString *license_plate;
//此车位的用户信息
@property(nonatomic,strong) NSDictionary *userDic;
//此车位的token
@property(nonatomic,copy)   NSString *device_token;
//此车位的type
@property(nonatomic,copy)   NSString *device_type;
//此车位的userid
@property(nonatomic,copy)   NSString *user_id;
//此车位的电话
@property(nonatomic,copy)   NSString *mobileNum;
//用户选择租用的别名
@property(nonatomic,copy)   NSString *fieldString;
//对方同意后从jPush获取的租用别名 
@property (nonatomic,copy) NSString *field;

@end

@implementation RouteTableViewCell

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
        //_addressLabel.backgroundColor = [UIColor redColor];
        if (frameX == 320.0) {
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, 5.6 , frameX-adressImage.frame.size.width,kWidth4s);
        }else if (frameX == 375.0){
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5, 6.3 , frameX-adressImage.frame.size.width,kWidth6);
        }else if (frameX == 414.0){
            _addressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,6.6, frameX-adressImage.frame.size.width,kWidth6p);
        }
        [self.contentView addSubview:_addressLabel];
        
        _detailAddressLabel = [[UILabel alloc]init];
        UIView *detailView = [[UIView alloc]init];
        if (frameX == 320.0) {
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3, CGRectGetMaxY(imageViewLine2.frame) , frameX-adressImage.frame.size.width,kWidth4s);
            detailView.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine2.frame),frameX, kWidth4s);
        }else if (frameX == 375.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+3.5, CGRectGetMaxY(imageViewLine2.frame) , frameX-adressImage.frame.size.width,kWidth6);
            detailView.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine2.frame),frameX, kWidth6);
        }else if (frameX == 414.0){
            _detailAddressLabel.frame = CGRectMake(CGRectGetMaxX(adressImage.frame)+5,CGRectGetMaxY(imageViewLine2.frame), frameX-adressImage.frame.size.width,kWidth6p);
            detailView.frame = CGRectMake(0, CGRectGetMaxY(imageViewLine2.frame),frameX, kWidth6p);
        }
        detailView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:detailView];
        [self.contentView addSubview:_detailAddressLabel];
        
        UIImageView *detailImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_detailAddressLabel.frame),frameX, 1)];
        _detailImage = detailImage;
        detailImage.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:detailImage];
        

        //车位描述
        UIImageView *imageViewLine3 = [[UIImageView alloc]init];
        _imageViewLine3 = imageViewLine3;
        _descritedView = [[UIView alloc]init];
        _descritedView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_descritedView];
        imageViewLine3.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine3];
        
        UIView *view2 = [[UIView alloc]init];
        _view2 = view2;
        view2.backgroundColor = RGB(255, 255, 255);
        [self.contentView addSubview:view2];
        
        _descritedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:_descritedLabel];
        
        
        UIImageView *imageViewLine4 = [[UIImageView alloc]init];
        _imageViewLine4 = imageViewLine4;
        imageViewLine4.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine4];
        
        //出租类型
        UIImageView *imageViewLine5 = [[UIImageView alloc]init];
        _imageViewLine5 = imageViewLine5;
        imageViewLine5.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine5];
        
        
        UIView *view3 = [[UIView alloc]init];
        _view3 = view3;
        view3.backgroundColor = RGB(255, 255, 255);
        [self.contentView addSubview:view3];
        
        UIImageView *imageViewLine6 = [[UIImageView alloc]init];
        _imageViewLine6 = imageViewLine6;
        imageViewLine6.image = [UIImage imageNamed:@"720@2x"];
        [self.contentView addSubview:imageViewLine6];
        
        UILabel *typeLbael = [[UILabel alloc]init];
        _typeLabel = typeLbael;
        [self.contentView addSubview:typeLbael];
        
        
        _iphoneView = [[UIView alloc]init];
        _iphoneView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_iphoneView];
        _iphoneLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_iphoneLabel];
        
        _iphoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iphoneBtn addTarget:self action:@selector(iphoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_iphoneBtn];
        
    }
    return self;
}

-(void)setModel:(DetailInfoModel *)model{
    
    
    
    if (model.user) {
        NSDictionary *userDictionary = [StringChangeJson jsonDictionaryWithString:model.user];
        
        
        if (userDictionary[@"mobilePhoneNumber"]) {
            self.mobileNum = userDictionary[@"mobilePhoneNumber"];
        }else{
            self.mobileNum = @"";
        }
        
        if (userDictionary[@"device_token"]) {
            self.device_token = userDictionary[@"device_token"];
        }else{
            self.device_token = @"";
        }
        
        if (userDictionary[@"device_type"]) {
            self.device_type = userDictionary[@"device_type"];
        }else{
            self.device_type = @"";
        }
        
        if (userDictionary[@"license_plate"]) {
            self.license_plate = userDictionary[@"license_plate"];
        }else{
            self.license_plate = @"";
        }
        
        if (userDictionary[@"objectId"]) {
            self.user_id = userDictionary[@"objectId"];
        }else{
            self.user_id = @"";
        }
    }

    
    _addressLabel.text = [[model.address componentsSeparatedByString:@"&"] firstObject];
    
    _addressLabel.font = UIFont(15);
    
    _detailAddressLabel.text = [[model.address componentsSeparatedByString:@"&"] lastObject];
    
    _detailAddressLabel.font = UIFont(14);
    
    [_descritedLabel setNumberOfLines:0];
    

    //选择起始日期
    UIView *chooseView = [[UIView alloc]init];
        if (frameX == 320.0) {
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(_detailImage.frame), frameX, kWidth4s*2);
        }else if (frameX == 375.0){
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(_detailImage.frame), frameX, kWidth6*2);
        }else{
            chooseView.frame = CGRectMake(0, CGRectGetMaxY(_detailImage.frame), frameX, kWidth6p*2);
        }
        chooseView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:chooseView];
        
        UILabel *hireStartTime = [[UILabel alloc]init];
        if (frameX == 320.0) {
            hireStartTime.frame = CGRectMake(kGap4s,CGRectGetMaxY(_detailImage.frame)+1,150,kWidth4s);
        }else if (frameX == 375.0){
            hireStartTime.frame = CGRectMake(kGap6,CGRectGetMaxY(_detailImage.frame),150,kWidth6);
        }else{
            hireStartTime.frame = CGRectMake(kGap6p,CGRectGetMaxY(_detailImage.frame),150,kWidth6p);
        }
        hireStartTime.text = @"租用起始时间";
        hireStartTime.font = UIFont(15);
    
    if (self.user_id) {
        
          [self.contentView addSubview:hireStartTime];
        
    }
    
        if (frameX == 320.0) {
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(_detailImage.frame),frameX - 150-kGap4s,kWidth4s) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseEndDayClick:)];
            _startBtn.titleLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(_detailImage.frame),frameX - 150-kGap6,kWidth6) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _startBtn.titleLabel.font = UIFont(15);
        }else{
            _startBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(hireStartTime.frame),CGRectGetMaxY(_detailImage.frame),frameX - 150-kGap6p,kWidth6p) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _startBtn.titleLabel.font = UIFont(16);
        }
    
    if (self.user_id) {
        
        [self.contentView addSubview:_startBtn];
        
    }
    
    
        
        //租用结束时间
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
    
    if (self.user_id) {
        
         [self.contentView addSubview:endStartLabel];
        
    }
    
    
    _endBtn.titleLabel.font = UIFont(15);
        if (frameX == 320.0) {
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth4s) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _endBtn.titleLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth6) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _endBtn.titleLabel.font = UIFont(15);
        }else{
            _endBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endStartLabel.frame),CGRectGetMaxY(_startBtn.frame)+1,frameX-150-kGap4s,kWidth6p) type:UIButtonTypeCustom title:@"年     月     日" target:self action:@selector(chooseDayClick:)];
            _endBtn.titleLabel.font = UIFont(16);
        }
    
    if (self.user_id) {
        
         [self.contentView addSubview:_endBtn];
        
    }
    
    
        
        UIImageView *chooseImageLine2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endBtn.frame), frameX, 1)];
        chooseImageLine2.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:chooseImageLine2];
    
        if (frameX == 320.0) {
            _imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_endBtn.frame)+kGap4s, frameX, 1);
        }else if (frameX == 375.0){
            _imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_endBtn.frame)+kGap6, frameX, 1);
        }else if (frameX == 414.0){
            _imageViewLine3.frame = CGRectMake(0, CGRectGetMaxY(_endBtn.frame)+kGap6p, frameX, 1);
        }

    
    CGSize descritedSize = [model.park_description boundingRectWithSize:CGSizeMake(frameX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

    if (model.park_description.length != 0) {
        _descritedLabel.text = [NSString stringWithFormat:@"道路描述:%@",model.park_description];
        _imageViewLine4.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame),frameX, 1);
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+10);
            _view2.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+10);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+15);
            _view2.frame =  CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+15);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+18);
            _view2.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX, descritedSize.height+18);
            _descritedLabel.font = UIFont(16);
        }
    }else{
        _descritedLabel.text = @"车位描述:暂无";
        if (frameX == 320.0) {
            _descritedLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth4s);
            _view2.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth4s);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            _descritedLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth6);
            _view2.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth6);
            _descritedLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            _descritedLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth6p);
            _view2.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine3.frame), frameX,kWidth6p);
            _descritedLabel.font = UIFont(16);
        }
        _imageViewLine4.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame),frameX, 1);
    }

    
    //类型
    if (frameX == 320.0) {
        _imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+13.6, frameX, 1);
    }else if (frameX == 375.0){
        _imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+16.4, frameX, 1);
    }else if (frameX == 414.0){
        _imageViewLine5.frame = CGRectMake(0, CGRectGetMaxY(_descritedLabel.frame)+17.7, frameX, 1);
    }
    
    if (frameX == 320.0) {
        _view3.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth4s);
    }else if (frameX == 375.0){
        _view3.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth6);
    }else if (frameX == 414.0){
        _view3.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth6p);
    }
    
    if (frameX == 320.0) {
        _imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame)+kWidth4s, frameX, 1);
    }else if (frameX == 375.0){
        _imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame)+kWidth6, frameX, 1);
    }else if (frameX == 414.0){
        _imageViewLine6.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame)+kWidth6p, frameX, 1);
    }
    
    
    _typeLabel.font = UIFont(15);
    if (frameX == 320.0) {
        _typeLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth4s);
        _typeLabel.text = @"       类型                   时间              价格";
    }else if (frameX == 375.0){
        _typeLabel.text = @"         类型                       时间                   价格";
        _typeLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth6);
    }else if (frameX == 414.0){
        _typeLabel.text = @"     类型                              时间                       价格";
        _typeLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine5.frame), frameX, kWidth6p);
    }
    
    
    NSString *string = model.hire_method;
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    _methodArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _fieldArray = [NSMutableArray array];
    for (NSDictionary *dic in _methodArray) {
        [_fieldArray addObject:dic[@"field"]];
    }

    //出租类型
    if ([self.push_type isEqualToString:@"verify_accept"] || [self.push_type isEqualToString:@"trade_charge"]) {
        for (int i = 0; i<_methodArray.count; i++) {
            
            if ([_methodArray[i][@"objectId"] isEqualToString:self.hire_method_id]) {
                
                _field = _fieldArray[i];
                
                //出租时间
                UILabel *timeLabel;
                //出租价格
                UILabel *priceLabel;
                _priceArray = model.hire_price;
                
                _unit_Price = _priceArray[i];
                
                QRadioButton *RadioButton = [[QRadioButton alloc]initWithDelegate:self groupId:@"groud"];
                _qradioButton = RadioButton;
                _qradioButton.tag = i;
                [RadioButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
                [RadioButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [RadioButton setChecked:NO];
                _typeLabel1 = [[UILabel alloc]init];
                UIImageView *imageViewLine = [[UIImageView alloc]init];
                _imageViewLine = imageViewLine;
                UIView *view = [[UIView alloc]init];
                _typeLabel1.text = _methodArray[i][@"method"];
                
                if (frameX == 320.0) {
                    _typeLabel1.frame = CGRectMake(5, CGRectGetMaxY(_imageViewLine6.frame)+1,100, kWidth4s);
                    _typeLabel1.font = UIFont(15);
                    RadioButton.frame = CGRectMake(frameX-30,CGRectGetMaxY(_imageViewLine6.frame)+1,30,30);
                    imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, 1);
                    view.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, kWidth4s);
                }else if (frameX == 375.0){
                    _typeLabel1.frame = CGRectMake(kGap6, CGRectGetMaxY(_imageViewLine6.frame)+1,100, kWidth6);
                    _typeLabel1.font = UIFont(15);
                    RadioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageViewLine6.frame)+2,30,30);
                    imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, 1);
                    view.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, kWidth6);
                }else if (frameX == 414.0){
                    _typeLabel1.frame = CGRectMake(kGap6p, CGRectGetMaxY(_imageViewLine6.frame)+1,100, kWidth6p);
                    _typeLabel1.font = UIFont(16);
                    RadioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageViewLine6.frame)+1,30,30);
                    imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, 1);
                    view.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+1,frameX, kWidth6p);
                }
                imageViewLine.image = [UIImage imageNamed:@"720@2x"];
                view.backgroundColor = RGB(255, 255, 255);
                [self.contentView addSubview:view];
                [self.contentView addSubview:imageViewLine];
                [self.contentView addSubview:_typeLabel1];
                //[self.contentView addSubview:RadioButton];
                
                
                timeLabel = [[UILabel alloc]init];
                timeLabel.text = model.hire_time[i];
                timeLabel.textAlignment = NSTextAlignmentCenter;
                if (frameX == 320.0) {
                    timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+5,CGRectGetMaxY(_imageViewLine6.frame)+1,100,kWidth4s);
                    timeLabel.font = UIFont(15);
                }else if (frameX == 375.0){
                    timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+10,CGRectGetMaxY(_imageViewLine6.frame)+1,100,kWidth6);
                    timeLabel.font = UIFont(15);
                }else if (frameX == 414.0){
                    timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+20,CGRectGetMaxY(_imageViewLine6.frame)+1,100,kWidth6p);
                    timeLabel.font = UIFont(16);
                }
                [self.contentView addSubview:timeLabel];
                
                
                priceLabel = [[UILabel alloc]init];
                priceLabel.text = model.hire_price[i];
                //[NSString stringWithFormat:@"%@",model.hire_price[i]];
                priceLabel.textAlignment = NSTextAlignmentCenter;
                
                if (frameX == 320.0) {
                    priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame),CGRectGetMaxY(_imageViewLine6.frame)+1,70,kWidth4s);
                    priceLabel.font = UIFont(15);
                }else if (frameX == 375.0){
                    priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+15,CGRectGetMaxY(_imageViewLine6.frame)+1,80,kWidth6);
                    priceLabel.font = UIFont(15);
                }else if (frameX == 414.0){
                    priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+25,CGRectGetMaxY(_imageViewLine6.frame)+1,100,kWidth6p);
                    priceLabel.font = UIFont(16);
                }
                
                [self.contentView addSubview:priceLabel];
            }
            
        }
    }else{
    
        for (int i = 0; i<_methodArray.count; i++) {
            QRadioButton *RadioButton = [[QRadioButton alloc]initWithDelegate:self groupId:@"groud"];
            _qradioButton = RadioButton;
            _qradioButton.tag = i;
            [RadioButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [RadioButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [RadioButton setChecked:NO];
            _typeLabel1 = [[UILabel alloc]init];
            UIImageView *imageViewLine = [[UIImageView alloc]init];
            _imageViewLine = imageViewLine;
            UIView *view = [[UIView alloc]init];
            _typeLabel1.text = _methodArray[i][@"method"];
            
            if (frameX == 320.0) {
                _typeLabel1.frame = CGRectMake(5, CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*i,100, kWidth4s);
                _typeLabel1.font = UIFont(15);
                RadioButton.frame = CGRectMake(frameX-30,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*i,30,30);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*(i+1),frameX, 1);
                view.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*i,frameX, kWidth4s);
            }else if (frameX == 375.0){
                _typeLabel1.frame = CGRectMake(kGap6, CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+1)*i,100, kWidth6);
                _typeLabel1.font = UIFont(15);
                RadioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+2)*i,30,30);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+1)*(i+1),frameX, 1);
                view.frame = CGRectMake(0, CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+1)*i,frameX, kWidth6);
            }else if (frameX == 414.0){
                _typeLabel1.frame = CGRectMake(kGap6p, CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p)*i,100, kWidth6p);
                _typeLabel1.font = UIFont(16);
                RadioButton.frame = CGRectMake(frameX - 30,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p)*i,30,30);
                imageViewLine.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p+1)*(i+1),frameX, 1);
                view.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p+1)*i,frameX, kWidth6p);
            }
            imageViewLine.image = [UIImage imageNamed:@"720@2x"];
            view.backgroundColor = RGB(255, 255, 255);
            [self.contentView addSubview:view];
            [self.contentView addSubview:imageViewLine];
            [self.contentView addSubview:_typeLabel1];
            
            if (self.user_id) {
                
                 [self.contentView addSubview:RadioButton];
                
            }

        }
        

        
        //出租时间
        UILabel *timeLabel;
        for (int i = 0; i<model.hire_time.count; i++) {
            timeLabel = [[UILabel alloc]init];
            timeLabel.text = model.hire_time[i];
            timeLabel.textAlignment = NSTextAlignmentCenter;
            if (frameX == 320.0) {
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+5,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*i,100,kWidth4s);
                timeLabel.font = UIFont(15);
            }else if (frameX == 375.0){
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+10,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+1)*i,100,kWidth6);
                timeLabel.font = UIFont(15);
            }else if (frameX == 414.0){
                timeLabel.frame = CGRectMake(CGRectGetMaxX(_typeLabel1.frame)+20,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p+1)*i,100,kWidth6p);
                timeLabel.font = UIFont(16);
            }
            [self.contentView addSubview:timeLabel];
        }
        
        //出租价格
        UILabel *priceLabel;
        _priceArray = model.hire_price;
        for (int i = 0; i<model.hire_price.count; i++) {
            priceLabel = [[UILabel alloc]init];
            priceLabel.text = model.hire_price[i];
            //[NSString stringWithFormat:@"%@",model.hire_price[i]];
            priceLabel.textAlignment = NSTextAlignmentCenter;
            
            if (frameX == 320.0) {
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame),CGRectGetMaxY(_imageViewLine6.frame)+(kWidth4s+1)*i,70,kWidth4s);
                priceLabel.font = UIFont(15);
            }else if (frameX == 375.0){
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+15,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6+1)*i,80,kWidth6);
                priceLabel.font = UIFont(15);
            }else if (frameX == 414.0){
                priceLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+25,CGRectGetMaxY(_imageViewLine6.frame)+(kWidth6p+1)*i,100,kWidth6p);
                priceLabel.font = UIFont(16);
            }
            
            [self.contentView addSubview:priceLabel];
        }

    }
    
    //查找租用类型  56373f1100b0ee7f5ee8355c
    
    _priceArray = model.hire_price;
    
    _unitPrice = [[NSString alloc]init];
    
    for (int i = 0; i<_methodArray.count; i++) {
        if ([_methodArray[i][@"objectId" ] isEqualToString:self.hire_method_id]) {
            NSString *string = [NSString stringWithFormat:@"%d",i];
            int d = [string intValue];
            _unitPrice = [NSString stringWithFormat:@"%@",_priceArray[d]];
        }
    }
    
    
    //显示价格
    NSString *ruleStr = [NSString stringWithFormat:@"%@",self.ruleStr];
    
    if (self.listprice) {
        
        if ([ruleStr isEqualToString:@"11"]) {
            
            //电话号码
            UIImageView *imageV = [[UIImageView alloc]init];
            
            imageV.image = [UIImage imageNamed:@"720"];
            
            [self.contentView addSubview:imageV];
            
            if (frameX == 320.0) {
                imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
                _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth4s);
                _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth4s);
                _iphoneLabel.font = UIFont(15);
            }else if (frameX == 375.0){
                imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
                _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth6);
                _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth6);
                _iphoneLabel.font = UIFont(15);
            }else if (frameX == 414.0){
                imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
                _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth6p);
                _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth6p);
                _iphoneLabel.font = UIFont(16);
            }
            
            if (model.user) {
                
                NSDictionary *userDic = [StringChangeJson jsonDictionaryWithString:model.user];
                
                _iphoneLabel.text = userDic[@"mobilePhoneNumber"];
                
                if (frameX == 320.0) {
                    _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth4s);
                    _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -85);
                }else if (frameX == 375.0){
                    _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth6);
                    _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -185);
                }else if (frameX ==414.0){
                    _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth6p);
                    _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -255);
                }
                
                [_iphoneBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
                
            }
            
            if (model.user_group) {
                
                NSData *userData = [model.user_group dataUsingEncoding:NSUTF8StringEncoding];
                
                _userGroupArr = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
                
                for (int i = 0; i<_userGroupArr.count; i++) {
                    UIView *viewGroup = [[UIView alloc]init];
                    if (frameX == 320.0) {
                        viewGroup.frame = CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame)+2+(kWidth4s+2)*i, frameX,kWidth4s);
                    }else if (frameX == 375.0){
                        viewGroup.frame = CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame)+2+(kWidth6+2)*i, frameX,kWidth6);
                    }
                    viewGroup.backgroundColor = [UIColor whiteColor];
                    [self.contentView addSubview:viewGroup];
                    
                    _iphoneGroup = [[UILabel alloc]init];
                    
                    if (frameX == 320.0) {
                        _iphoneGroup.frame = CGRectMake(kGap4s,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth4s+2)*i,150, kWidth4s);
                        _iphoneGroup.font = UIFont(15);
                    }else if (frameX == 375.0){
                        _iphoneGroup.frame = CGRectMake(kGap6,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6+2)*i,150, kWidth6);
                        _iphoneGroup.font = UIFont(15);
                    }else if (frameX == 414.0){
                        _iphoneGroup.frame = CGRectMake(kGap6p,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6p+2)*i,150, kWidth6p);
                        _iphoneGroup.font = UIFont(16);
                    }
                    
                    _iphoneGroup.text = _userGroupArr[i][@"mobilePhoneNumber"];
                    
                    [self.contentView addSubview:_iphoneGroup];
                    
                    _iphoneGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    [_iphoneGroupBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
                    
                    if (frameX == 320.0) {
                        _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth4s+2)*i,180, kWidth4s);
                        _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -85);
                    }else if (frameX == 375.0){
                        _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6+2)*i,180, kWidth6);
                        _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-185);
                    }else if (frameX == 414.0){
                        _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6p+2)*i,180, kWidth6p);
                        _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-255);
                    }
                    
                    [_iphoneGroupBtn addTarget:self action:@selector(iphoneGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    _iphoneGroupBtn.tag = i;
                    
                    [self.contentView addSubview:_iphoneGroupBtn];
                    
                }
            }
            
            UIImageView *imageView;
            
            if (model.user_group) {
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iphoneGroup.frame) ,frameX, 1)];
                imageView.image = [UIImage imageNamed:@"720"];
                [self.contentView addSubview:imageView];
            }else{
                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame) ,frameX, 1)];
                imageView.image = [UIImage imageNamed:@"720"];
                [self.contentView addSubview:imageView];
            }
            
            //总价
            UIView *priceView = [[UIView alloc]init];
            _priceLabel = [[UILabel alloc]init];
            if (frameX == 320.0) {
                _priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageView.frame),frameX-kGap4s, kWidth4s);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX, kWidth4s);
                _priceLabel.font = UIFont(15);
            }else if (frameX == 375.0){
                _priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(imageView.frame),frameX-kGap6, kWidth6);
                _priceLabel.font = UIFont(15);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX, kWidth6);
            }else if (frameX == 414.0){
                _priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageView.frame),frameX-kGap6p, kWidth6p);
                _priceLabel.font = UIFont(16);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX, kWidth6p);
            }
            priceView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:priceView];
            [self.contentView addSubview:_priceLabel];
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_priceLabel.frame),frameX,1)];
            imageview.image = [UIImage imageNamed:@"720"];
            [self.contentView addSubview:imageview];
            
        }else{
            //总价
            UIView *priceView = [[UIView alloc]init];
            _priceLabel = [[UILabel alloc]init];
            if (frameX == 320.0) {
                _priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(_imageViewLine.frame),frameX-kGap4s, kWidth4s);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth4s);
                _priceLabel.font = UIFont(15);
            }else if (frameX == 375.0){
                _priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(_imageViewLine.frame),frameX-kGap6, kWidth6);
                _priceLabel.font = UIFont(15);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6);
            }else if (frameX == 414.0){
                _priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(_imageViewLine.frame),frameX-kGap6p, kWidth6p);
                _priceLabel.font = UIFont(16);
                priceView.frame = CGRectMake(0,CGRectGetMaxY(_imageViewLine.frame),frameX, kWidth6p);
            }
            priceView.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:priceView];
            [self.contentView addSubview:_priceLabel];
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_priceLabel.frame),frameX,1)];
            imageview.image = [UIImage imageNamed:@"720"];
            [self.contentView addSubview:imageview];
        }
        
    }

    
    if ([self.push_type isEqualToString:@"verify_accept"] || [self.push_type isEqualToString:@"trade_charge"]) {
        
        if (model.rate) {
            _curb_rate = [NSString stringWithFormat:@"%@",model.rate];
        }else{
            _curb_rate = @"";
        }
        
        //电话号码
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageV];
        if (frameX == 320.0) {
            imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
            _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth4s);
            _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth4s);
            _iphoneLabel.font = UIFont(15);
        }else if (frameX == 375.0){
            imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
            _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth6);
            _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth6);
            _iphoneLabel.font = UIFont(15);
        }else if (frameX == 414.0){
            imageV.frame = CGRectMake(0,CGRectGetMaxY(_typeLabel1.frame),frameX,1);
            _iphoneView.frame = CGRectMake(0, CGRectGetMaxY(_typeLabel1.frame),frameX, kWidth6p);
            _iphoneLabel.frame = CGRectMake(10, CGRectGetMaxY(_typeLabel1.frame),150,kWidth6p);
            _iphoneLabel.font = UIFont(16);
        }
        
        if (model.user) {
            NSDictionary *userDic = [StringChangeJson jsonDictionaryWithString:model.user];
            _iphoneLabel.text = userDic[@"mobilePhoneNumber"];
            if (frameX == 320.0) {
                _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth4s);
                _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -85);
            }else if (frameX == 375.0){
                _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth6);
                _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -185);
            }else if (frameX ==414.0){
                _iphoneBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneLabel.frame),CGRectGetMaxY(_typeLabel1.frame),180,kWidth6p);
                _iphoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -255);
            }
            [_iphoneBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
        }

        if (model.user_group) {
            
            
            NSData *userData = [model.user_group dataUsingEncoding:NSUTF8StringEncoding];
            _userGroupArr = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            
            for (int i = 0; i<_userGroupArr.count; i++) {
                UIView *viewGroup = [[UIView alloc]init];
                if (frameX == 320.0) {
                    viewGroup.frame = CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame)+2+(kWidth4s+2)*i, frameX,kWidth4s);
                }else if (frameX == 375.0){
                    viewGroup.frame = CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame)+2+(kWidth6+2)*i, frameX,kWidth6);
                }else if(frameX == 414.0){
                    viewGroup.frame = CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame)+2+(kWidth6p+2)*i, frameX,kWidth6p);
                }
                viewGroup.backgroundColor = [UIColor whiteColor];
                [self.contentView addSubview:viewGroup];
                
                _iphoneGroup = [[UILabel alloc]init];
                if (frameX == 320.0) {
                    _iphoneGroup.frame = CGRectMake(kGap4s,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth4s+2)*i,150, kWidth4s);
                    _iphoneGroup.font = UIFont(15);
                }else if (frameX == 375.0){
                    _iphoneGroup.frame = CGRectMake(kGap6,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6+2)*i,150, kWidth6);
                    _iphoneGroup.font = UIFont(15);
                }else if (frameX == 414.0){
                    _iphoneGroup.frame = CGRectMake(kGap6p,CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6p+2)*i,150, kWidth6p);
                    _iphoneGroup.font = UIFont(16);
                }
                _iphoneGroup.text = _userGroupArr[i][@"mobilePhoneNumber"];
                [self.contentView addSubview:_iphoneGroup];
                
                _iphoneGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [_iphoneGroupBtn setImage:[UIImage imageNamed:@"btn_default_bohao"] forState:UIControlStateNormal];
                if (frameX == 320.0) {
                    _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth4s+2)*i,180, kWidth4s);
                    _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -85);
                }else if (frameX == 375.0){
                    _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6+2)*i,180, kWidth6);
                    _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-185);
                }else if (frameX == 414.0){
                    _iphoneGroupBtn.frame = CGRectMake(CGRectGetMaxX(_iphoneGroup.frame),CGRectGetMaxY(_iphoneLabel.frame)+2+(kWidth6p+2)*i,180, kWidth6p);
                    _iphoneGroupBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-255);
                }

                [_iphoneGroupBtn addTarget:self action:@selector(iphoneGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                _iphoneGroupBtn.tag = i;
                [self.contentView addSubview:_iphoneGroupBtn];
            }
        }
        UIImageView *imageView;
        if (model.user_group) {
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iphoneGroup.frame) ,frameX, 1)];
            imageView.image = [UIImage imageNamed:@"720"];
            [self.contentView addSubview:imageView];
        }else{
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_iphoneBtn.frame) ,frameX, 1)];
            imageView.image = [UIImage imageNamed:@"720"];
            [self.contentView addSubview:imageView];
        }


        UIView *timeView = [[UIView alloc]init];
        if (frameX == 320.0) {
            timeView.frame = CGRectMake(0,CGRectGetMaxY(_detailAddressLabel.frame),frameX,kWidth4s);
        }else if (frameX == 375.0){
            timeView.frame = CGRectMake(0,CGRectGetMaxY(_detailAddressLabel.frame),frameX,kWidth4s);
        }else{
            timeView.frame = CGRectMake(0,CGRectGetMaxY(_detailAddressLabel.frame),frameX,kWidth4s);
        }
        timeView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:timeView];
        

        [_startBtn setTitle:[[self.hire_start componentsSeparatedByString:@" "] firstObject] forState:UIControlStateNormal];
        [_endBtn setTitle:[[self.hire_end componentsSeparatedByString:@" "] firstObject] forState:UIControlStateNormal];
        
        UILabel *priceLabel = [[UILabel alloc]init];
        UIView *view = [[UIView alloc]init];
        priceLabel.textColor = RGB(53, 53, 53);
        if (frameX == 320.0) {
            priceLabel.frame = CGRectMake(kGap4s,CGRectGetMaxY(imageView.frame),frameX - kGap4s,kWidth4s);
            priceLabel.font = UIFont(15);
            view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth4s);
        }else if (frameX == 375.0){
            priceLabel.frame = CGRectMake(kGap6,CGRectGetMaxY(imageView.frame),frameX - kGap6,kWidth6);
            priceLabel.font = UIFont(15);
            view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth6);
        }else if (frameX == 414.0){
            priceLabel.frame = CGRectMake(kGap6p,CGRectGetMaxY(imageView.frame),frameX - kGap6p,kWidth6p);
            priceLabel.font = UIFont(16);
            view.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame),frameX,kWidth6p);
        }
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
       
        if ([self.push_type isEqualToString:@"verify_accept"]) {
            priceLabel.text = [NSString stringWithFormat:@"定金: %@",self.price];
        }else if( [self.push_type isEqualToString:@"trade_charge"]){
            priceLabel.text = [NSString stringWithFormat:@"差额: %@",self.price];
        }
        [self.contentView addSubview:priceLabel];
        
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(priceLabel.frame) ,frameX, 1)];
        imageView1.image = [UIImage imageNamed:@"720"];
        [self.contentView addSubview:imageView1];
        
        
        //NSLog(@"-----%@------%@",model.park_space,self.trade_state);
        
        if (![self.trade_state isEqualToString:@"1"]) {
           if ( ![[NSString stringWithFormat:@"%@",model.park_space] isEqualToString:@"0"]) {
              UIButton *confirButton = [UIButton buttonWithFrame:CGRectMake(50.4,CGRectGetMaxY(imageView1.frame)+20, frameX - 2*50.4, 40)  type:UIButtonTypeCustom title:@"支付" target:self action:@selector(payMoneyBtn:)];
               confirButton.backgroundColor = RGB(254, 156, 0);
               [confirButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
               confirButton.layer.masksToBounds = YES;
               confirButton.layer.cornerRadius = 20.0;
               [self.contentView addSubview:confirButton];
           }
      }
        

    }else{
        if (self.user_id) {
            if (![ruleStr isEqualToString:@"12"]) {
                UIButton *confirButton = [UIButton buttonWithFrame:CGRectMake(50.4,CGRectGetMaxY(_priceLabel.frame)+20, frameX - 2*50.4, 40)  type:UIButtonTypeCustom title:@"下订单" target:self action:@selector(comfirmBtn:)];
                confirButton.backgroundColor = RGB(254, 156, 0);
                [confirButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                confirButton.layer.masksToBounds = YES;
                confirButton.layer.cornerRadius = 20.0;
                [self.contentView addSubview:confirButton];
            }
        }
    }
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId{
    
    //radio.selected = NO;
    
    _methods = [radio.titleLabel.text intValue];
    
    _method = _methodArray[_methods][@"objectId"];
    
    _fieldString = _methodArray[_methods][@"field"];
    
    _hire_field = _fieldArray[_methods];

    if (![self.hire_field isEqualToString:@"hour_meter"]) {

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
                NSNumber *number =  [day calculateMoneyWithStartTime:_startBtn.titleLabel.text endTime:_endBtn.titleLabel.text andNoDays:nil andPrice:_priceArray[_methods]];
                _priceNum = number;
                if (number) {
                    _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
            }
        }
    }
}else{
    NSArray *array = [_priceArray[_methods] componentsSeparatedByString:@"/"];;
    NSString *str = [NSString stringWithFormat:@"%.1f",[[array firstObject] floatValue]/4.0];
    NSNumber *number = [NSNumber numberWithFloat:[str floatValue] ];
    _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
    }
}

//去订单
- (void)comfirmBtn:(UIButton *)btn{
    
    CalculateUnit *ca = [[CalculateUnit alloc]init];
    
    if (_method) {
        if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"]&&![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
            //计算时间
            NSString *price = _priceArray[_methods];
            _priceNum = [ca calculateMoneyWithStartTime:_startBtn.titleLabel.text   endTime:_endBtn.titleLabel.text andNoDays:nil andPrice:price];
        }
        
        //租用类型,判断是按天还是按月
        NSString *string = [[self.hire_field componentsSeparatedByString:@"_"] lastObject];
        
        if ([self.hire_field isEqualToString:@"hour_meter"]) {
            [self sendJpush];
        }else{
            if ([string isEqualToString:@"day"]) {
                [self sendJpush];
            }else{
                if ([ca.string intValue] >= 30) {
                    [self sendJpush];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您租用的时间少于一个月" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
        }

        }else{
            
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择租用方式和时间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
            
    }

}

- (void)sendJpush{
    
    NSString *startTimeStr;
    
    NSString *endTimeStr;
    
    NSArray *strartArr;
    
    NSArray *endArra;
    
    if ([StringChangeJson getValueForKey:kMobelNum]) {
        //计算价格
        if (![self.hire_field isEqualToString:@"hour_meter"]) {
            
            if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"] && ![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]){
                
                strartArr = [_startBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
                
                endArra = [_endBtn.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
                
                CalculateUnit *ca = [[CalculateUnit alloc]init];
                
                NSString *price = _priceArray[_methods];
                
                _priceNum = [ca calculateMoneyWithStartTime:_startBtn.titleLabel.text   endTime:_endBtn.titleLabel.text andNoDays:nil andPrice:price];
                
                startTimeStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",strartArr[0],strartArr[1],strartArr[2]];
                
                endTimeStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",endArra[0],endArra[1],endArra[2]];
            }
            
        }else{
            
            NSString *str = [NSString stringWithFormat:@"%.1f",[_priceArray[_methods] floatValue]/4.0];
            
            _priceNum = [NSNumber numberWithFloat:[str floatValue]];
            
            [_startBtn setTitle:@"" forState:UIControlStateNormal];
            
            [_endBtn setTitle:@"" forState:UIControlStateNormal];
            
            startTimeStr = @"";
            
            endTimeStr = @"";
        }
        
        if (![_device_token isEqualToString:@"web"]) {
            
            NSDictionary *extras;
            
            if ([self.hire_field isEqualToString:@"hour_meter"]) {
                
                extras = @{
                                    @"park_id":self.park_id,
                                    @"hire_method_id":_method,
                                    @"hire_method_field":_fieldString,
                                    @"own_device_token":[StringChangeJson getValueForKey:kRegistationID],
                                    @"own_device_type":@"ios",
                                    @"own_mobile":[StringChangeJson getValueForKey:kMobelNum],
                                    @"hire_start":[NSString stringWithFormat:@"%@",startTimeStr],
                                    @"hire_end":[NSString stringWithFormat:@"%@",endTimeStr],
                                    @"push_type":@"verify_request",@"mode":self.mode,
                                    @"address":self.addressLabel.text,
                                    @"price":_priceNum,
                                    @"hire_method_field":self.hire_field};
            }else{
                
                extras = @{
                                     @"park_id":self.park_id,
                                     @"hire_method_id":_method,
                                     @"hire_method_field":_fieldString,
                                     @"own_device_token":[StringChangeJson getValueForKey:kRegistationID],
                                     @"own_device_type":@"ios",
                                     @"own_mobile":[StringChangeJson getValueForKey:kMobelNum],
                                     @"hire_start":[NSString stringWithFormat:@"%@ ",startTimeStr],
                                     @"hire_end":[NSString stringWithFormat:@"%@  ",endTimeStr],
                                     @"push_type":@"verify_request",
                                     @"mode":self.mode,
                                     @"address":self.addressLabel.text,
                                     @"price":_priceNum,
                                    @"hire_method_field":self.hire_field};
                
            }
            
            NSDictionary *dictionary;
            
            if (self.user_id) {
                
                dictionary = @{
                                     @"mobilePhoneNumber":self.mobileNum,
                                     @"push_type":@"verify_request",
                                     @"device_token":self.device_token,
                                     @"device_type":self.device_type,
                                     @"user_id":self.user_id,
                                     @"extras":extras
                                     };
            }else{
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"不能租用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                [alertView show];
            }

            _jPushRequest  = [[KongCVHttpRequest alloc]initWithRequests:kToJPushUrl sessionToken:nil dictionary:dictionary andBlock:^(NSDictionary *data) {
                
                NSString *str = data[@"result"];
                
                NSData *datas = [str dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"msg"] isEqualToString:@"成功"]) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"发送成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }
                
            }];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"出租人接受不到信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
        }

    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请注册" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        
    }

}

//车位管理者
- (void)iphoneBtnClick:(UIButton *)btn{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_iphoneLabel.text];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.contentView addSubview:callWebview];
    
}

//辅助管理员电话
- (void)iphoneGroupBtnClick:(UIButton *)btn{
    
    NSString *iphone = _userGroupArr[btn.tag][@"mobilePhoneNumber"];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",iphone];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.contentView addSubview:callWebview];
}

//选择租用日期
- (void)chooseDayClick:(UIButton *)btn{
    
    //获取当前页面的controller
    UIViewController *controller = [self getCurrentVC];
    
    CalendarHomeViewController *home = [[CalendarHomeViewController alloc]init];
    
    [home setAirPlaneToDay:365*5 ToDateforString:nil];
    
    home.calendarblock = ^(CalendarDayModel *model){
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject]];
        
        [btn setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        
        [btn setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
        
        if (_method) {
            
            if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"] && ![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
                
                CalculateUnit *day = [[CalculateUnit alloc]init];
                
                NSNumber *number =  [day calculateMoneyWithStartTime:_startBtn.titleLabel.text endTime:[NSString stringWithFormat:@"%@",time] andNoDays:@"" andPrice:_priceArray[_methods]];
                
                _priceNum = number;
                
                if (number) {
                    
                    _priceLabel.text = [NSString stringWithFormat:@"总价:%@元",number];
                    
                }
            }
        }
    };
    
    [controller presentViewController:home animated:YES completion:nil];
    
   }

- (void)chooseEndDayClick:(UIButton *)endbtn{
    
    UIViewController *controller = [self getCurrentVC];
    
    CalendarHomeViewController *home = [[CalendarHomeViewController alloc]init];
    
    [home setAirPlaneToDay:365*5 ToDateforString:nil];
    
    home.calendarblock = ^(CalendarDayModel *model){
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject]];
        
        [endbtn setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        
        [endbtn setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
        
        if (_method) {
            if (![_startBtn.titleLabel.text isEqualToString:@"年     月     日"] && ![_endBtn.titleLabel.text isEqualToString:@"年     月     日"]) {
                
                CalculateUnit *day = [[CalculateUnit alloc]init];
                
                NSNumber *number =  [day calculateMoneyWithStartTime:[NSString stringWithFormat:@"%@",time]endTime:_endBtn.titleLabel.text andNoDays:@"" andPrice:_priceArray[_methods]];
                
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

- (void)getDay:(UIButton *)button{
    
    UIViewController *controller = [self getCurrentVC];
    
    CalendarHomeViewController *home = [[CalendarHomeViewController alloc]init];
    
    [home setAirPlaneToDay:365 ToDateforString:nil];
    
    home.calendarblock = ^(CalendarDayModel *model){
        
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        
        NSArray *array = [string componentsSeparatedByString:@"-"];
        
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject]];
        
        [button setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        
        [button setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];

    };
 
    [controller presentViewController:home animated:YES completion:nil];
    
}

//支付
- (void)payMoneyBtn:(UIButton *)btn{
        
    NSString *stringflag;
    if ([_field isEqualToString:@"hour_meter"]) {
        stringflag = @"0";
    }else{
        CalculateUnit *day = [[CalculateUnit alloc]init];

        if (self.hire_start && self.hire_end) {
            NSArray *startArr  = [self.hire_start componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
            NSArray *endArr  = [self.hire_end componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- "]];
            
            NSString *timeS = [NSString stringWithFormat:@"%@年%@月%@日",[startArr firstObject],startArr[1],startArr[2]];
            NSString *timeE = [NSString stringWithFormat:@"%@年%@月%@日",[endArr firstObject],endArr[1],endArr[2]];
            
            NSNumber *number =  [day calculateMoneyWithStartTime:timeS endTime:timeE andNoDays:nil andPrice:@"10/天"];
            
            NSString *string = day.string;
            if ([string intValue] > 1) {
                stringflag = @"1";
            }else{
                stringflag = @"0";
            }
        }else{
                stringflag = @"0";
        }
    }
        
    NSDictionary *dic = @{@"day":stringflag,@"hirer_id":self.user_id,@"unitPrice":self.unitPrice,@"curb_rate":_curb_rate,@"hire_field":self.field,@"mobile":self.mobileNum,@"type":self.device_type,@"token":self.device_token};
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"payButtonClicksss" object:nil userInfo:dic];
    
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


@end
