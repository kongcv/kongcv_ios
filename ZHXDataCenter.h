//
//  ZHXDataCenter.h

//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DetailInfoModel.h"

typedef enum {

    kCollection = 2,
    kDownload
    
}Collection;

@interface ZHXDataCenter : NSObject

+(ZHXDataCenter *)sharedCenter;

-(BOOL)addDataWithModel:(DetailInfoModel  *)model andType:(Collection)type;
-(BOOL)deleteDataWithModel:(DetailInfoModel  *)model andType:(Collection)type;
-(BOOL)findDataWithModel:(DetailInfoModel *)model andType:(Collection)type;
-(NSArray *)getData:(Collection) type ;

@end
