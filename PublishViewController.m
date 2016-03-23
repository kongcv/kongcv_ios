//
//  PublishViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/11/9.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "PublishViewController.h"

#import "YiSwitch.h"

#import "TypeViewController.h"

#import "TPLChooseItemsView.h"

#import "CalendarViewController.h"

#import "CalendarHomeViewController.h"

#import <AMapSearchKit/AMapSearchKit.h>

#import "LoginViewController.h"

#import "ListModel.h"

#import "ListTableViewCell.h"

#import "SearchParkViewController.h"

#import "TimeChange.h"

#import "ZHXDataCache.h"

#define  gap 3.5
#define kHeight 34
#define kScale 1.2

@interface PublishViewController ()<AMapSearchDelegate,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{

    TPLChooseItemsView *_chooseItemsView;//多选
    
    CalendarHomeViewController *_chvc; //日历
    
}

@property (nonatomic,strong) AMapSearchAPI *search;

@property (nonatomic,strong) UIScrollView *scrollView;
//车位门禁描述
@property (nonatomic,strong) UITextView *entranceTextView;
//车位描述
@property (nonatomic,strong) UITextView *describeTextView;
//地址
@property (nonatomic,strong) UITextField *addressText;
//补充详细地址
@property (nonatomic,strong) UITextField *detailAddText;
//车位面积
@property (nonatomic,strong) UITextField *areaTextField;
//车位限高
@property (nonatomic,strong) UITextField *heightTextField;
//车牌尾号
@property (nonatomic,strong) UITextField *numTextField;
//是否正规车位
@property (nonatomic) BOOL   normalNum;

@property (nonatomic,strong) NSNumber *groundNum;

@property (nonatomic,strong) UIButton *groundButton;//地上地下

//地上地下背景图
@property (nonatomic,strong) UIView *gView;
//非出租日背景图
@property (nonatomic,strong) UIView *dayView;
//非出租日Button
@property (nonatomic,strong) UIButton *dayButton;

@property (nonatomic,strong) UIButton *StimeButton;//起始时间

@property (nonatomic,strong) UIButton *EtimeButton;//结束时间

@property (nonatomic,strong) NSDictionary *dictioary; //信息

@property (nonatomic,strong) NSDictionary *typeDic; //类型信息

@property (nonatomic,strong) KongCVHttpRequest *request;

@property (nonatomic,strong) NSMutableArray *priceArray;

@property (nonatomic,strong) NSMutableArray *hire_time;

@property (nonatomic,strong) NSMutableArray *hire_method_id;

@property (nonatomic,strong) NSMutableArray *fieldArray;
//添加出租类型按钮
@property (nonatomic,strong) UIButton *addButton;

//发布按钮
@property (nonatomic,strong) UIButton *pubLishBtn;

@property (nonatomic,strong) NSMutableArray *objectName;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSNumber *laNum;

@property (nonatomic,strong) NSNumber *loNUm;

@property (nonatomic,strong) NSMutableArray *changeArray;

//城市label
@property (nonatomic,strong) UILabel *addressLabel;
//充当占位placeholder  lalabel
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *deLabel;
//出租类型背景
@property (nonatomic,strong) UIView *categoryBgView;

@end

@implementation PublishViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Twelev"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Twelev"];

}

/*
 地址 城市 详细地址 坐标 地上地下  社区 时间 出租类型
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //布局UI
    [self layoutUI];

    _dataSource = [NSMutableArray array];
    
    _priceArray = [NSMutableArray array];
    
    _hire_time = [NSMutableArray array];
    
    _hire_method_id = [NSMutableArray array];
    
    _objectName  = [NSMutableArray array];
    
    _fieldArray       = [NSMutableArray array];
    
    //判断是否是从车位管理跳转的
    if (self.string) {
        
        [self prepareData];
        
    }else{
        
        [self initNav:@"个人车位"  andColor:RGB(247, 156, 0)];
        
    }
    
   
}


- (void)prepareData{

    [self initNav:@"个人车位" andButton:@"fh" andColor:RGB(247, 156, 0)];
    
    ZHXDataCache *dataCache = [ZHXDataCache sharedCache];
    
    NSDictionary *dictionary = [dataCache getDataWithStringName:@"public"];
    
    NSArray *array = dictionary[@"result"];
    
    NSMutableArray *methodArray = [NSMutableArray array];
    
    NSMutableArray *nameArray = [NSMutableArray array];
    
    NSMutableArray *hire_fieldArray = [NSMutableArray array];
    
    if (array) {
        
        for (NSDictionary *dic in array) {
            
            NSString *string = dic[@"objectId"];
            
            [methodArray addObject:string];
            
            [nameArray addObject:dic[@"method"]];
            
            [hire_fieldArray addObject:dic[@"field"]];
            
        }
        
    }
    
    self.tabBarController.tabBar.hidden = NO;
    
    //判断是否是从车位管理跳转的
    
    if (array) {
        
        NSString *string = [NSString stringWithFormat:@"%@",self.model.hire_method];
        
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *arrayMethod   = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _changeArray = [NSMutableArray array];
        
        for (int i = 0; i<self.model.hire_price.count; i++) {
            
            NSString *objectName;
            
            NSString *field;
            
            NSString *time;
            
            for (int j=0 ; j<nameArray.count; j++) {
                
                if ([arrayMethod[i][@"objectId"] isEqualToString:methodArray[j]]) {
                    
                    objectName = nameArray[j];
                    
                    field = hire_fieldArray[j];
                    
                    if ([[objectName substringToIndex:1] isEqualToString:@"全"]) {
                        
                        time = @"quan" ;
                        
                    }else{
                        
                        time = @"cuo";
                        
                    }
                }
            }
            
            NSDictionary *dic = @{@"field":[NSString stringWithFormat:@"%@",field],@"hire_time":[NSString stringWithFormat:@"%@",self.model.hire_time[i]],@"objectName":[NSString stringWithFormat:@"%@",objectName],@"price":[NSString stringWithFormat:@"%@",self.model.hire_price[i]] ,@"time":[NSString stringWithFormat:@"%@",time],@"type":[NSString stringWithFormat:@"%@",arrayMethod[i][@"objectId"]]};
            
            [_changeArray addObject:dic];
            
            [_priceArray addObject:self.model.hire_price[i]];
            
            [_fieldArray addObject:field];
            
            [_hire_method_id addObject:arrayMethod[i][@"objectId"]] ;
            
            [_hire_time addObject:self.model.hire_time[i]];
            
            [_objectName addObject:objectName];
            
        };
        
        for (NSDictionary *dic in _changeArray) {
            
            ListModel *model = [ListModel modelWithDic:dic];
            
            [_dataSource addObject:model];
            
            [self.tableView reloadData];
        }
        
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryBgView.frame)+10, frameX,45*_dataSource.count);
        
        _pubLishBtn.frame = CGRectMake(50,CGRectGetMaxY(_tableView.frame)+10, frameX-100, 50);
        
    }
}

-(UITableView *)tableView{

    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] init];
        
        _tableView.backgroundColor = RGB(247, 247, 247);
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.scrollEnabled = NO;
        
        [self.scrollView addSubview:_tableView];
        
    }
    
    return _tableView;
}


-(UIScrollView *)scrollView{

    if (_scrollView == nil) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, frameX,frameY - 64)];
        
        self.scrollView.backgroundColor = RGB(247,247,247);
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.scrollView.showsVerticalScrollIndicator = NO;
        
        _scrollView.bounces = YES;
        
        self.scrollView.delegate = self;
        
        [self.view addSubview:self.scrollView];
        
    }
    
    return _scrollView;
}



-(void)layoutUI{
        
     UIView *addressBgView = [UIView viewWithFrame:CGRectMake(0, gap, frameX,kHeight*frameX/320.0)];
     [self.scrollView addSubview:addressBgView];
     
     
     UIImageView *mapImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,12,15,20)];
     mapImageView.image = [UIImage imageNamed:@"dwf@2x"]; //地图图标
     [_scrollView addSubview:mapImageView];
     
     //地址
     self.addressText = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(mapImageView.frame)+8, 7, frameX - 140,30*frameX/320.0) font:UIFont(16) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:nil placeholder:@"地址"];
     
     self.addressText.delegate = self;
     
     if (_model.address) {
         NSArray *arr = [_model.address componentsSeparatedByString:@"&"];
         _addressText.text = [arr firstObject];
     }else{
         _addressText.placeholder = @"地址";
     }
     [_scrollView addSubview:_addressText];
     
     
     //城市
     self.addressLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(_addressText.frame),7,frameX-CGRectGetMaxX(_addressText.frame)-2,30*frameX/320.0) text:nil Color:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] Font:UIFont(14)];
     if (self.model.city) {
         self.addressLabel.text = self.model.city;
     }else {
         self.addressLabel.text = @"";
     }
     self.addressLabel.textAlignment = NSTextAlignmentLeft;
     [self.scrollView addSubview:self.addressLabel];
     
     //补充详细地址
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressText.frame), CGRectGetMaxY(addressBgView.frame)-2, 120,1.5)];
     imageView.image = [UIImage imageNamed:@"jx@3x"];
     [self.scrollView addSubview:imageView];

     
     //详细地址描述背景
     UIView *detailBgView = [UIView viewWithFrame:CGRectMake(0,CGRectGetMaxY(addressBgView.frame)+gap, frameX, kHeight*frameX/320.0)];
     [self.scrollView addSubview:detailBgView];
     
     
     //详细地址textField
     self.detailAddText = [UITextField textFieldWithFrame:CGRectMake(28,CGRectGetMaxY(addressBgView.frame)+5.5, frameX-35,30*frameX/320.0) font:UIFont(16) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53,53,53) placeholder:@"补充详细地址"];

     self.detailAddText.delegate = self;

     if (_model.address) {
         NSArray *array = [self.model.address componentsSeparatedByString:@"&"];
         _detailAddText.text = [NSString stringWithFormat:@"%@",[array lastObject]];
     }else{
         _detailAddText.placeholder = @"补充详细地址";
     }

     [self.scrollView addSubview:_detailAddText];

     //出租日期
     UIView *timeBgView = [UIView viewWithFrame:CGRectMake(0,CGRectGetMaxY(detailBgView.frame)+gap,frameX,73*frameX/320.0)];
     [self.scrollView addSubview:timeBgView];
     
     //起始时间pic
     UIImageView *timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(detailBgView.frame)+15.7*frameX/320.0,20,20)];
     timeImage.image  = [UIImage imageNamed:@"icon_qishi"];
     [self.scrollView addSubview:timeImage];
     
     //开始label
     UILabel *startLabel = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(timeImage.frame)+2, CGRectGetMaxY(detailBgView.frame)+13,60,25.5*frameX/320.0) text:@"起始时间" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:startLabel];
     
     //结束时间pic
     UIImageView *endtimeImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(timeImage.frame)+13*frameX/320.0,20,20)];
     endtimeImage.image  = [UIImage imageNamed:@"icon_jieshu"];
     [self.scrollView addSubview:endtimeImage];
     
     //结束label
    UILabel *endLabel;
    if (frameX == 320.0) {
        
     endLabel   = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(endtimeImage.frame)+2, CGRectGetMaxY(timeImage.frame)+10*frameX/320.0,60,25.5*frameX/320.0) text:@"结束时间" Color:nil Font:UIFont(15)];
        
    }else{
        
      endLabel  = [UILabel labelWithFrame:CGRectMake(CGRectGetMaxX(endtimeImage.frame)+2, CGRectGetMaxY(timeImage.frame)+8*frameX/320.0,60,25.5*frameX/320.0) text:@"结束时间" Color:nil Font:UIFont(15)];
        
    }
     [self.scrollView addSubview:endLabel];
     
     
     //选择起始时间
     _StimeButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(startLabel.frame), CGRectGetMaxY(detailBgView.frame)+13,frameX-CGRectGetMaxX(startLabel.frame)-10, 25.5*frameX/320.0) type:UIButtonTypeCustom title:nil target:self action:@selector(timeBtnClick:)];
     _StimeButton.titleLabel.font = UIFont(15);
     
     if (_model.hire_start) {
         NSString *startStr = [[[TimeChange timeChange:_model.hire_start[@"iso"]] componentsSeparatedByString:@" "] firstObject];
         NSArray *array = [startStr componentsSeparatedByString:@"-"];
         NSString *stime = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
         [_StimeButton setTitle: stime  forState:UIControlStateNormal];
     }else{
         [_StimeButton setTitle:@"年     月      日" forState:UIControlStateNormal];
     }
     [_StimeButton setTitleColor: RGB(133,133,133)  forState:UIControlStateNormal];
     if (frameX == 375.0) {
         _StimeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-172);
     }else{
         _StimeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -130);
     }
     [self.scrollView addSubview:_StimeButton];
     
     //选择结束时间
     _EtimeButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(endLabel.frame), CGRectGetMaxY(_StimeButton.frame)+8,frameX-CGRectGetMaxX(endLabel.frame)-10, 25.5*frameX/320.0) type:UIButtonTypeCustom title:nil target:self action:@selector(timeBtnClick:)];
     [_EtimeButton setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
     _EtimeButton.titleLabel.font = UIFont(15);
     if (self.model.hire_end) {
         NSString *endStr = [[[TimeChange timeChange:_model.hire_end[@"iso"]] componentsSeparatedByString:@" "] firstObject];
         NSArray *array = [endStr componentsSeparatedByString:@"-"];
         NSString *etime = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
         [_EtimeButton setTitle:etime forState:UIControlStateNormal];
     }else{
         [_EtimeButton setTitle:@"年     月      日" forState:UIControlStateNormal];
     }
     if (frameX == 375.0) {
         _EtimeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-172);
     }else{
         _EtimeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -130);
     }
     [self.scrollView addSubview:_EtimeButton];
     
     //非出租日
     UIView *nodaysBgView = [UIView viewWithFrame:CGRectMake(0,CGRectGetMaxY(timeBgView.frame)+gap, frameX, kHeight*frameX/320.0)];
     [self.scrollView addSubview:nodaysBgView];
     
     UILabel *dayLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(timeBgView.frame)+7, 105, 29) text:@"非出租日/周" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:dayLabel];
     
     //选择非出租日
    _dayButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(dayLabel.frame)+2, CGRectGetMaxY(timeBgView.frame)+7, frameX - dayLabel.frame.size.width-20, 30*frameX/320.0) type:UIButtonTypeCustom title:nil target:self action:@selector(dayButtonClick:)];

     _dayButton.titleLabel.font = UIFont(15);
     [_dayButton setTitleColor:RGB(133,133,133) forState:UIControlStateNormal];
     
     if (self.model.no_hire) {
         NSString *string = @"";
         for (int i = 0; i<self.model.no_hire.count; i++) {
              string = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",self.model.no_hire[i]]];
         }
         [_dayButton setTitle:string forState:UIControlStateNormal];
     }else{
         [_dayButton setTitle:@"请选择" forState:UIControlStateNormal];
     }
    
     if ([_dayButton.titleLabel.text isEqualToString:@"请选择"]) {
         if (frameX == 320.0) {
             _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-143);
         }else if (frameX == 375.0){
           _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-195);
         }else if (frameX ==414.0){
            _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-240);
         }
     }else{
         _dayButton.titleLabel.textAlignment = NSTextAlignmentRight;
     }
     [self.scrollView addSubview:_dayButton];
     
     //车位面积
     UIView *areaBgView = [UIView viewWithFrame:CGRectMake(0,CGRectGetMaxY(nodaysBgView.frame)+gap, frameX,kHeight*frameX/320.0)];
     [self.scrollView addSubview:areaBgView];
     
     UILabel *areaLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(nodaysBgView.frame)+7, 130,29*frameX/320.0) text:@"车位面积" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:areaLabel];

     //车位面积TextField
     self.areaTextField = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(areaLabel.frame), CGRectGetMaxY(nodaysBgView.frame)+7, frameX - 148,30*frameX/320.0) font:UIFont(16) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53, 53, 53) placeholder:@"请填写"];
     self.areaTextField.delegate = self;

     if (self.model.park_area) {
         _areaTextField.text = [NSString stringWithFormat:@"%@",self.model.park_area];
     }else{
         _areaTextField.placeholder = @"请填写";
     }
     _areaTextField.textAlignment = NSTextAlignmentRight;

     [self.scrollView addSubview:_areaTextField];

     //车位限高
     UIView *heightBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(areaBgView.frame)+gap, frameX, kHeight*frameX/320.0)];
     [self.scrollView addSubview:heightBgView];
     

     UILabel *heightLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(areaBgView.frame)+7, 130,29*frameX/320.0) text:@"车位限高" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:heightLabel];

     
     self.heightTextField = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(areaLabel.frame), CGRectGetMaxY(areaBgView.frame)+7, frameX - 148,30*frameX/320.0) font:UIFont(15) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53, 53, 53) placeholder:@"请填写"];

     self.heightTextField.delegate = self;

     if (self.model.park_height) {
         _heightTextField.text = [NSString stringWithFormat:@"%@",self.model.park_height];
     }else{
         _heightTextField.placeholder = @"请填写";
     }
     _heightTextField.textAlignment = NSTextAlignmentRight;

     [self.scrollView addSubview:_heightTextField];

     //添加车牌尾号
     UIView *cardBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(heightBgView.frame)+gap, frameX,kHeight*frameX/320.0)];
     [self.scrollView addSubview:cardBgView];
     
     UILabel *numLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(heightBgView.frame)+7, 130, 29*frameX/320.0) text:@"添加车牌尾号" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:numLabel];
     

     self.numTextField = [UITextField textFieldWithFrame:CGRectMake(CGRectGetMaxX(numLabel.frame), CGRectGetMaxY(heightBgView.frame)+7, frameX - 148, 29*frameX/320.0) font:UIFont(15) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53, 53, 53) placeholder:@"请填写"];

     self.numTextField.delegate = self;

     if (self.model.tail_num) {
         _numTextField.text = [NSString stringWithFormat:@"%@",self.model.tail_num];
     }else{
         _numTextField.placeholder = @"请填写";
     }
     _numTextField.textAlignment = NSTextAlignmentRight;

     [self.scrollView addSubview:_numTextField];

     //是否是正规车位
     UIView *normalBgView = [UIView viewWithFrame:CGRectMake(0,CGRectGetMaxY(cardBgView.frame)+gap, frameX,kHeight*frameX/320.0)];
     [self.scrollView addSubview:normalBgView];
     
     UILabel *carLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(cardBgView.frame)+7, 130, 29*frameX/320.0) text:@"是否正规车位" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:carLabel];
     
     
     YiSwitch *carSwitch = [[YiSwitch alloc]initAboutImageWithFrame:CGRectMake(frameX - 72, CGRectGetMaxY(cardBgView.frame)+8, 64,28*frameX/320.0) direction:YiSwitchDirectionHorizontal style:YiSwitchStyleSquare];
     carSwitch.backgroundColor = [UIColor yellowColor];
     carSwitch.cornerRadius = 6.0;
     [carSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
     [carSwitch setBgViewYesImage:[UIImage imageNamed:@"yes@2x"] noImage:[UIImage imageNamed:@"no@2x"]];
     carSwitch.yesImageView.image = [UIImage imageNamed:@"Btn_@2x"];
     carSwitch.noImageView.image = [UIImage imageNamed:@"Btn_@2x"];
     if (self.model.normal) {
         NSString *normal = [NSString stringWithFormat:@"%@",self.model.normal];
         if ([normal isEqualToString:@"0"]) {
             carSwitch.isYes = NO;
         }else{
             carSwitch.isYes = YES;
         }
     }
     [self.scrollView addSubview:carSwitch];
     
    
     //地上地下
     
     UIView *groundBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(normalBgView.frame)+gap, frameX,kHeight*frameX/320.0)];
     [self.scrollView addSubview:groundBgView];
     
     
     UILabel *groundLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(normalBgView.frame)+7, 130,29*frameX/320.0) text:@"地上/地下" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:groundLabel];
     
     //选择地上地下按钮
     self.groundButton = [UIButton buttonWithFrame:CGRectMake(CGRectGetMaxX(groundLabel.frame), CGRectGetMaxY(normalBgView.frame)+7, frameX - groundLabel.frame.size.width, 30) type:UIButtonTypeCustom title:nil target:self action:@selector(btnClick:)];
     
     [self.groundButton setTitleColor:RGB(133,133,133) forState:UIControlStateNormal];
    
     self.groundButton.titleLabel.font = UIFont(15);
     
     if (self.model.myStruct) {
         
         NSString *struects = [NSString stringWithFormat:@"%@",self.model.myStruct];
         
         if ([struects isEqualToString:@"1"]) {
             [self.groundButton setTitle:@"地上" forState:UIControlStateNormal];
         }else{
             [self.groundButton setTitle:@"地下" forState:UIControlStateNormal];
         }
     }else{
         [self.groundButton setTitle:@"请选择" forState:UIControlStateNormal];
     }
     if (frameX == 320.0) {
         self.groundButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-100);
     }else if (frameX == 375.0){
         self.groundButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-158);
     }else if (frameX == 414.0){
         self.groundButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-205);
     }
     [self.scrollView addSubview:self.groundButton];

     //有无门禁卡
     UIView *entranceBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(groundBgView.frame)+gap,frameX, 95*frameX/320.0)];
     [self.scrollView addSubview:entranceBgView];
     
     
     UILabel *entranceLabel = [UILabel labelWithFrame:CGRectMake(8,CGRectGetMaxY(groundBgView.frame)+7,76,20*frameX/320.0) text:@"有无门禁卡" Color:nil Font:UIFont(15)];
     [self.scrollView addSubview:entranceLabel];


     //门禁描述textView
     self.entranceTextView = [UITextView textViewWithFrame:CGRectMake(8, CGRectGetMaxY(entranceLabel.frame),frameX - 16,70*frameX/320.0) font:UIFont(15) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53, 53, 53)];
     self.entranceTextView.delegate = self;
     if (self.model.gate_card) {
         _entranceTextView.text = [NSString stringWithFormat:@"%@",self.model.gate_card];
     }
     [self.scrollView addSubview:_entranceTextView];

     //占位文字
     if (!self.model.gate_card) {
         
         self.label = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(entranceLabel.frame), frameX, 30) text:@"请填写" Color:[UIColor clearColor] Font:UIFont(15)];

         self.label.enabled = NO;

         [self.scrollView addSubview:_label];
         
     }

     
     //车位描述
     UIView *describeBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(entranceBgView.frame)+gap, frameX, 90*frameX/320.0)];
     [self.scrollView addSubview:describeBgView];
    

     UILabel *descLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(entranceBgView.frame)+9,80,20*frameX/320.0) text:@"车位描述" Color:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] Font:UIFont(15)];
     [self.scrollView addSubview:descLabel];
     

     //车位描述TextView
     self.describeTextView = [UITextView textViewWithFrame:CGRectMake(8, CGRectGetMaxY(descLabel.frame)+1, frameX-16,60*frameX/320.0) font:UIFont(15) bgColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 56"]] textColor:RGB(53, 53, 53)];
    self.describeTextView.delegate = self;
     
     if (self.model.park_description) {
         _describeTextView.text = [NSString stringWithFormat:@"%@",self.model.park_description];
     }
     [self.scrollView addSubview:_describeTextView];
    
     //
     if (!self.model.park_description) {
         
         self.deLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(descLabel.frame), frameX, 30) text:@"请填写" Color:[UIColor clearColor] Font:UIFont(15)];

         self. deLabel.enabled = NO;
         
         [self.scrollView addSubview:_deLabel];
         
     }

     
     //出租类型
     self.categoryBgView = [UIView viewWithFrame:CGRectMake(0, CGRectGetMaxY(describeBgView.frame)+gap, frameX,kHeight*frameX/320.0)];
     
     [self.scrollView addSubview:self.categoryBgView];
     
     
     UILabel *hireLabel = [UILabel labelWithFrame:CGRectMake(8, CGRectGetMaxY(describeBgView.frame)+7, 80,29*frameX/320.0) text:@"出租类型" Color:nil Font:UIFont(16)];
     
     [self.scrollView addSubview:hireLabel];

     
     UIButton *button = [UIButton buttonWithFrame:CGRectMake(frameX - 45, CGRectGetMaxY(describeBgView.frame)+7,28*frameX/320.0 , 28*frameX/320.0) type:UIButtonTypeCustom title:nil target:self action:@selector(buttonClick:)];
     
     _addButton = button;
     
     [button setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
     
     [self.scrollView addSubview:button];
     
     //发布按钮
     UIButton *pubLishBtn = [UIButton buttonWithFrame:CGRectMake(50, CGRectGetMaxY(self.categoryBgView.frame)+50, frameX - 100,40*frameX/320.0) type:UIButtonTypeCustom title:@"发布信息" target:self action:@selector(pubLishBtn:)];
     
     _pubLishBtn = pubLishBtn;
     
     [pubLishBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
     
     pubLishBtn.layer.masksToBounds = YES;
     
     pubLishBtn.layer.cornerRadius = 5.0;
     
     pubLishBtn.backgroundColor = RGB(255, 156, 0);
     
     [self.scrollView addSubview:pubLishBtn];
     
     _scrollView.contentSize = CGSizeMake(0,CGRectGetMaxY(pubLishBtn.frame)+350);

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignResponder)];
    [self.scrollView addGestureRecognizer:tap];
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if ([textView isEqual:_entranceTextView]) {
        if (![text isEqualToString:@""]) {
            _label.hidden = YES;
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
            _label.hidden = NO;
        }
    }else if ([textView isEqual:_describeTextView]){
        if (![text isEqualToString:@""]) {
            _deLabel.hidden = YES;
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
            _deLabel.hidden = NO;
        }
    }

    return YES;
}


//类型选择
- (void)buttonClick:(UIButton* )btn{

    NSArray *array = [NSArray arrayWithArray:_fieldArray];
    TypeViewController *typeViewController = [[TypeViewController alloc]init];
    typeViewController.fieldArraymmmmm = array;
    typeViewController.block = ^(NSDictionary *dic){
        
        _typeDic = dic;
        
        //存储返回的字典
        _dataArray   = [NSMutableArray array];
        
        [_dataArray addObject:dic];
        //出租价格
        [_priceArray addObject:_typeDic[@"price"]];
        //出租时间
        [_hire_time addObject:_typeDic[@"hire_time"]];
        //出租类型
        [_hire_method_id addObject:_typeDic[@"type"]];
        //出租名称
        [_objectName addObject:_typeDic[@"objectName"]];
        //出租别名
        [_fieldArray addObject:_typeDic[@"field"]];

        for (NSDictionary *dic in _dataArray) {
                
                ListModel *model = [ListModel modelWithDic:dic];
                
                [self.dataSource addObject:model];
                
                [self.tableView reloadData];
        }
        
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryBgView.frame)+10, frameX,55*_dataSource.count);

        _pubLishBtn.frame = CGRectMake(50,CGRectGetMaxY(_tableView.frame)+20, frameX-100, 50);
            
        };
        
        [self.navigationController pushViewController:typeViewController animated:YES];

}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ListModel *model = _dataSource[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_dataSource removeObjectAtIndex:indexPath.row];
        
        [_priceArray removeObjectAtIndex:indexPath.row];
        
        [_fieldArray removeObjectAtIndex:indexPath.row];
        
        [_hire_time removeObjectAtIndex:indexPath.row];
        
        [_hire_method_id removeObjectAtIndex:indexPath.row];
        
        [_objectName removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        if (frameX == 414.0) {
            _tableView.frame = CGRectMake(0,CGRectGetMaxY(self.categoryBgView.frame)+10,frameX, _dataSource.count *55);
            
        }else{
            
            _tableView.frame = CGRectMake(0,CGRectGetMaxY(self.categoryBgView.frame)+10,frameX, _dataSource.count * 45);
        }
        [UIView animateWithDuration:.05 animations:^{
                _pubLishBtn.frame = CGRectMake(50, CGRectGetMaxY(_tableView.frame)+20, frameX-100, 50);
        } completion:nil];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 34*frameX/320.0;
}


#pragma mark ---- <UITextViewDelegate,UITextFieldDelegate>
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:_addressText]) {
        [_addressText resignFirstResponder];
            SearchParkViewController *searchController = [[SearchParkViewController alloc]init];
            searchController.block = ^(NSArray *array){
                _addressText.text = [array firstObject];
                _laNum = array[1];
                _loNUm = array[2];
                NSString *string = [array lastObject];
                if (string.length != 0) {
                    _addressLabel.text = [NSString stringWithFormat:@"%@市",string];
                }
                
            };
            [self.navigationController pushViewController:searchController animated:YES];
     }
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if ([textView isEqual:_entranceTextView]) {
        _label.hidden = YES;
        if (_entranceTextView.text.length >=56) {
            _entranceTextView.text = [_entranceTextView.text substringToIndex:55];
        }
    }else if ([textView isEqual:_describeTextView]){
        _deLabel.hidden = YES;
        if (_describeTextView.text.length >= 56) {
            _describeTextView.text = [_describeTextView.text substringToIndex:55];
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView isEqual:_entranceTextView]) {
        if (textView.text.length == 0) {
            _label.hidden = NO;
        }
    }else if ([textView isEqual:_describeTextView]){
        if (textView.text.length == 0) {
            _deLabel.hidden = NO;
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual:_addressText]) {
        if (toBeString.length >=  16 && range.length !=1) {
            
            textField.text = [toBeString substringToIndex:16];
            
            return NO;
        }
    }else if ([textField isEqual:_detailAddText]){
    
        if (toBeString.length >=  25 && range.length !=1) {
            
            textField.text = [toBeString substringToIndex:25];
            
            return NO;
        }
    }else if ( [textField isEqual:_areaTextField] || [textField isEqual:_heightTextField] || [textField isEqual:_numTextField] ){
    
        if (toBeString.length >=  10 && range.length !=1) {
            
            textField.text = [toBeString substringToIndex:10];
            
            return NO;
            
        }
        
    }
    
    return YES;
}

//是否是正规车位
- (void)switchAction:(YiSwitch *)slider{

    if (slider.isYes == 0) {
        _normalNum = YES;
    }else{
        _normalNum = true;
    }
    
}
//地上/地下
- (void)btnClick:(UIButton *)btn{
    [_gView removeFromSuperview];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.groundButton.frame), frameX, 40)];
    _gView = view;
    [UIView animateWithDuration:0.2 animations:^{
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
    } completion:nil];
    NSArray *array = @[@"地上",@"地下"];
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(40+((frameX-80)/2+5)*i, 5, (frameX-80)/2, 30) type:UIButtonTypeCustom title:array[i] target:self action:@selector(butClic:)];
        button.backgroundColor = RGB(247,247,247);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        [view addSubview:button];
    }
}

- (void)butClic:(UIButton *)btn{
    //_button1.titleLabel.text = [NSString stringWithFormat:@"   %@",btn.titleLabel.text];
    [self.groundButton setTitle:[NSString stringWithFormat:@"   %@",btn.titleLabel.text] forState:UIControlStateNormal];
    [_gView removeFromSuperview];
}

//非出租日
- (void)dayButtonClick:(UIButton *)button{
    [_dayView removeFromSuperview];
    if (frameX == 414.0) {
        _dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, frameX, 150)];
    }else{
        _dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 202, frameX, 150)];
    }
    _dayView.backgroundColor = RGB(247, 247, 247);
    [self.scrollView addSubview:_dayView];
    
    UIImageView * chooseItemsBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 150)];
    
    chooseItemsBackView.userInteractionEnabled = YES;
    
    chooseItemsBackView.backgroundColor = [UIColor colorWithWhite:0.975 alpha:1.000];
    
    [_dayView addSubview:chooseItemsBackView];
    
    /* tpl 使用方法 */
    _chooseItemsView = [[TPLChooseItemsView alloc] initWithFrame:CGRectMake(10,10,frameX, chooseItemsBackView.frame.size.height - 50 - 10)];
    
    _chooseItemsView.backgroundColor = [UIColor colorWithWhite:0.975 alpha:1.000];
    
    [chooseItemsBackView addSubview:_chooseItemsView];
    
    NSMutableArray * titleArray = [NSMutableArray array];
    
    [titleArray addObjectsFromArray:@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"]];
    
    _chooseItemsView.titleArray = titleArray;
    
    _chooseItemsView.itemHeight = 35;
    
    _chooseItemsView.itemFont = [UIFont systemFontOfSize:17];
    
    _chooseItemsView.xSpace = 15;
    
    _chooseItemsView.ySpace = 13;
    
    if (frameX == 414.0) {
         _chooseItemsView.itemWidth = (414 -30)/5;
    }else if(frameX == 320.0){
         _chooseItemsView.itemWidth = (300 - 30)/5;
    }else{
         _chooseItemsView.itemWidth = (375 - 30)/5;
    }
    
    _chooseItemsView.isNeat = NO;
    
    _chooseItemsView.isFitLength = NO;
    
    _chooseItemsView.isMutableChoose = YES;
    
    _chooseItemsView.itemChooseColor =  RGB(255, 156, 0);
    
    _chooseItemsView.itemNormalColor = [UIColor grayColor];

    //多选
    
    UIButton *moreChooseButton = [UIButton buttonWithFrame: CGRectMake(frameX/2.0-40, 113, 80, 30) type:UIButtonTypeCustom title:@"确定" target:self action:@selector(moreButtonClicked:)];
    
    moreChooseButton.backgroundColor = RGB(255, 156, 0);
    
    if (frameX == 414.0) {
        moreChooseButton.frame = CGRectMake(frameX/2.0-40, 115, 80, 30);
    }else{
        moreChooseButton.frame = CGRectMake(frameX/2.0-40, 110, 80, 30);
    }

    moreChooseButton.layer.masksToBounds = YES;
    
    moreChooseButton.layer.cornerRadius = 5.0;
    
    [_dayView addSubview:moreChooseButton];
    
}

- (void)moreButtonClicked:(UIButton *)btn{
    
    NSString *str = [NSString stringWithFormat:@"%@",_chooseItemsView.chooseString];
    
    NSArray *array = [str componentsSeparatedByString:@","];
    
    NSString *string =  [array componentsJoinedByString:@","];
    
    NSArray *arr = [string componentsSeparatedByString:@"周"];
    
    NSString *s = [arr componentsJoinedByString:@""];
    
    [_dayButton setTitle:s forState:UIControlStateNormal];
    
    if (frameX == 414.0) {
        _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-1);
    }else if (frameX == 375.0){
        _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -1);
    }else if (frameX == 320.0){
        _dayButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -1);
    }
    
    [_dayView removeFromSuperview];
    
}

//出租日期
- (void)timeBtnClick:(UIButton *)btn{
    
    if (!_chvc) {
        _chvc  = [[CalendarHomeViewController alloc]init];
        [_chvc setAirPlaneToDay:365*5 ToDateforString:nil];
    }
    
    _chvc.calendarblock = ^(CalendarDayModel *model){
        NSString *string = [NSString stringWithFormat:@"%@",[model toString]];
        NSArray *array = [string componentsSeparatedByString:@"-"];
        NSString *time = [NSString stringWithFormat:@"%@年%@月%@日",[array firstObject],array[1],[array  lastObject] ];
        [btn setTitle:[NSString stringWithFormat:@"%@",time] forState:UIControlStateNormal];
        if (frameX == 414.0) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, -143);
        }if (frameX == 320.0) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, -107);
        }else if (frameX == 375.0){
            btn.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, -172);
        }
        
        [btn setTitleColor:RGB(133, 133, 133) forState:UIControlStateNormal];
    };
    
    //_chvc.string = self.string;
    
    [self.navigationController pushViewController:_chvc animated:YES];
    
}


//发布信息
- (void)pubLishBtn:(UIButton *)button{

    //非出租日
    NSString *noDay = [NSString stringWithFormat:@"%@",_dayButton.titleLabel.text];
    
    NSArray *noArray;
    
    if (noDay) {
        
       noArray = [noDay componentsSeparatedByString:@","];
    }else{
        noArray = @[@""];
    }
    
    //车位面积
    NSNumber *areaNum;
    
    if (_areaTextField.text.length != 0) {
        
        int area = [[NSString stringWithFormat:@"%@",_areaTextField.text] intValue];
        
        areaNum = [NSNumber numberWithInt:area];
        
    }else{
        areaNum = @0;
    }
    
    //车位限高
    NSNumber *heightNum;
    
    if (_heightTextField.text.length != 0) {
        int height = [[NSString stringWithFormat:@"%@",_heightTextField.text] intValue];
        
        heightNum = [NSNumber numberWithInt:height];
        
    }else{
        
        heightNum = @0;
        
    }
    
    //是否正规车位
    NSNumber *normalNu = [NSNumber numberWithBool:_normalNum];
    
    
    //地上/地下
    //NSLog(@"%@",_button1.titleLabel.text);
    if ([self.groundButton.titleLabel.text isEqualToString:@"请选择"]) {
        int ground = [[NSString stringWithFormat:@"%d",0] intValue];
        _groundNum = [NSNumber numberWithInt:ground];
    }else{
        if ([self.groundButton.titleLabel.text isEqualToString:@"地上"]) {
            int ground = [[NSString stringWithFormat:@"%d",0] intValue];
            _groundNum = [NSNumber numberWithInt:ground];
        }else{
            int ground = [[NSString stringWithFormat:@"%d",1] intValue];
            _groundNum = [NSNumber numberWithInt:ground];
        }
    }

    //出租类型
    NSArray *hireMethodId = [NSArray arrayWithArray:_hire_method_id];
    
    //价格
    NSArray *price = [NSArray arrayWithArray:_priceArray];
    
    
    //出租时间段
    NSArray *hire_time = [NSArray arrayWithArray:_hire_time];
    
    NSArray *field = [NSArray arrayWithArray:_fieldArray];
    
    NSString *user_id = [StringChangeJson getValueForKey:kUser_id];
    
    //地址
    NSString *addressString;
    
    if (_addressText.text.length == 0) {
        
        addressString = @"";
        
    }else{
        
        addressString = [NSString stringWithFormat:@"%@",_addressText.text];
        
    }
    
    //城市
    if (_addressLabel.text.length == 0) {
        _addressLabel.text = @"";
    }
    //详细地址
    if (_detailAddText.text.length == 0) {
        _detailAddText.text = @"";
    }
    
    //有无门禁卡
    if (_entranceTextView.text.length == 0) {
        _entranceTextView.text = @"";
    }
    
    //车位描述
    if (_describeTextView.text.length == 0) {
        _describeTextView.text = @"";
    }
    
    //车位尾号
    if (_numTextField.text.length == 0) {
        _numTextField.text  = @"";
    }
    
    if (_addressText.text.length == 0) {
        _addressText.text = @"";
    }

    
    if ([self.string isEqualToString:@"change"]) {
        if (user_id) {
            if (self.model.location[@"latitude"] && self.model.location[@"longitude"]) {
                _laNum = self.model.location[@"latitude"];
                _loNUm = self.model.location[@"longitude"];
            }else{
                _laNum = @0;
                _loNUm = @0;
            }
            
            NSArray *strartArr = [_StimeButton.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
            NSArray *endArra = [_EtimeButton.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];

            NSString *startTime = [NSString stringWithFormat:@"%@-%@-%@",strartArr[0],strartArr[1],strartArr[2]];
            NSString *endTime = [NSString stringWithFormat:@"%@-%@-%@",endArra[0],endArra[1],endArra[2]];
            
            NSDictionary *dictionary = @{@"user_id":user_id,
                                         @"park_id":self.model.objectId,
                                         @"address":_addressText.text,
                                         @"park_detail":_detailAddText.text,
                                         @"park_description":_describeTextView.text,
                                         @"location_info":@{@"__type":@"GeoPoint",@"latitude":_laNum,@"longitude":_loNUm},
                                         @"hire_start":[NSString stringWithFormat:@"%@ 00:00:00",startTime],
                                         @"hire_end":[NSString stringWithFormat:@"%@  00:00:00",endTime],
                                         @"no_hire":noArray,
                                         @"tail_num":_numTextField.text,
                                         @"city":_addressLabel.text,
                                         @"normal":normalNu,
                                         @"park_area":areaNum,
                                         @"park_height":heightNum,
                                         @"gate_card":_entranceTextView.text,
                                         @"hire_method_id":hireMethodId,
                                         @"hire_price":price,
                                         @"hire_time":hire_time,
                                         @"park_struct":_groundNum,
                                         @"mode":@"community",
                                         @"hire_field":field,
                                         @"personal":@1
                                         };
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kUpdateParkInfo sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:dictionary andBlock:^(NSDictionary *data) {
                
                NSString *string = data[@"result"];
                
                NSData *datas = [string dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"msg"] isEqualToString:@"成功"] ) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"修改成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }else {
                
                    UIAlertViewShow(dic[@"error"]);
                }
            }];
        }
    }else{
        
        //经纬度
        if (!_laNum || ! _loNUm) {
            _laNum = @0;
            _loNUm = @0;
        }
        
        if (user_id.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            NSArray *strartArr = [_StimeButton.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
            NSArray *endArra = [_EtimeButton.titleLabel.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
            
            NSString *startTime;
            
            NSString *endTime;
            
            if (strartArr && endArra) {
                
                startTime = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",strartArr[0],strartArr[1],strartArr[2]];
                
               endTime = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",endArra[0],endArra[1],endArra[2]];
                
            }else{
            
                startTime = @"";
                
                startTime = @"";
            }
            

            
            NSDictionary *parkData = @{@"user_id":user_id,
                                       @"worker_id":@"",
                                       @"address":addressString,
                                       @"park_detail":_detailAddText.text,
                                       @"park_description":_describeTextView.text,
                                       @"location_info":@{@"__type":@"GeoPoint",
                                                          @"latitude":_laNum,
                                                          @"longitude":_loNUm,
                                                          },
                                       @"hire_start":startTime,
                                       @"hire_end":endTime,
                                       @"no_hire":noArray,
                                       @"tail_num":_numTextField.text,
                                       @"city"          :_addressLabel.text,
                                       @"normal"   :normalNu,
                                       @"park_area":areaNum,
                                       @"park_height":heightNum,
                                       @"gate_card":_entranceTextView.text,
                                       @"hire_method_id":hireMethodId,
                                       @"hire_price":price,
                                       @"hire_time":hire_time,
                                       @"park_struct":_groundNum,
                                       @"mode":@"community",
                                       @"hire_field":field,
                                       @"personal":@1
                                       };
            
            _request = [[KongCVHttpRequest alloc]initWithRequests:kShareInfoUrl sessionToken:[[NSUserDefaults standardUserDefaults] objectForKey:kSessionToken] dictionary:parkData andBlock:^(NSDictionary *data) {
                
                NSString *string = data[@"result"];

                NSData *datas = [string dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"msg"] isEqualToString:@"成功"] ) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"发布成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:dic[@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
            
        }
    }
}

- (void)resignResponder{
    [_dayView removeFromSuperview];
    [_gView removeFromSuperview];
    [_addressText resignFirstResponder];
    [_detailAddText resignFirstResponder];
    [_areaTextField resignFirstResponder];
    [_heightTextField resignFirstResponder];
    [_numTextField resignFirstResponder];
    [_entranceTextView resignFirstResponder];
    [_describeTextView resignFirstResponder];
}

//- (void)deleate:(UISwipeGestureRecognizer *)swip{
//    _swipeView.center = CGPointMake(-100,self.swipeView.frame.origin.y-17);
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self resignResponder];
}

@end
