//
//  RatingBar.h
//  MyRatingBar



#import <UIKit/UIKit.h>


typedef void(^block) (NSInteger inter);
@interface RatingBar : UIView


@property (nonatomic,assign) NSInteger starNumber;
@property (nonatomic,strong) UIColor *viewColor;

@property (nonatomic,assign) BOOL enable;

@property (nonatomic,copy) block block;
@end
