//
//  TypeViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/11/12.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "TypeViewController.h"

#import "PopoverView.h"

#import "ZHPickView.h"

#import "ZHXDataCache.h"

@interface TypeViewController ()<ZHPickViewDelegate,UITextFieldDelegate>
//全时背景View
@property (nonatomic,strong) UIView *qType;
//错时背景View
@property (nonatomic,strong) UIView *cTYpe;

@property (nonatomic,strong) UIButton *button;
//类型选择
@property (nonatomic,strong) UIButton *typeBtn;

@property (nonatomic,strong) UIView *scrView;
//判断选择全时 错时
@property (nonatomic,copy)   NSString *string;

//pickerView 小时数组
@property (nonatomic,strong) NSMutableArray *hoursArray;
//pickerView 分钟数组
@property (nonatomic,strong) NSMutableArray *minutesArray;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,strong) ZHPickView *pickView;

@property (nonatomic,strong) ZHPickView *endPickView;

//起始时间点
@property (nonatomic,strong) UIButton *startButton;
//结束时间点
@property (nonatomic,strong) UIButton *endButton;

//价格
@property (nonatomic,strong) UITextField *quanPriceField;

@property (nonatomic,strong) UITextField *cuoPriceField;

//全时名称
@property (nonatomic,strong) NSMutableArray *qsArray;
//错时名称
@property (nonatomic,strong) NSMutableArray *csArray;
//全时别名
@property (nonatomic,strong) NSMutableArray *qsfieldArray;
//错时别名
@property (nonatomic,strong) NSMutableArray *csfieldArray;
//类型选择objectId
@property (nonatomic,copy)   NSString *objectId;
//类型选择objectName
@property (nonatomic,copy)   NSString *objectName;

@property (nonatomic,copy)   NSString *fieldString;

@property (nonatomic,strong) UILabel *unitLabel; //单位

@property (nonatomic,strong) UILabel *unitLabel1;

@end

@implementation TypeViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:@"ThirteenPage"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [_pickView remove];
    
    [_endPickView remove];
    
    [MobClick endLogPageView:@"ThirteenPage"];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initNav:@"类型" andButton:@"fh" andColor:RGB(247, 247, 247)];
    
    [self prepareData];
    
    //布局UI
    [self layout];
    
    self.string = @"quan";
    
}

-(void)prepareData{

    ZHXDataCache *dataCache = [ZHXDataCache sharedCache];
    
    NSDictionary *dictionary = [dataCache getDataWithStringName:@"public"];
    
    NSArray *array = dictionary[@"result"];
    
    _qsArray = [NSMutableArray array];
    
    _csArray = [NSMutableArray array];
    
    _qsfieldArray = [NSMutableArray array];
    
    _csfieldArray = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        
        NSNumber *num = @0;
        
        if (dic[@"hire_type"] == num) {
            
            [_qsArray addObject:dic];
            
            [_qsfieldArray addObject:dic];
            
        }else{
            
            [_csArray addObject:dic];
            
            [_csfieldArray addObject:dic];
            
        }
    }
}

-(NSMutableArray *)hoursArray{

    if (_hoursArray == nil) {
        
        _hoursArray = [NSMutableArray array];
        
        for (int i = 1 ; i<=24; i++) {
            
            NSString *string = [NSString stringWithFormat:@"%d",i];
            
            [self.hoursArray addObject:string];
            
        }
        
    }
    return  _hoursArray;
}

-(NSMutableArray *)minutesArray{

    if (_minutesArray == nil) {
        
        _minutesArray  = [NSMutableArray array];
        
        for (int i= 0; i<60; i++) {
            
            NSString *string = [NSString stringWithFormat:@"%02d",i];
            
            [self.minutesArray addObject:string];
            
        }
    }
    return _minutesArray;
}

-(NSArray *)array{

    if (_array == nil) {
        
        _array = @[[NSArray arrayWithArray:self.hoursArray],@[@":"],[NSArray arrayWithArray:self.minutesArray]];
    }
    
    return _array;
}


- (void)layout{
    
    if (frameX == 320.0) {

        NSArray *titleArray  = @[@"全时",@"错时"];
        
        for (int i = 0; i<2; i++) {
            _button = [UIButton buttonWithFrame:CGRectMake((frameX/2)*i,64,frameX/2, 40) type:UIButtonTypeCustom title:titleArray[i] target:self action:@selector(buttonClick:)];
            
            [_button setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
            
            _button.tag = 100+i;
            
            _button.titleLabel.font = UIFont(15);
            
            [self.view addSubview:_button];
        }
        
        
        //滑动条
        _scrView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame), frameX/2, 2)];
         _scrView.backgroundColor = RGB(247, 156, 0);
        
        [self.view addSubview:_scrView];
        
        

        _qType = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+24, frameX, frameY - _button.frame.size.height-20)];
        _qType.backgroundColor = RGB(247, 247, 247);
            
        CGFloat gap = 8.9;
        CGFloat length = 111.4;
        CGFloat width = 35;
            
        //类型
        UIImageView *priImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 0, length, width)];
        priImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:priImage];
        
        UILabel *label = [UILabel labelWithFrame:CGRectMake(gap, 0,length,width) text:@"类型" Color:nil Font:UIFont(15)];
        label.textAlignment = NSTextAlignmentCenter;

        [_qType addSubview:label];
        
        
        //类型选择
        self.typeBtn = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+17.2, 0, 173.6, 35) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        self.typeBtn.tag = 100;
        [self.typeBtn setTitleColor: RGB(53, 53, 53) forState:UIControlStateNormal];
        [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        self.typeBtn.titleLabel.font = UIFont(16);
        self.typeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [self.typeBtn setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        self.typeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 130, 0, 0);
        [_qType addSubview:self.typeBtn];
            
            //价格
        UIImageView *priceImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label.frame)+6.25, length, width)];
        priceImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:priceImage];
        
        UILabel *priceLabel = [UILabel labelWithFrame:CGRectMake(gap, CGRectGetMaxY(label.frame)+5.3,length,width) text:@"价格" Color:nil Font:UIFont(16)];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        [_qType addSubview:priceLabel];
            
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+17.2, CGRectGetMaxY(self.typeBtn.frame)+5.3, 173.6, width)];
        imageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:imageView];
            
        _quanPriceField= [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+17.2, CGRectGetMaxY(self.typeBtn.frame)+5.3, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, width)];
        _quanPriceField.textAlignment = NSTextAlignmentRight;
        [_qType addSubview:_quanPriceField];
            
        //单位
        self.unitLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(_quanPriceField.frame)+5, CGRectGetMaxY(self.typeBtn.frame)+5.3, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, width) text:nil Color:nil Font:UIFont(15)];
        
        [_qType addSubview:self.unitLabel];
        
        
        //确认
        UIButton *yesButton = [UIButton buttonWithFrame:CGRectMake(78,178,164,40) type:UIButtonTypeCustom title:@"确      认" target:self action:@selector(yesButtonClic:)];
        yesButton.titleLabel.font = UIFont(15);
        [yesButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        yesButton.backgroundColor = RGB(255, 156, 0);
        yesButton.layer.masksToBounds = YES;
        yesButton.layer.cornerRadius = 5.0;
        [_qType addSubview:yesButton];
            
        /*
         错时******************************************************************************************************
        */
        _cTYpe = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+24, frameX, frameY - _button.frame.size.height-24)];
        _cTYpe.backgroundColor = RGB(247, 247, 247);
        [self.view addSubview:_cTYpe];
            
            //类型
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 0,length, width)];
        typeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [ _cTYpe addSubview:typeImage];
        
        UILabel *categoryLabel = [UILabel labelWithFrame:CGRectMake(gap, 0,length,width) text:@"类型" Color:nil Font:UIFont(15)];
        categoryLabel.textAlignment = NSTextAlignmentCenter;
        [_cTYpe addSubview:categoryLabel];
            
            //类型选择
        UIButton *type1 = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+17.2, 0, frameX - label.frame.size.width - 35, 35) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        type1.tag = 102;
        [type1 setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [type1 setTitleColor:RGB(53, 53, 53) forState:UIControlStateNormal];
        type1.titleLabel.font = UIFont(15);
        type1.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [type1 setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        type1.imageEdgeInsets = UIEdgeInsetsMake(0, 130, 0, 0);
        [_cTYpe addSubview:type1];
        
        //时间段
        UIImageView *timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap,CGRectGetMaxY(categoryLabel.frame)+5.3,length, width)];
        timeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [ _cTYpe addSubview:timeImage];
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(categoryLabel.frame)+5.3, length,width)];
        time.text = @"时间段";
        time.textColor = RGB(53,53, 53);
        time.textAlignment = NSTextAlignmentCenter;
        time.font = UIFont(15);
        time.layer.masksToBounds = YES;
        [_cTYpe addSubview:time];
        
        //错时时间段
        _startButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+17.2, CGRectGetMaxY(type1.frame)+5, 78.2 , 35) type:UIButtonTypeCustom title:nil target:self action:@selector(timeButton:)];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_startButton];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame)+2, CGRectGetMaxY(type1.frame)+5+_startButton.frame.size.height/2-0.5,12, 1)];
        lab.text = @"－";
        lab.textColor = RGB(53, 53, 53);
        [_cTYpe addSubview:lab];
        
        _endButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+6, CGRectGetMaxY(type1.frame)+5, 78.2 , 35) type:UIButtonTypeCustom title:nil target:self action:@selector(endTimeButton:)];
        [_endButton setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_endButton];
        
        //价格
        UIImageView *prImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap,CGRectGetMaxY(time.frame)+5.3,length, width)];
        prImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:prImage];
        
        UILabel *priceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(time.frame)+5.3,length,width)];
        priceLabel1.text = @"价格";
        //priceLabel1.textColor = RGB(133, 133, 133);
        priceLabel1.textAlignment = NSTextAlignmentCenter;
        priceLabel1.font = UIFont(15);
        [_cTYpe addSubview:priceLabel1];
        
        
        UIImageView *cimageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+17.2, CGRectGetMaxY(time.frame)+5.3, 173.6, width)];
        cimageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:cimageView];
        
        _cuoPriceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel1.frame)+17.2, CGRectGetMaxY(time.frame)+5.3, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, 35)];
        _cuoPriceField.textAlignment = NSTextAlignmentRight;
        [_cTYpe addSubview:_cuoPriceField];
        
        //单位
        _unitLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cuoPriceField.frame)-0.5, CGRectGetMaxY(time.frame)+5.3, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, 35)];
        _unitLabel1.textColor = RGB(53,53, 53);
        _unitLabel1.layer.cornerRadius = 3.0;
        _unitLabel1.font = UIFont(15);
        [_cTYpe addSubview:_unitLabel1];
            
            
            //确认
        UIButton *yesButton1 = [UIButton buttonWithFrame:CGRectMake(78,178,164,40) type:UIButtonTypeCustom title:@"确      认" target:self action:@selector(yesButtonClic:)];
        yesButton1.titleLabel.font = UIFont(15);
        [yesButton1 setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        yesButton1.backgroundColor = RGB(255, 156, 0);
        yesButton1.layer.masksToBounds = YES;
        yesButton1.layer.cornerRadius = 5.0;
        [_cTYpe addSubview:yesButton1];
        [self.view addSubview:_qType];

        
        
    }else if( frameX == 414.0){
        
 /************************************************************************************************************/
        
        NSArray *imgArray = @[@"quanshi@2x",@"cs@2x"];
        for (int i = 0; i<2; i++) {
            _button = [UIButton buttonWithFrame:CGRectMake((frameX /2)*i,64,frameX/2, 50.7)  type:UIButtonTypeCustom title:nil target:self action:@selector(buttonClick:)];
            [_button setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            _button.tag = 100+i;
            _button.titleLabel.font = UIFont(16);
            [self.view addSubview:_button];
        }
        
        //滑动条
        _scrView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame), frameX/2, 2)];
        _scrView.backgroundColor = RGB(255, 156, 0);
        [self.view addSubview:_scrView];
        
        _qType = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_button.frame)+33.8, frameX, frameY - _button.frame.size.height-30.8)];
        _qType.backgroundColor = RGB(247, 247, 247);
        
        CGFloat gap = 11.5;
        CGFloat length = 144.6;
        CGFloat width = 45.4;
        
        //类型
        UIImageView *typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(gap,0,length, width)];
        typeImageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:typeImageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(gap, 0,length,width)];
        label.text = @"类 型";
        label.textColor = RGB(53, 53, 53);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = UIFont(16);
        [_qType addSubview:label];
        
        //类型选择
        UIImageView *timageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+21,0,225.4, width)];
        timageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:timageView];
        
        UIButton *type = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+21, 0, 225.4,width) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        self.typeBtn = type;
        self.typeBtn.tag = 100;
        [type setTitleColor:RGB(53,53,53) forState:UIControlStateNormal];
        type.titleLabel.font = UIFont(16);
        type.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        [type setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        type.imageEdgeInsets = UIEdgeInsetsMake(0, 160, 0, 0);
        [_qType addSubview:type];
        
        //价格
        UIImageView *pimageView = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label.frame)+6.9,length, width)];
        pimageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:pimageView];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label.frame)+6.9,length,width)];
        priceLabel.text = @"价 格";
        priceLabel.textColor = RGB(53,53,53);
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = UIFont(16);
        [_qType addSubview:priceLabel];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(type.frame)+6.9, 225.4, width)];
        imageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:imageView];
        
        _quanPriceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(type.frame)+6.9, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2,width)];
        _quanPriceField.delegate = self;
        _quanPriceField.font = UIFont(16);
        _quanPriceField.textAlignment = NSTextAlignmentRight;
        [_qType addSubview:_quanPriceField];
        //单位
        _unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_quanPriceField.frame)-0.5, CGRectGetMaxY(type.frame)+6.9, (frameX - CGRectGetMaxX(priceLabel.frame) - 28)/2,width)];
        _unitLabel.textColor = RGB(53, 53, 53);
        _unitLabel.font = UIFont(16);
        _unitLabel.layer.cornerRadius = 3.0;
        [_qType addSubview:_unitLabel];
        
        
        //确认
        UIButton *yesButton = [UIButton buttonWithFrame:CGRectMake(frameX/2 - 212/2,CGRectGetMaxY(priceLabel.frame)+30,212,45)  type:UIButtonTypeCustom title:@"确           认" target:self action:@selector(yesButtonClic:)];
        yesButton.titleLabel.font = UIFont(16);
        [yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        yesButton.backgroundColor = RGB(255, 156, 0);
        yesButton.layer.masksToBounds = YES;
        yesButton.layer.cornerRadius = 13.0;
        [_qType addSubview:yesButton];
        
        
    /*
     *
     错时
     */
        _cTYpe = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+33.8, frameX, frameY - _button.frame.size.height-30.8)];
        _cTYpe.backgroundColor = RGB(247, 247, 247);
        [self.view addSubview:_cTYpe];
        
        //类型
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 0, length, width)];
        typeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:typeImage];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(gap, 0,length, width)];
        label1.text = @"类型";
        label1.textColor = RGB(53,53, 53);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = UIFont(16);
        [_cTYpe addSubview:label1];
        
        //类型选择
        UIButton *type1 = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+21, 0,225.4,width) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        type1.tag = 102;
        [type1 setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [type1 setTitleColor:RGB(53,53,53) forState:UIControlStateNormal];
        type1.titleLabel.font = UIFont(16);
        type1.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        [type1 setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        type1.imageEdgeInsets = UIEdgeInsetsMake(0, 160, 0, 0);
        [_cTYpe addSubview:type1];
        
        //时间段
        UIImageView *timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label1.frame)+6.9, length, width)];
        timeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:timeImage];
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label1.frame)+6.9, length,width)];
        time.text = @"时间段";
        time.textColor = RGB(53,53,53);
        time.textAlignment = NSTextAlignmentCenter;
        time.font = UIFont(16);
        [_cTYpe addSubview:time];
        
        _startButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+21, CGRectGetMaxY(type1.frame)+6.9,100 ,width) type:UIButtonTypeCustom title:nil target:self action:@selector(timeButton:)];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"shijian_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_startButton];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame)+7.5, CGRectGetMaxY(type1.frame)+16.9, 10, 20)];
        timeLabel.text = @"－";
        timeLabel.textColor = RGB(53,53,53);
        [_cTYpe addSubview:timeLabel];
        
        _endButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame)+25, CGRectGetMaxY(type1.frame)+6.9, 100, width) type:UIButtonTypeCustom title:nil target:self action:@selector(endTimeButton:)];
        [_endButton setBackgroundImage:[UIImage imageNamed:@"shijian_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_endButton];
        
        
        //价格
        UIImageView *priceImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(time.frame)+6.9, length, width)];
        priceImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:priceImage];
        
        UILabel *priceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(time.frame)+6.9, length,width)];
        priceLabel1.text = @"价格";
        priceLabel1.textColor = RGB(53,53,53);
        priceLabel1.textAlignment = NSTextAlignmentCenter;
        priceLabel1.font = UIFont(16);
        [_cTYpe addSubview:priceLabel1];
        
        
        UIImageView *cimageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(time.frame)+6.9, 225.4, width)];
        cimageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:cimageView];
        
        _cuoPriceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(time.frame)+6.9, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, width)];
        _cuoPriceField.font = UIFont(16);
        _cuoPriceField.textColor = RGB(53, 53, 53);
        _cuoPriceField.textAlignment = NSTextAlignmentRight;

        [_cTYpe addSubview:_cuoPriceField];
        //单位
        _unitLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cuoPriceField.frame)-0.5, CGRectGetMaxY(time.frame)+6.9, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2,width)];
        _unitLabel1.font = UIFont(16);
        //_unitLabel1.text = @"元/天";
        _unitLabel1.textColor = RGB(53, 53, 53);
        _unitLabel1.layer.cornerRadius = 3.0;
        [_cTYpe addSubview:_unitLabel1];
        
        
        //确认
        UIButton *yesButton1 = [UIButton buttonWithFrame:CGRectMake(frameX/2 - 212/2,CGRectGetMaxY(priceLabel.frame)+131,212, 45) type:UIButtonTypeCustom title:@"确           认" target:self action:@selector(yesButtonClic:)];
        yesButton1.titleLabel.font = UIFont(16);
        [yesButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        yesButton1.backgroundColor = RGB(255, 156, 0);
        yesButton1.layer.masksToBounds = YES;
        yesButton1.layer.cornerRadius = 13.0;
        [_cTYpe addSubview:yesButton1];

        [self.view addSubview:_qType];
        
    }else if (frameX == 375.0){
 
        
        NSArray *imgArray = @[@"quanshi@2x",@"cs@2x"];
        
        for (int i = 0; i<2; i++) {
            
            _button = [UIButton buttonWithFrame:CGRectMake((frameX /2)*i,64,frameX/2, 50.7) type:UIButtonTypeCustom title:nil target:self action:@selector(buttonClick:)];
            
            [_button setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            
            _button.tag = 100+i;
            
            _button.titleLabel.font = UIFont(15);
            
            [self.view addSubview:_button];
            
        }
        
        //滑动条
        _scrView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame), frameX/2, 2)];
        _scrView.backgroundColor = RGB(255, 156, 0);
        [self.view addSubview:_scrView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignResponder)];
        [_scrView addGestureRecognizer:tap];
        
        _qType = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+27.8, frameX, frameY - _button.frame.size.height-27.8)];
        _qType.backgroundColor = RGB(247, 247, 247);
        
        CGFloat gap = 10.4;
        CGFloat length = 130.6;
        CGFloat width = 40.9;
        
        
        //类型
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 0,length, width)];
        typeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:typeImage];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(gap, 0,length,width)];
        label.text = @"类 型";
        label.textColor = RGB(53,53,53);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = UIFont(15);
        [_qType addSubview:label];
        
        //类型选择
        UIButton *type = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+20, 0, 203.5,width) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        self.typeBtn = type;
        self.typeBtn.tag = 100;
        [type setTitleColor:RGB(53, 53,53) forState:UIControlStateNormal];
        [type setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        type.titleLabel.font = UIFont(15);
        type.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [type setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        type.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, 0);
        [_qType addSubview:type];
        
        //价格
        UIImageView *priceImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(type.frame)+6.25,length, width)];
        priceImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:priceImage];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label.frame)+6.25,length,width)];
        priceLabel.text = @"价 格";
        priceLabel.textColor = RGB(53,53,53);
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = UIFont(16);
        [_qType addSubview:priceLabel];
        
        
        
        UIImageView *cimageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(type.frame)+6.25, 203.5, width)];
        cimageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_qType addSubview:cimageView];
        
        _quanPriceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(type.frame)+6.25, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2,width)];
        _quanPriceField.font = UIFont(16);
        _quanPriceField.textAlignment = NSTextAlignmentRight;
        [_qType addSubview:_quanPriceField];
        
        //单位
        _unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_quanPriceField.frame)-0.5, CGRectGetMaxY(type.frame)+6.25, (frameX - CGRectGetMaxX(priceLabel.frame) - 28)/2,width)];
        _unitLabel.textColor = RGB(53, 53, 53);
        _unitLabel.font = UIFont(16);
        _unitLabel.layer.cornerRadius = 3.0;
        [_qType addSubview:_unitLabel];
        
        
        //确认
        UIButton *yesButton = [UIButton buttonWithFrame:CGRectMake(frameX/2 - 212/2,CGRectGetMaxY(priceLabel.frame)+50,212, 45) type:UIButtonTypeCustom title:@"确           认" target:self action:@selector(yesButtonClic:)];
        yesButton.titleLabel.font = UIFont(15);
        [yesButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        yesButton.backgroundColor = RGB(255, 156, 0);
        yesButton.layer.masksToBounds = YES;
        yesButton.layer.cornerRadius = 18.0;
        [_qType addSubview:yesButton];
        
        
        /*
         *
         错时
         */
        _cTYpe = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame)+27.8, frameX, frameY - _button.frame.size.height-27.8)];
        _cTYpe.backgroundColor = RGB(247, 247, 247);
        [self.view addSubview:_cTYpe];
        
        //类型
        
        UIImageView *tyImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, 0, length, width)];
        tyImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:tyImage];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(gap, 0,length, width)];
        label1.text = @"类型";
        label1.textColor = RGB(53,53,53);
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = UIFont(15);
        [_cTYpe addSubview:label1];
        
        //类型选择
        UIButton *type1 = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+21, 0,203.5,width) type:UIButtonTypeCustom title:@"类型选择"target:self action:@selector(tpyeChoose:)];
        type1.tag = 102;
        [type1 setTitleColor:RGB(53, 53, 53) forState:UIControlStateNormal];
        [type1 setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        type1.titleLabel.font = UIFont(15);
        type1.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        type1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [type1 setImage:[UIImage imageNamed:@"jt@2x"] forState:UIControlStateNormal];
        type1.imageEdgeInsets = UIEdgeInsetsMake(0, 140, 0, 0);
        [_cTYpe addSubview:type1];
        
        //时间段
        UIImageView *timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label1.frame)+6.25, length, width)];
        timeImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:timeImage];
        
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(label1.frame)+6.25, length,width)];
        time.text = @"时间段";
        time.textColor = RGB(53, 53, 53);
        time.textAlignment = NSTextAlignmentCenter;
        time.font = UIFont(15);
        [_cTYpe addSubview:time];
        
        _startButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+21, CGRectGetMaxY(type1.frame)+6.25,91.2 ,width) type:UIButtonTypeCustom title:nil target:self action:@selector(timeButton:)];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_startButton];
        
        UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame)+5, CGRectGetMaxY(type1.frame)+16, 10, 20)];
        la.text = @"—";
        la.textColor = RGB(53, 53, 53);
        [_cTYpe addSubview:la];
        
        _endButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(_startButton.frame)+20.4, CGRectGetMaxY(type1.frame)+6.25,91.2 ,width) type:UIButtonTypeCustom title:nil target:self action:@selector(endTimeButton:)];
        [_endButton setBackgroundImage:[UIImage imageNamed:@"kuang_@3x"] forState:UIControlStateNormal];
        [_cTYpe addSubview:_endButton];
        
        
        //价格
        UIImageView *priImage = [[UIImageView alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(time.frame)+6.25, length, width)];
        priImage.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:priImage];
        
        UILabel *priceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(gap, CGRectGetMaxY(time.frame)+6.25, length,width)];
        priceLabel1.text = @"价格";
        priceLabel1.textColor = RGB(53, 53, 53);
        priceLabel1.textAlignment = NSTextAlignmentCenter;
        priceLabel1.font = UIFont(15);
        [_cTYpe addSubview:priceLabel1];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(time.frame)+6.25, 203.5, width)];
        imageView.image = [UIImage imageNamed:@"kuang_@3x"];
        [_cTYpe addSubview:imageView];
        
        _cuoPriceField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+21, CGRectGetMaxY(time.frame)+6.25, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2, width)];
        _cuoPriceField.font = UIFont(15);
        _cuoPriceField.textColor = RGB(53, 53, 53);
        _cuoPriceField.textAlignment = NSTextAlignmentRight;
        [_cTYpe addSubview:_cuoPriceField];
        //单位
        _unitLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_quanPriceField.frame)-0.5, CGRectGetMaxY(time.frame)+6.25, (frameX - CGRectGetMaxX(priceLabel.frame) - 25)/2,width)];
        _unitLabel.font = UIFont(15);
        _unitLabel1.textColor = RGB(53, 53, 53);
        _unitLabel1.layer.cornerRadius = 3.0;
        [_cTYpe addSubview:_unitLabel1];
        
        
        //确认
        UIButton *yesButton1 = [UIButton buttonWithFrame:CGRectMake(frameX/2 - 212/2,CGRectGetMaxY(priceLabel.frame)+50,212, 45) type:UIButtonTypeCustom title:@"确           认" target:self action:@selector(yesButtonClic:)];
        yesButton1.titleLabel.font = UIFont(15);
        [yesButton1 setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        yesButton1.backgroundColor = RGB(255, 156, 0);
        yesButton1.layer.masksToBounds = YES;
        yesButton1.layer.cornerRadius = 18.0;
        [_cTYpe addSubview:yesButton1];
        
        [self.view addSubview:_qType];
    }

}

- (void)resignResponder{
    [_quanPriceField resignFirstResponder];
    [_cuoPriceField resignFirstResponder];
    
}


//类型选择
- (void)tpyeChoose:(UIButton *)button{
    
    CGPoint point;
    
    if (frameX == 320.0) {
        point = CGPointMake(button.frame.origin.x + button.frame.size.width/2, button.frame.origin.y + button.frame.size.height+140);
    }else if (frameX == 414.0){
        point = CGPointMake(button.frame.origin.x + button.frame.size.width/2, button.frame.origin.y + button.frame.size.height+160);
    }else if (frameX == 375.0){
        point = CGPointMake(button.frame.origin.x + button.frame.size.width/2, button.frame.origin.y + button.frame.size.height+153);
    }
    
    switch (button.tag - 100) {
        case 0:
        {
            NSMutableArray *methodArray = [NSMutableArray array];
            NSMutableArray *objectArray    = [NSMutableArray array];
            NSMutableArray *fieldArray         = [NSMutableArray array];
            for (NSDictionary *dictionary in _qsArray) {
                [methodArray addObject:dictionary[@"method"]];
                [objectArray addObject:dictionary[@"objectId"]];
                [fieldArray addObject:dictionary[@"field"]];
            }

            NSArray *quanTitles = [NSArray arrayWithArray:methodArray];
            
            PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:quanTitles images:nil];
            
            pop.selectRowAtIndex = ^(NSInteger index){
                
                if (_fieldArraymmmmm.count != 0) {
                    for (int i = 0; i < _fieldArraymmmmm.count; i++) {
                        NSString *string = _fieldArraymmmmm[i];
                        if (![string isEqualToString:fieldArray[index]]) {
                            
                            _fieldString = fieldArray[index];
                            _objectId = objectArray[index];
                            _objectName = quanTitles[index];
                            
                            if ([quanTitles[index] isEqualToString:@"全时/天"]) {
                                _unitLabel.text = @"/天";
                            }else if ([quanTitles[index] isEqualToString:@"全时/月"]){
                                _unitLabel.text = @"/月";
                            }
                            
                            [button setTitle:quanTitles[index] forState:UIControlStateNormal];
                            
                        }else{
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您已选择过此种出租方式" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
                        }
                    }
                }else if(_fieldArraymmmmm.count == 0){
           
                    _fieldString = fieldArray[index];
                    _objectId = objectArray[index];
                    _objectName = quanTitles[index];
                    if ([quanTitles[index] isEqualToString:@"全时/天"]) {
                        _unitLabel.text = @"/天";
                    }else if ([quanTitles[index] isEqualToString:@"全时/月"]){
                        _unitLabel.text = @"/月";
                    }
                    
                    [button setTitle:quanTitles[index] forState:UIControlStateNormal];
                }

            };
        
            [pop show];
            
            pop.backgroundColor = RGB(247, 247, 247);
        }
            break;
        case 2:
        {
            
            NSMutableArray *methodArray = [NSMutableArray array];
            NSMutableArray *objectArray    = [NSMutableArray array];
            NSMutableArray *fieldArray                   = [NSMutableArray array];
            for (NSDictionary *dictionary in _csArray) {
                [methodArray addObject:dictionary[@"method"]];
                [objectArray addObject:dictionary[@"objectId"]];
                [fieldArray addObject:dictionary[@"field"]];
            }
            NSArray *Titles = [NSArray arrayWithArray:methodArray];
            PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:Titles images:nil];
            pop.selectRowAtIndex = ^(NSInteger index){

                if (_fieldArraymmmmm.count != 0) {
                    for (int i = 0; i < _fieldArraymmmmm.count; i++) {
                        NSString *string = _fieldArraymmmmm[i];
                        if ([string isEqualToString:fieldArray[index]]) {
                            
                        }else{
                            
                            _fieldString = fieldArray[index];
                            _objectId = objectArray[index];
                            _objectName = Titles[index];
                            
                            [button setTitle:Titles[index] forState:UIControlStateNormal];
                            
                            if ([Titles[index] isEqualToString:@"错时夜间/天"]  ||  [Titles[index] isEqualToString:@"错时日间/天" ]) {
                                _unitLabel1.text = @"/天";
                            }else{
                                _unitLabel1.text = @"/月";
                            }
                        }
                    }
                }else if(_fieldArraymmmmm.count == 0){
      
                    _fieldString = fieldArray[index];
                    _objectId = objectArray[index];
                    _objectName = Titles[index];
                    
                    [button setTitle:Titles[index] forState:UIControlStateNormal];
                    
                    if ([Titles[index] isEqualToString:@"错时夜间/天"]  ||  [Titles[index] isEqualToString:@"错时日间/天" ]) {
                        _unitLabel1.text = @"/天";
                    }else{
                        _unitLabel1.text = @"/月";
                    }
                }
            };
            pop.backgroundColor = RGB(247, 247, 247);
            
            [pop show];
        }
            break;
            
        default:
            break;
    }
}

//全时 错时选择
- (void)buttonClick:(UIButton *)button{
    
    switch (button.tag - 100) {
        case 0:
        {
            _string = @"quan";
            [UIView animateWithDuration:0.2 animations:^{
                
                if (frameX == 375.0) {
                    _scrView.center = CGPointMake(93.75, CGRectGetMaxY(_button.frame)+1);
                }else if (frameX == 320.0){
                    _scrView.center = CGPointMake(80, CGRectGetMaxY(_button.frame)+1);
                }else if (frameX == 414.0){
                    _scrView.center = CGPointMake(103.5, CGRectGetMaxY(_button.frame)+1);
                }
                
                [self.view bringSubviewToFront:_qType];
                 //NSLog(@"%@",_string);
            } completion:nil];
        }
            break;
        case 1:
        {
            _string = @"cuo";
            [UIView animateWithDuration:0.2 animations:^{
                
                if (frameX == 375.0) {
                    _scrView.center = CGPointMake(283.25, CGRectGetMaxY(_button.frame)+1);
                }else if (frameX == 320.0){
                    _scrView.center = CGPointMake(240, CGRectGetMaxY(_button.frame)+1);
                }else if (frameX == 414.0){
                    _scrView.center = CGPointMake(310.5, CGRectGetMaxY(_button.frame)+1);
                }
                
                 [self.view bringSubviewToFront:_cTYpe];
    
            } completion:nil];
            
        }
            break;
            
        default:
            break;
    }
    
}

//确定返回
- (void)yesButtonClic:(UIButton *)button{
    
    if (![_quanPriceField.text isEqualToString:@"0"] || ![_cuoPriceField.text isEqualToString:@"0"]) {
        
        NSString *isHave;
        
        if (_fieldArraymmmmm.count != 0) {
            
            for (int i = 0; i < _fieldArraymmmmm.count; i++) {
                
                NSString *string = _fieldArraymmmmm[i];
                
                if ([string isEqualToString:_fieldString]) {
                    
                    isHave = @"1";
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您已选择过此种出租方式" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                    return;
                }else if (![string isEqualToString:_fieldString]){
                    
                    isHave = @"0";
                    
                }
            }
            
            
            if ([isHave isEqualToString:@"0"]) {
                NSDictionary *dictionary = [NSDictionary dictionary];
                
                if ([_string isEqualToString:@"quan"]) {
                    
                    if ([self.typeBtn.titleLabel.text isEqualToString:@"类型选择"] || _quanPriceField.text.length == 0 ) {
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alertView show];
                        
                    }else{
                        
                        dictionary =  @{@"time":_string,@"type":_objectId,@"price":[NSString stringWithFormat:@"%@%@",_quanPriceField.text,_unitLabel.text],@"objectName":_objectName,@"hire_time":@"0",@"field":_fieldString};
                     
                        
                        _block(dictionary);
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                }else if ([_string isEqualToString:@"cuo"]){
                    
                    if ( _cuoPriceField.text.length == 0 || _startButton.titleLabel.text.length == 0 || _endButton.titleLabel.text.length == 0  ) {
                        
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [alertView show];
                        
                    }else{
                        
                        NSString *string = [NSString stringWithFormat:@"%@－%@",_startButton.titleLabel.text,_endButton.titleLabel.text];
                        
                        dictionary = @{@"time":_string,@"type":_objectId,@"hire_time":string,@"price":[NSString stringWithFormat:@"%@%@",_cuoPriceField.text,_unitLabel1.text],@"objectName":_objectName,@"field":_fieldString};
                       
                        _block(dictionary);
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                }
            }else if ([isHave isEqualToString:@"1"]){
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您已选择过此种出租方式" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            
        }else{
            
            NSDictionary *dictionary = [NSDictionary dictionary];
         
            if ([_string isEqualToString:@"quan"]) {
                
                if ([self.typeBtn.titleLabel.text isEqualToString:@"类型选择"] || _quanPriceField.text.length == 0 ) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }else{
                    
                    dictionary =  @{@"time":_string,@"type":_objectId,@"price":[NSString stringWithFormat:@"%@%@",_quanPriceField.text,_unitLabel.text],@"objectName":_objectName,@"hire_time":@"0",@"field":_fieldString};
                    
                    _block(dictionary);
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }else if ([_string isEqualToString:@"cuo"]){
                
                if ( _cuoPriceField.text.length == 0 || _startButton.titleLabel.text.length == 0 || _endButton.titleLabel.text.length == 0  ) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请填写信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alertView show];
                    
                }else{
                    NSString *string = [NSString stringWithFormat:@"%@－%@",_startButton.titleLabel.text,_endButton.titleLabel.text];
                    
                    dictionary = @{@"time":_string,@"type":_objectId,@"hire_time":string,@"price":[NSString stringWithFormat:@"%@%@",_cuoPriceField.text,_unitLabel1.text],@"objectName":_objectName,@"field":_fieldString};
                    
                    _block(dictionary);
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            }
        }
    }

}

//起始错时选择
- (void)timeButton:(UIButton *)btn{

    [_pickView remove];
    
    _pickView  = [[ZHPickView alloc]initPickviewWithArray:self.array isHaveNavControler:NO];
    
    _pickView.delegate=self;
    
    [_pickView show];
}


//结束时间选择
- (void)endTimeButton:(UIButton *)button{
    
    [_pickView remove];
    
    _endPickView  = [[ZHPickView alloc]initPickviewWithArray:self.array isHaveNavControler:NO];
    
    _endPickView.delegate=self;
    
    [_endPickView show];
    
}

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if ([pickView isEqual:_endPickView]) {
        
        [_endButton setTitle:[NSString stringWithFormat:@"%@",resultString] forState:UIControlStateNormal];
        
    }else{
        
        [_startButton setTitle:[NSString stringWithFormat:@"%@",resultString] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark --- <UITextFieldDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_quanPriceField resignFirstResponder];
    
    [_cuoPriceField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_quanPriceField resignFirstResponder];
    
    [_cuoPriceField resignFirstResponder];
    
}

@end
