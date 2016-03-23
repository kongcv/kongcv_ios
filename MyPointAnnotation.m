//
//  MyPointAnnotation.m
//  kongchewei
//
//  Created by 空车位 on 15/11/10.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "MyPointAnnotation.h"

@implementation MyPointAnnotation

+(instancetype)myAnnoViewWithMapView:(MAMapView *)mapView{

    static NSString *ID = @"myAnnoView";
    MyPointAnnotation *myAnnoView = (MyPointAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        
        myAnnoView = [[MyPointAnnotation alloc]initWithAnnotation:nil reuseIdentifier:ID];
        
    }
    
    return myAnnoView;
    
}

@end
