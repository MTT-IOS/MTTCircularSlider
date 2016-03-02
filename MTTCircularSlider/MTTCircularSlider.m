//
//  MTTCircularSlider.m
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import "MTTCircularSlider.h"

@interface MTTCircularSlider () {
    CGFloat minRotation;
}

@property (nonatomic) CGFloat rotation;

@property (nonatomic) CGAffineTransform currentTransform;

@end

@implementation MTTCircularSlider

@synthesize maxAngle = _maxAngle;
@synthesize minAngle = _minAngle;
@synthesize isCirculate = _isCirculate;
@synthesize currentTransform = _currentTransform;

#pragma mark UI
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGFloat lineOffset = self.lineWidth / 2;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBStrokeColor(context, 100 / 255.0, 150 / 255.0, 100 / 255.0, 1.0);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, rect.size.width / 2 - lineOffset, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);

    CGContextSetRGBStrokeColor(context, 100 / 255.0, 50 / 255.0, 100 / 255.0, 1.0);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, rect.size.width / 2 - lineOffset, minRotation, self.rotation, 0);
    CGContextDrawPath(context, kCGPathStroke);

    CGPoint centerPoint = CGPointMake(rect.size.width / 2 - lineOffset, rect.size.height / 2 - lineOffset);
    CGPoint dotPoint;
    dotPoint.y = round(centerPoint.y + centerPoint.y * sin(self.rotation));
    dotPoint.x = round(centerPoint.x + centerPoint.x * cos(self.rotation));
    [[UIColor colorWithWhite:1.0 alpha:1] set];
    CGContextFillEllipseInRect(context, CGRectMake(((int)dotPoint.x), ((int)dotPoint.y), self.lineWidth, self.lineWidth));
}

#pragma mark Event
- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(nullable UIEvent*)event
{
    [super continueTrackingWithTouch:touch withEvent:event];

    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint starTouchPoint = [touch locationInView:self];
    CGPoint endTouchPoint = [touch previousLocationInView:self];
    CGFloat rotation = atan2f(starTouchPoint.y - center.y, starTouchPoint.x - center.x) - atan2f(endTouchPoint.y - center.y, endTouchPoint.x - center.x);

    CGAffineTransform transform = CGAffineTransformRotate(self.currentTransform, rotation);
    [self changAngleWithTransform:transform];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}
- (void)endTrackingWithTouch:(nullable UITouch*)touch withEvent:(nullable UIEvent*)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
}

#pragma mark Angle
- (CGAffineTransform)currentTransform
{
    if (CGAffineTransformEqualToTransform(_currentTransform, CGAffineTransformMake(0, 0, 0, 0, 0, 0))) {
        _currentTransform = self.transform;
    }
    return _currentTransform;
}
- (NSInteger)maxAngle
{
    if (!_maxAngle) {
        _maxAngle = 360;
    }
    return _maxAngle;
}
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
    minRotation = (transform.b < 0) ? (2 * M_PI - r) : r;
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
    self.currentTransform = transform;
    CGFloat r = acosf(transform.a);
    self.rotation = (transform.b < 0) ? (2 * M_PI - r) : r;
    [self setNeedsDisplay];

    _value = self.minValue + ((self.maxValue - self.minValue) * ((float)_angle / (float)self.maxAngle));
}
- (void)changAngleWithTransform:(CGAffineTransform)transform
{
    if (!self.isCirculate) {
        if (self.currentTransform.b < 0 && self.currentTransform.a > 0 && transform.b > 0 && transform.a > 0) {
            if (self.angle == 360) {
                return;
            }
            self.angle = 360;
            return;
        }
        else if (self.currentTransform.b >= 0 && self.currentTransform.a >= 0 && transform.b < 0 && transform.a > 0) {
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

#pragma mark Value
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
    //    self.minAngle +
    self.angle = ((self.value - self.minValue) / (self.maxValue - self.minValue)) * self.maxAngle;
}
- (CGFloat)maxValue
{
    if (!_maxValue) {
        _maxValue = 360;
    }
    return _maxValue;
}
- (CGFloat)lineWidth
{
    if (!_lineWidth) {
        _lineWidth = 10;
    }
    return _lineWidth;
}

@end
