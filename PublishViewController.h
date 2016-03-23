//
//  PublishViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/11/9.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"
#import "GetParkingModel.h"
@interface PublishViewController : RootViewController
@property (nonatomic,copy)   NSString *string;
@property (nonatomic,strong) GetParkingModel *model;
@property (nonatomic,strong)  NSString *objectId;


@property (nonatomic,assign) CGFloat la;
@property (nonatomic,assign) CGFloat lo;
@end
