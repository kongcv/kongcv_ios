//
//  CommentTableViewCell.h
//  kongchewei
//
//  Created by 空车位 on 15/11/25.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "RouteCommentModel.h"
@interface CommentTableViewCell : UITableViewCell
@property (nonatomic,strong) CommentModel *model;
@property (nonatomic,strong) RouteCommentModel *routeModel;
@property (nonatomic,assign) CGFloat  cellHeight;
@end
