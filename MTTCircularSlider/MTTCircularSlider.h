//
//  MTTCircularSlider.h
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MTTCircularSliderStyle) {
    MTTCircularSliderStyleDefault = 1, //默认样式
    MTTCircularSliderStyleImage = 2, //自定义图片样式
    MTTCircularSliderStyleNone = 0, //无样式
};

@interface MTTCircularSlider : UIControl

#pragma mark -UI Attribute
@property (nonatomic) MTTCircularSliderStyle sliderStyle; //控件样式,默认:MTTCircularSliderStyleDefault
@property (nonatomic, getter=isCirculate) BOOL circulate; //设置是否连通循环滑动,默认:NO

#pragma mark -MTTCircularSliderStyleDefault
@property (nonatomic) CGFloat lineWidth; //圆环宽度,默认:20
@property (nonatomic, strong) UIColor* selectColor; //已选中进度颜色,默认:#0a68ff
@property (nonatomic, strong) UIColor* unselectColor; //未选中进度颜色,默认:#b5b5b5
@property (nonatomic, strong) UIColor* indicatorColor; //指示器颜色,默认:#FFFFFF
@property (nonatomic) CGFloat contextPadding; //内边距,默认:10

#pragma mark -MTTCircularSliderStyleImage
@property (nonatomic, strong) UIImage* selectImage; //已选中进度图片
@property (nonatomic, strong) UIImage* unselectImage; //已选中进度图片
@property (nonatomic, strong) UIImage* indicatorImage; //指示器图片

#pragma mark -Angle
@property (nonatomic) NSInteger angle; //当前角度,默认:0
@property (nonatomic) NSInteger maxAngle; //最大角度,默认:360
@property (nonatomic) NSInteger minAngle; //最小角度,默认:0

#pragma mark -Value
@property (nonatomic) CGFloat value; //当前数值,默认:0
@property (nonatomic) CGFloat minValue; //最小数值,默认:0
@property (nonatomic) CGFloat maxValue; //最大数值,默认:1

@end
