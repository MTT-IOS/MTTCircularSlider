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
    self.opaque = YES;
    _currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    self.maxmumTrackColor = [UIColor colorWithRed:0.4f green:0.6f blue:0.4f alpha:1];
    self.minimumTrackColor = [UIColor colorWithRed:0.4f green:0.2f blue:0.4f alpha:1];
    self.dotColor = [UIColor whiteColor];
    self.maxAngle = 360;
    self.maxValue = 1;
    self.sliderStyle = MTTCircularSliderStyleDefault;
    self.lineWidth = 10;
    self.circulate = NO;
}

#pragma mark -UI
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if (self.sliderStyle == MTTCircularSliderStyleDefault) {
        CGFloat lineOffset = self.lineWidth / 2;

        CGContextRef context = UIGraphicsGetCurrentContext();

        const CGFloat* components = CGColorGetComponents(self.maxmumTrackColor.CGColor);
        CGContextSetStrokeColor(context, components);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, rect.size.width / 2 - lineOffset, 0, 2 * M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);

        components = CGColorGetComponents(self.minimumTrackColor.CGColor);
        CGContextSetStrokeColor(context, components);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, rect.size.width / 2 - lineOffset, _minRotation, _rotation, 0);
        CGContextDrawPath(context, kCGPathStroke);

        CGPoint centerPoint = CGPointMake(rect.size.width / 2 - lineOffset, rect.size.height / 2 - lineOffset);
        CGPoint dotPoint;
        dotPoint.y = round(centerPoint.y + centerPoint.y * sin(_rotation));
        dotPoint.x = round(centerPoint.x + centerPoint.x * cos(_rotation));
        [self.dotColor set];
        CGContextFillEllipseInRect(context, CGRectMake(((int)dotPoint.x), ((int)dotPoint.y), self.lineWidth, self.lineWidth));
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
    if (self.angle > _maxAngle) {
        self.angle = _maxAngle;
    }
}
- (void)setMinAngle:(NSInteger)minAngle
{
    _minAngle = (self.maxAngle < minAngle || minAngle < 0) ? 0 : minAngle;
    if (self.angle < _minAngle) {
        self.angle = _minAngle;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation((M_PI * _minAngle) / 180.0);
    CGFloat r = acosf(transform.a);
    _minRotation = (transform.b < 0) ? (2 * M_PI - r) : r;
}
- (void)setAngle:(NSInteger)angle
{
    if (angle > self.maxAngle) {
        _angle = self.maxAngle;
    }
    else if (angle < self.minAngle) {
        _angle = self.minAngle;
    }
    else {
        _angle = angle;
    }

    CGAffineTransform transform = CGAffineTransformMakeRotation((M_PI * _angle) / 180.0);
    _currentTransform = transform;
    CGFloat r = acosf(transform.a);
    _rotation = (transform.b < 0) ? (2 * M_PI - r) : r;

    _value = self.minValue + ((self.maxValue - self.minValue) * ((float)_angle / (float)self.maxAngle));

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
    CGFloat rotation = (transform.b < 0) ? (2 * M_PI - r) : r;
    CGFloat angle = rotation / M_PI * 180;
    self.angle = angle;
}

#pragma mark -Value
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
    self.angle = ((self.value - self.minValue) / (self.maxValue - self.minValue)) * self.maxAngle;
}

#pragma mark -UI Attribute
- (void)setMinimumTrackColor:(UIColor*)minimumTrackColor
{
    _minimumTrackColor = minimumTrackColor;
    [self setNeedsDisplay];
}
- (void)setMaxmumTrackColor:(UIColor*)maxmumTrackColor
{
    _maxmumTrackColor = maxmumTrackColor;
    [self setNeedsDisplay];
}
- (void)setDotColor:(UIColor*)dotColor
{
    _dotColor = dotColor;
    [self setNeedsDisplay];
}
- (void)setSliderStyle:(MTTCircularSliderStyle)sliderStyle
{
    _sliderStyle = sliderStyle;
    if (sliderStyle == MTTCircularSliderStyleDefault) {
        [self setNeedsDisplay];
    }
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
@end
