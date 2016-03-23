//
//  MineViewController.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.


#import "MineViewController.h"

#import "VPImageCropperViewController.h"
//注册
#import "LoginViewController.h"
//设置
#import "InstallViewController.h"
//我的钱包
#import "MoneyPocketViewController.h"
//车位管理
#import "GetParkingViewController.h"
//订单管理
#import "TradeItemViewController.h"
//消息通知
#import "PushMessageViewController.h"
//修改用户名
#import "UserNameViewController.h"

#import "ZHXDataCache.h"

#import "NSString+Hashing.h"

#import "PaymentViewController.h"

#import "UIImageView+WebCache.h"

#import "MineTableViewCell.h"

#define ORIGINAL_MAX_WIDTH 640.0f
@interface MineViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate  , UIActionSheetDelegate,VPImageCropperDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIImageView *portraitImageView;//设置用户头像

@property (nonatomic,strong) UIImage *portraitImage;
//用户名
@property (nonatomic,strong) UIButton *userNameBtn;

@property (nonatomic,strong) KongCVHttpRequest *request;
//图片转为base64字符串
@property (nonatomic,copy)   NSString *imageBaseStr;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,strong) NSArray *iconArray;

@end

@implementation MineViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MobClick endLogPageView:@"FourteenPage"];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"FourteenPage"];
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeUserInfo) name:@"deleateName" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadHeadImageView) name:@"refresh" object:nil];
    
}


- (void)removeUserInfo{
    
    _portraitImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
    
    [self.userNameBtn setTitle:@"" forState:UIControlStateNormal];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //布局UI
    [self layoutUI];

    //加载头像
    [self loadHeadImageView];
    
    [self.tableView reloadData];
    
}

//布局UI
- (void)layoutUI{
    
    self.view.backgroundColor = RGB(247, 247, 247);
    
    //背景图
    self.bgView = [[UIView alloc]init];
    
    if (frameY == 480.0) {
        
        self.bgView.frame = CGRectMake(0,0, frameX,160);
        
    }else if(frameX == 320.0 && frameY != 480.0){
        
        self.bgView.frame =CGRectMake(0,0, frameX,181);
        
    }else{
        
        self.bgView.frame =CGRectMake(0,0, frameX,181*frameY/568.0);
    }
    
    self.bgView.backgroundColor = RGB(255, 156, 0);
    
    [self.view addSubview:self.bgView];
    
    //设置用户头像
    self.portraitImageView = [[UIImageView alloc] init];
    
    if (frameX == 320.0) {
        
        self.portraitImageView.frame = CGRectMake(131,51*frameX/320.0,57.5*frameX/320.0,57.5*frameX/320.0);
        
    }else{
        
        self.portraitImageView.frame = CGRectMake(frameX/2.0 - 57.5*frameX/320.0/2.0 ,51*frameX/320.0,57.5*frameX/320.0,57.5*frameX/320.0);
        
    }
    
    [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
    
    [_portraitImageView.layer setMasksToBounds:YES];
    
    [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [_portraitImageView setClipsToBounds:YES];
    
    _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
    
    _portraitImageView.layer.shadowOpacity = 0.5;
    
    _portraitImageView.layer.shadowRadius = 2.0;
    
    _portraitImageView.layer.borderColor = [[UIColor redColor] CGColor];
    
    _portraitImageView.layer.borderWidth = 0;
    
    _portraitImageView.userInteractionEnabled = YES;
    
    _portraitImageView.backgroundColor = [UIColor whiteColor];
    
    //头像添加手势
    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
    
    [_portraitImageView addGestureRecognizer:portraitTap];
    
    _portraitImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
    
    [self.view addSubview:self.portraitImageView];
    
    
    //注册
    self.userNameBtn = [UIButton buttonWithFrame:CGRectMake(frameX/2 - 100, CGRectGetMaxY(_portraitImageView.frame)+5,200,30) type:UIButtonTypeCustom title:[StringChangeJson getValueForKey:@"name"] target:self action:@selector(loginBtnClick:)];
    
    self.userNameBtn.titleLabel.font = UIFont(16);
    
    [self.bgView addSubview:self.userNameBtn];
    
}

//修改用户名
- (void)loginBtnClick:(UIButton *)btn{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        UserNameViewController *userNameController = [[UserNameViewController alloc]init];
        
        userNameController.block = ^(NSString *str){
            
            [self.userNameBtn setTitle:str forState:UIControlStateNormal];
            
        };
        
        [self.navigationController pushViewController:userNameController animated:YES];
        
    }
    
}


-(NSArray *)titleArray{

    if (_titleArray == nil) {
        
        _titleArray = @[@"我的钱包",@"车位管理",@"订单管理",@"消息通知",@"设置"];
    }
    
    return _titleArray;
}

-(NSArray *)iconArray{

    if (_iconArray == nil) {
        
        _iconArray = @[@"icon_qianbao",@"icon_cheweiguanli",@"icon_dingdanguanli",@"icon_tongzhi",@"icon_shezhi"];
        
    }
    
    return _iconArray;
    
}

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame)+9, frameX, frameY-CGRectGetMaxY(_bgView.frame)-49) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.scrollEnabled = NO;
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

//加载头像
- (void)loadHeadImageView{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        if ([StringChangeJson getValueForKey:@"image"]) {
            
            NSURL *url = [NSURL URLWithString:[StringChangeJson getValueForKey:@"image"]];
            
            [_portraitImageView sd_setImageWithURL:url];
            
        }else {
            
            _portraitImageView.image = [UIImage imageNamed:@"ICON_TOUXIANG_xhdpi"];
            
        }
        
        NSString *userName = [StringChangeJson getValueForKey:@"username"];
        
        NSString *mobileName = [StringChangeJson getValueForKey:@"mobilePhoneNumber"];
        
        if (userName) {
            
            if (userName && mobileName) {
                
                if ([userName isEqualToString:mobileName]) {
                    
                    NSRange range = {8,3};
                    
                    NSString *str = [NSString stringWithFormat:@"%@*****%@",[mobileName substringToIndex:3],[mobileName substringWithRange:range]];
                    
                    [self.userNameBtn setTitle:str forState:UIControlStateNormal];
                    
                }else{
                    
                    [self.userNameBtn setTitle:userName forState:UIControlStateNormal];
                    
                }
            }
        }
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identfier = @"cell";
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    
    if (cell == nil) {
        
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
        
    }
    
    cell.iconImageView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    
    cell.label.text = self.titleArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 51*frameX/320.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *controllerArray =
  @[@"MoneyPocketViewController",@"GetParkingViewController",@"TradeItemViewController",@"PushMessageViewController",@"InstallViewController"];
    
    Class class = NSClassFromString(controllerArray[indexPath.row]);
    
    RootViewController *controller = [[class alloc]init];
    
    [self skipViewController:controller];
    
}

- (void)skipViewController:(RootViewController *)controller{
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
    
        LoginViewController *loginController = [[LoginViewController alloc]init];
        
        [self.navigationController pushViewController:loginController animated:YES];
        
    }

}



- (void)editPortrait {
    
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选取", nil];
        
        [choiceSheet showInView:self.view];
        
    }else{
        
        LoginViewController *loginController = [[LoginViewController alloc]init];
        
        [self.navigationController pushViewController:loginController animated:YES];
        
    }

}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {

    _portraitImageView.image = editedImage;

    NSData *data = UIImageJPEGRepresentation(editedImage, 0.1);
    //图片转为base64字符串
    self.imageBaseStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if ([StringChangeJson getValueForKey:kUser_id]) {
        
        NSString *fileName;
        
        if ([StringChangeJson getValueForKey:kMobelNum]) {
            
            fileName = [NSString stringWithFormat:@"%@.png",[[NSUserDefaults standardUserDefaults] objectForKey:kMobelNum]];
            
        }
        
        NSString *imageId;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"id"]) {
            
            imageId = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
            
        }
        
        NSDictionary *dic;
        
        if (imageId && [StringChangeJson getValueForKey:kUser_id]&&fileName) {
            
            dic = @{@"user_id" :[StringChangeJson getValueForKey:kUser_id],@"file_name":fileName,@"file_base64":self.imageBaseStr,@"image_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]};
            
        }else if([StringChangeJson getValueForKey:kUser_id] && fileName){
            
            dic = @{@"user_id" :[StringChangeJson getValueForKey:kUser_id],@"file_name":fileName,@"file_base64":self.imageBaseStr,@"image_id":@""};
        }
        
        //上传头像
        _request = [[KongCVHttpRequest alloc]initWithRequests:kUpdateImageUrl sessionToken:[StringChangeJson getValueForKey:kSessionToken] dictionary:dic andBlock:^(NSDictionary *data) {
            
            NSDictionary *dic = [StringChangeJson jsonDictionaryWithString:data[@"result"]];
            
            if ([dic[@"msg"] isEqualToString:@"成功"] ) {
                
                NSDictionary *diction = dic[@"image"];
                
                StringChangeJson *stringJson = [[StringChangeJson alloc]init];
                
                [stringJson saveValue:diction[@"url"] key:@"image"];
                
                [stringJson saveValue:diction[@"id"] key:@"id"];
                
                [cropperViewController dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                UIAlertViewShow(@"请重新设置");
                
            }
            
        }];
    }
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if ([self isFrontCameraAvailable]) {
                
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:nil];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
     
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _portraitImage = portraitImg;

        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:nil];
        
    }];
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
  
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
 
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
 
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
 
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
  
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{

    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{

    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
  
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{

    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {

    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //if(newImage == nil) NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end












