//
//  TypeViewController.h
//  kongchewei
//
//  Created by 空车位 on 15/11/12.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "RootViewController.h"

#import "PicturesModel.h"

typedef void(^ TypeBlock) (NSDictionary *dictionary);

@interface TypeViewController : RootViewController

@property (nonatomic,strong) TypeBlock block;

@property (nonatomic,strong) PicturesModel *picModel;
@property (nonatomic,strong) NSArray *fieldArraymmmmm;

@end
