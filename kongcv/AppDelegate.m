//
//  AppDelegate.m
//  kongchewei
//
//  Created by 空车位 on 15/10/14.
//  Copyright (c) 2015年 空车位. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "MobClick.h"
#import "Pingpp.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "KongCVTabBarViewController.h"
#import "KongNewViewController.h"
#import "KongCVViewController.h"
#import "PublishViewController.h"
#import "MineViewController.h"
#import "NotificationViewController.h"
#import "CurbNotificationViewController.h"
#import <iflyMSC/IFlySpeechSynthesizer.h>
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import <iflyMSC/IFlySpeechUtility.h>
#import <iflyMSC/IFlySetting.h>

@interface AppDelegate ()<MAMapViewDelegate,AMapLocationManagerDelegate>

@property (nonatomic,strong) KongCVTabBarViewController *tabBarViewController;

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) NotificationViewController *notificationCon;

@property (nonatomic,strong) AMapLocationManager     *locationManger;

@property (nonatomic,copy)   NSString *city;

@property (nonatomic,assign) CGFloat  la;

@property (nonatomic,assign) CGFloat  lo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:RGB(254, 156, 0),NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    //布局UI
    [self prepareUI];
    
    //设置地图apiKey
    [MAMapServices sharedServices].apiKey = amapAppKey;
    
    [AMapNaviServices sharedServices].apiKey = amapAppKey;
    
    [AMapLocationServices sharedServices].apiKey = amapAppKey;
    
    //获取定位信息
    [self loaction];
    
    //设置语音播报
    [self configIFIySpeech];
    
    //设置可以接收的通知类型
    //UIRemoteNotificationTypeBadge|  UIUserNotificationTypeBadge|
    if ([UIDevice currentDevice].systemName.doubleValue <= 8.0) {
        
         [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge) categories:nil];
        
    }else {
        
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeSound |UIUserNotificationTypeBadge) categories:nil];
    }
    
    //Jpush进行初始化
    [APService setupWithOption:launchOptions];
    
    //友盟统计  BATCH   启动发送
    [MobClick startWithAppkey:@"566029d8e0f55ace61003461" reportPolicy:BATCH channelId:nil];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



//获取定位信息
- (void)loaction{
    
    self.locationManger = [[AMapLocationManager alloc]init];
    
    self.locationManger.delegate = self;

    [self.locationManger setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    
    [self.locationManger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        _la = location.coordinate.latitude;
        _lo = location.coordinate.longitude;
        NSNumber *laNum = [NSNumber numberWithFloat:_la];
        NSNumber *loNum = [NSNumber numberWithFloat:_lo];
        
        if (error){
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        if (regeocode)
        {
            //NSLog(@"reGeocode:%@", regeocode);
            
            if (regeocode.city) {
                self.city = regeocode.city;
            }else{
                self.city = regeocode.province;
            }
            StringChangeJson *city =  [[StringChangeJson alloc]init];
            
            [city saveValue:self.city key:@"city"];
            
            if (regeocode.neighborhood) {
                
                [city saveValue:regeocode.neighborhood key:@"address"];
                
            }else{
                
                [city saveValue:regeocode.formattedAddress key:@"address"];
                
            }
            
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:laNum forKey:@"la"];
            
            [defaults setObject:loNum forKey:@"lo"];
            
            [defaults synchronize];
            
        }
    }];
}


//注册(发送)token
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [APService registerDeviceToken:deviceToken];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[APService registrationID] forKey:kRegistationID];
    
    [defaults synchronize];
    
    
}



//推送错误调用
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

//接收到的通知内容
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    if (userInfo) {
        
        [APService handleRemoteNotification:userInfo];
        
        if ([userInfo[@"mode"]isEqualToString:@"community"]) {
            
            NotificationViewController *notController = [[NotificationViewController alloc]init];
            
            _notificationCon = notController;
            
            notController.mode = userInfo[@"mode"];
            
            notController.park_id = userInfo[@"park_id"];
            
            notController.push_type = userInfo[@"push_type"];
            
            notController.hire_method_id = userInfo[@"hire_method_id"];
            
            notController.own_mobile = userInfo[@"own_mobile"];
            
            notController.device_token = userInfo[@"own_device_token"];
            
            notController.device_type = userInfo[@"own_device_type"];
            
            notController.price = userInfo[@"price"];
            
            notController.hire_start = userInfo[@"hire_start"];
            
            notController.hire_end = userInfo[@"hire_end"];
            
            notController.message_id = userInfo[@"message_id"];
        
            UIViewController *tempViewCon = [self getCurrentVC];
            
            [tempViewCon presentViewController:notController animated:YES completion:nil];
            
            
        }else if ([userInfo[@"mode"]isEqualToString:@"curb"]){
            
            CurbNotificationViewController *curbNotifiController = [[CurbNotificationViewController alloc]init];
            
            curbNotifiController.mode = userInfo[@"mode"];
            
            curbNotifiController.park_id = userInfo[@"park_id"];
            
            curbNotifiController.push_type = userInfo[@"push_type"];
            
            curbNotifiController.hire_method_id = userInfo[@"hire_method_id"];
            
            curbNotifiController.own_mobile = userInfo[@"own_mobile"];
            
            curbNotifiController.device_token = userInfo[@"own_device_token"];
            
            curbNotifiController.device_type = userInfo[@"own_device_type"];
            
            curbNotifiController.price = userInfo[@"price"];
            
            curbNotifiController.hire_start = userInfo[@"hire_start"];
            
            curbNotifiController.hire_end = userInfo[@"hire_end"];
            
            curbNotifiController.pay_type = userInfo[@"pay_type"];
            
            curbNotifiController.trade_id = userInfo[@"trade_id"];
            
            curbNotifiController.pay_tool = userInfo[@"pay_tool"];
            
            curbNotifiController.hire_field = userInfo[@"hire_method_field"];
            
            UIViewController *tempViewCon = [self getCurrentVC];
            
            [tempViewCon presentViewController:curbNotifiController animated:YES completion:nil];
            
        }

        completionHandler(UIBackgroundFetchResultNewData);
        
        }else{
            
            completionHandler(UIBackgroundFetchResultFailed);
            
        }
}




- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        NSLog(@"%@",windows);
        
        for(UIWindow * tmpWin in windows)
            
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
                
            {
                window = tmpWin;
                
                break;
            }
        }
    }
    
    id nextResponder;
    
    NSArray *array = [window subviews];
    
    NSLog(@"%@",array);
    
    if (array.count != 0) {
        
        UIView *frontView = [[window subviews] objectAtIndex:0];
        
        nextResponder = [frontView nextResponder];
        
        result = nextResponder;
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            
            result = nextResponder;
        
        else
            
            result = window.rootViewController;
        
    }else{
        
        result = window.rootViewController;
        
    }
 
    return result;
}


//初始化语音设置
- (void)configIFIySpeech{
    
    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@,timeout=%@",@"5565399b",@"20000"]];
    
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
}

//布局UI
- (void)prepareUI{
    
    self.tabBarViewController = [[KongCVTabBarViewController alloc]init];
    
    self.window.rootViewController = self.tabBarViewController;
    
    NSString *key = @"CFBundleShortVersionString";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastVersion = [defaults stringForKey:key];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if (![currentVersion isEqualToString:lastVersion]) {

        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        NSArray *array = @[@"start_app_one",@"start_app_two",@"start_app_three",@"start_app_four"];
        for (int i = 0; i<4; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frameX*i, 0, frameX, frameY)];
            imageView.image = [UIImage imageNamed:array[i]];
            
            [scrollView addSubview:imageView];
        }
        
        scrollView.contentSize = CGSizeMake(frameX * array.count, 0);
        
        [_tabBarViewController.view addSubview:scrollView];
        
        [defaults setObject:currentVersion forKey:key];
        
        [defaults synchronize];
        
        UIButton *bt = [UIButton buttonWithFrame:CGRectMake(frameX*3+frameX/2.0 - 75,frameY -120,150,40) type:UIButtonTypeCustom title:nil target:self action:@selector(btn:)];
        
        [bt setBackgroundImage:[UIImage imageNamed:@"btn_lijitiyan_default"] forState:UIControlStateNormal];
        
        [scrollView addSubview:bt];
        
    }else{
        
        [self tabBar];
        
    }
}

- (void)btn:(UIButton *)btn{
    [self tabBar];
}
//初始化tabBar
- (void)tabBar{
    
    self.tabBarViewController = [[KongCVTabBarViewController alloc]init];
    
    //空车位
    [self.tabBarViewController addViewControllerWithString:@"KongCVViewController" title:@"空车位" image:@"kongcvN" andSelectedImage:@"kongcv"];//矩形-34@2x
    
    //发布
    [self.tabBarViewController addViewControllerWithString:@"PublishViewController" title:@"发布" image:@"publishN" andSelectedImage:@"publish"];
    
    //我的
    [self.tabBarViewController addViewControllerWithString:@"MineViewController" title:@"我的" image:@"MeN" andSelectedImage:@"Me"];
    
    self.window.rootViewController = self.tabBarViewController;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [Pingpp handleOpenURL:url withCompletion:nil];
}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    return [Pingpp handleOpenURL:url withCompletion:nil];
}


@end
