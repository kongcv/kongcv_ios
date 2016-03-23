//
//  NaviPointAnnotation.h
//  kongchewei
//
//  Created by 空车位 on 15/11/2.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>

typedef NS_ENUM(NSInteger,NavPointAnnotationType) {

    NavPointAnnotationLocation=3,
    
    NavPointAnnotation,
    
    NaviPointAnnotationAnn
    
};

@interface NaviPointAnnotation : MAPointAnnotation

@property (nonatomic,assign)NavPointAnnotationType navPointType;

@end
