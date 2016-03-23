//
//  UIImage+navationBar.m
//  ManClothes
//

//

#import "UIImage+navationBar.h"

@implementation UIImage (navationBar)

-(UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}
@end
