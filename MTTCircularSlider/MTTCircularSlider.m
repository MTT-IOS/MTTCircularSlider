//
//  MTTCircularSlider.m
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import "MTTCircularSlider.h"

@interface MTTCircularSlider () {
    CGFloat _minRotation;
    CGFloat _rotation;
    CGAffineTransform _currentTransform;
}
@end

@implementation MTTCircularSlider

@synthesize maxAngle = _maxAngle;
@synthesize minAngle = _minAngle;
@synthesize circulate = _circulate;

#pragma mark -init
- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib
{
    [self setup];
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    _currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    _unselectColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1];
    _selectColor = [UIColor colorWithRed:0.04 green:0.41 blue:1 alpha:1];
    _indicatorColor = [UIColor whiteColor];
    _maxAngle = 360;
    _maxValue = 1;
    _sliderStyle = MTTCircularSliderStyleDefault;
    _lineWidth = 20;
    _circulate = NO;
    _contextPadding = 10;
}
#pragma mark -Draw UI
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.sliderStyle == MTTCircularSliderStyleDefault) {
        CGFloat lineOffset = self.lineWidth / 2;
        CGSize contextSize = CGSizeMake(rect.size.width - self.contextPadding, rect.size.height - self.contextPadding);
        CGFloat center = rect.size.width / 2;
        CGFloat radius = contextSize.width / 2 - lineOffset;
        CGContextRef context = UIGraphicsGetCurrentContext();

        const CGFloat* components = CGColorGetComponents(self.unselectColor.CGColor);
        CGContextSetStrokeColorWithColor(context, self.unselectColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, center, center, radius, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);

        components = CGColorGetComponents(self.selectColor.CGColor);
        CGContextSetStrokeColorWithColor(context, self.selectColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, center, center, radius, _minRotation, _rotation, 0);
        CGContextDrawPath(context, kCGPathStroke);

        CGPoint centerPoint = CGPointMake(center - lineOffset, center - lineOffset);
        CGPoint dotPoint;
        dotPoint.y = round(centerPoint.y + (centerPoint.y - self.contextPadding / 2) * sin(_rotation));
        dotPoint.x = round(centerPoint.x + (centerPoint.x - self.contextPadding / 2) * cos(_rotation));
        [self.indicatorColor set];
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 4, [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor);
        CGContextFillEllipseInRect(context, CGRectMake((dotPoint.x), (dotPoint.y), self.lineWidth, self.lineWidth));
    }
    else if (self.sliderStyle == MTTCircularSliderStyleImage) {
        CGFloat center = rect.size.width / 2;
        CGRect imageRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextDrawImage(context, imageRect, self.unselectImage.CGImage);

        CGContextSaveGState(context);
        CGContextMoveToPoint(context, center, center);
        CGContextAddArc(context, center, center, center, _minRotation, _rotation, 0);
        CGContextClosePath(context);
        CGContextClip(context);
        CGContextDrawImage(context, imageRect, self.selectImage.CGImage);
        CGContextRestoreGState(context);

        CGContextTranslateCTM(context, center, center);
        CGContextConcatCTM(context, _currentTransform);
        CGContextTranslateCTM(context, -(center), -(center));
        CGContextDrawImage(context, imageRect, self.indicatorImage.CGImage);
    }
}

#pragma mark -Event
- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(nullable UIEvent*)event
{
    [super continueTrackingWithTouch:touch withEvent:event];

    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint starTouchPoint = [touch locationInView:self];
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x) - atan2f(endTouchPoint.y - center.y, endTouchPoint.x - center.x);

    CGAffineTransform transform = CGAffineTransformRotate(_currentTransform, rotation);
    [self changAngleWithTransform:transform];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}
- (void)endTrackingWithTouch:(nullable UITouch*)touch withEvent:(nullable UIEvent*)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark -Angle
- (void)setMaxAngle:(NSInteger)maxAngle
{
    _maxAngle = (self.minAngle > maxAngle || maxAngle > 360) ? 360 : maxAngle;
    self.angle = (self.angle > _maxAngle) ? _maxAngle : self.angle;
    [self setNeedsDisplay];
}
- (void)setMinAngle:(NSInteger)minAngle
{
    _minAngle = (self.maxAngle < minAngle || minAngle < 0) ? 0 : minAngle;
    CGAffineTransform transform = CGAffineTransformMakeRotation((M_PI * _minAngle) / 180.0);
    CGFloat r = acosf(transform.a);
    _minRotation = (transform.b < 0) ? (2 * M_PI - r) : r;
    self.angle = (self.angle < _minAngle) ? _minAngle : self.angle;
    [self setNeedsDisplay];
}
- (void)setAngle:(NSInteger)angle
{
    if (angle > self.maxAngle)
        _angle = self.maxAngle;
    else if (angle < self.minAngle)
        _angle = self.minAngle;
    else
        _angle = angle;

    CGAffineTransform transform = CGAffineTransformMakeRotation((M_PI * _angle) / 180.0);
    _currentTransform = transform;
    CGFloat r = acosf(transform.a);
    _rotation = (transform.b < 0) ? (2 * M_PI - r) : r;

    if (self.maxAngle == self.minAngle) {
        _value = self.maxValue;
    }
    else {
        _value = self.minValue + ((float)_angle - (float)self.minAngle) / ((float)self.maxAngle - (float)self.minAngle) * self.maxValue;
    }

    [self setNeedsDisplay];
}
- (void)changAngleWithTransform:(CGAffineTransform)transform
{
    if (!self.isCirculate) {
        if (_currentTransform.b < 0 && _currentTransform.a > 0 && transform.b > 0 && transform.a > 0) {
            if (self.angle == 360) {
                return;
            }
            self.angle = 360;
            return;
        }
        else if (_currentTransform.b >= 0 && _currentTransform.a >= 0 && transform.b < 0 && transform.a > 0) {
            if (self.angle == 0) {
                return;
            }
            self.angle = 0;
            return;
        }
    }
    CGFloat r = acosf(transform.a);
    _currentTransform = transform;
    _rotation = (transform.b < 0) ? (2 * M_PI - r) : r;
    self.angle = _rotation / M_PI * 180;
}

#pragma mark -Value
- (void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    self.value = self.minValue + ((_maxValue - self.minValue) * ((float)self.angle / (float)self.maxAngle));
}
- (void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    self.value = _minValue + ((self.maxValue - _minValue) * ((float)self.angle / (float)self.maxAngle));
}
- (void)setValue:(CGFloat)value
{
    if (value < self.minValue) {
        _value = self.minValue;
    }
    else if (value > self.maxValue) {
        _value = self.maxValue;
    }
    else {
        _value = value;
    }
    self.angle = _value / self.maxValue * (float)self.maxAngle;
}

#pragma mark -UI Attribute
- (void)setSelectColor:(UIColor*)selectColor
{
    _selectColor = selectColor;
    [self setNeedsDisplay];
}
- (void)setUnselectColor:(UIColor*)unselectColor
{
    _unselectColor = unselectColor;
    [self setNeedsDisplay];
}
- (void)setIndicatorColor:(UIColor*)indicatorColor
{
    _indicatorColor = indicatorColor;
    [self setNeedsDisplay];
}
- (void)setSliderStyle:(MTTCircularSliderStyle)sliderStyle
{
    _sliderStyle = sliderStyle;
    [self setNeedsDisplay];
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
- (void)setSelectImage:(UIImage*)selectImage
{
    _selectImage = selectImage;
    [self setNeedsDisplay];
}
- (void)setUnselectImage:(UIImage*)unselectImage
{
    _unselectImage = unselectImage;
    [self setNeedsDisplay];
}
- (void)setIndicatorImage:(UIImage*)indicatorImage
{
    _indicatorImage = indicatorImage;
    [self setNeedsDisplay];
}
- (void)setContextPadding:(CGFloat)contextPadding
{
    _contextPadding = contextPadding;
    [self setNeedsDisplay];
}
@end
