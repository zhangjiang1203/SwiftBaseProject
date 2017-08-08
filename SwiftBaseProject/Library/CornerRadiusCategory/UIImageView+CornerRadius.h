//
//  UIImageView+CornerRadius.h
//  MyPractise
//
//  Created by lzy on 16/3/1.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)


- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

/**
 设置图片圆角
 */
- (void)zy_cornerRadiusRoundingRect;

- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

/**
 设置图片自适应
 */
-(void)setImageFitWithImageView;

@end


@interface NSString (Height)

-(CGFloat)getSuitSizeWithFontSize:(float)fontSize bold:(BOOL)bold sizeOfX:(float)x;

@end
