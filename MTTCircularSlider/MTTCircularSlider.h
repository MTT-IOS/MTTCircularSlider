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

@property (nonatomic) MTTCircularSliderStyle sliderStyle;

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor* lineColor;

@property (nonatomic) NSInteger angle;
@property (nonatomic) NSInteger maxAngle;
@property (nonatomic) NSInteger minAngle;

@property (nonatomic) CGFloat value;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat maxValue;

@property (nonatomic) BOOL isCirculate;

@property (nonatomic, strong) UIImageView* imageView;

@end
