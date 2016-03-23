//
//  NaviViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/11/3.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"

@interface NaviViewController : RootViewController<MAMapViewDelegate,AMapNaviManagerDelegate,AMapNaviViewControllerDelegate>

//@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) AMapNaviManager *naviManger;

@end
