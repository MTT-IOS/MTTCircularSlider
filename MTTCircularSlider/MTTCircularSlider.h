//
//  MTTCircularSlider.h
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MTTCircularSliderStyle) {
    MTTCircularSliderStyleDefault,
    MTTCircularSliderStyleNone,
};

@interface MTTCircularSlider : UIControl

#pragma mark -UI Attribute
/**
 *  控件样式,默认:MTTCircularSliderStyleDefault
 */
@property (nonatomic) MTTCircularSliderStyle sliderStyle;
/**
 *  圆圈宽度,默认:10
 */
@property (nonatomic) CGFloat lineWidth;
/**
 *  内边距,默认:10
 */
@property (nonatomic) CGFloat contextPadding;
/**
 *  选中颜色,默认:red:1 green:0.72 blue:0.07 alpha:1
 */
@property (nonatomic, strong) UIColor* selectColor;
/**
 *  未选中颜色,默认:red:0.07 green:0.09 blue:0.11 alpha:1
 */
@property (nonatomic, strong) UIColor* unSelectColor;
/**
 *  滑块颜色,默认:whiteColor
 */
@property (nonatomic, strong) UIColor* dotColor;
/**
 *  是否循环滑动,默认:NO
 */
@property (nonatomic, getter=isCirculate) BOOL circulate;

#pragma mark -Angle
/**
 *  当前角度,默认:0
 */
@property (nonatomic) NSInteger angle;
/**
 *  最大角度,默认:360
 */
@property (nonatomic) NSInteger maxAngle;
/**
 *  最小角度,默认:0
 */
@property (nonatomic) NSInteger minAngle;

#pragma mark -Value
/**
 *  当前数值,默认:0
 */
@property (nonatomic) CGFloat value;
/**
 *  最小数值,默认:0
 */
@property (nonatomic) CGFloat minValue;
/**
 *  最大数值,默认:1
 */
@property (nonatomic) CGFloat maxValue;

@end
