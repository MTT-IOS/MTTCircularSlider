//
//  ViewController.m
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import "MTTCircularSlider.h"
#import "ViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UISegmentedControl* segmented;

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) UIView* defaultDomeView;
@property (nonatomic, strong) UILabel* valueLabel;
@property (nonatomic, strong) MTTCircularSlider* defaultSlider;
@property (nonatomic, strong) UILabel* angleLabel;
@property (nonatomic, strong) MTTCircularSlider* minAngleSlider;
@property (nonatomic, strong) MTTCircularSlider* maxAngleSlider;

@property (nonatomic, strong) UIView* imageDomeView;
@property (nonatomic, strong) MTTCircularSlider* imageSlider;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:44 / 255.0 blue:48 / 255.0 alpha:1];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.segmented];
}
- (UISegmentedControl*)segmented
{
    if (!_segmented) {
        _segmented = [[UISegmentedControl alloc] initWithItems:@[ @"Default", @"Image" ]];
        _segmented.frame = CGRectMake(0, 40, 200, 30);
        _segmented.center = CGPointMake(self.view.center.x, _segmented.center.y);
        _segmented.tintColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _segmented.selectedSegmentIndex = 0;
        [_segmented addTarget:self action:@selector(segmentedChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}
- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        _scrollView.scrollEnabled = NO;
        [_scrollView addSubview:self.defaultDomeView];
        [_scrollView addSubview:self.imageDomeView];
    }
    return _scrollView;
}
- (UIView*)defaultDomeView
{
    if (!_defaultDomeView) {
        _defaultDomeView = [UIView new];
        _defaultDomeView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);

        [_defaultDomeView addSubview:self.angleLabel];
        [_defaultDomeView addSubview:self.valueLabel];
        [_defaultDomeView addSubview:self.defaultSlider];
        [_defaultDomeView addSubview:self.minAngleSlider];
        [_defaultDomeView addSubview:self.maxAngleSlider];
    }
    return _defaultDomeView;
}
- (MTTCircularSlider*)defaultSlider
{
    if (!_defaultSlider) {
        _defaultSlider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 250) / 2, CGRectGetMaxY(self.valueLabel.frame) + 10, 250, 250)];
        _defaultSlider.lineWidth = 40;
        _defaultSlider.angle = 180;
        _defaultSlider.maxValue = 100;
        _defaultSlider.selectColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _defaultSlider.unSelectColor = [UIColor colorWithRed:20 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];
        _defaultSlider.tag = 1;
        [_defaultSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_defaultSlider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _defaultSlider;
}
- (MTTCircularSlider*)minAngleSlider
{
    if (!_minAngleSlider) {
        _minAngleSlider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.defaultSlider.frame) + 20, 130, 130)];
        _minAngleSlider.lineWidth = 20;
        _minAngleSlider.angle = self.defaultSlider.minAngle;
        _minAngleSlider.selectColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _minAngleSlider.unSelectColor = [UIColor colorWithRed:20 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];
        _minAngleSlider.tag = 2;
        [_minAngleSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.center = _minAngleSlider.center;
        label.text = @"MinAngle";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        [self.defaultDomeView addSubview:label];
    }
    return _minAngleSlider;
}
- (MTTCircularSlider*)maxAngleSlider
{
    if (!_maxAngleSlider) {
        _maxAngleSlider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.minAngleSlider.frame) + 20, CGRectGetMinY(self.minAngleSlider.frame), 130, 130)];
        _maxAngleSlider.lineWidth = 20;
        _maxAngleSlider.angle = self.defaultSlider.maxAngle;
        _maxAngleSlider.selectColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _maxAngleSlider.unSelectColor = [UIColor colorWithRed:20 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];
        _maxAngleSlider.tag = 3;
        [_maxAngleSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        label.font = [UIFont systemFontOfSize:14];
        label.center = _maxAngleSlider.center;
        label.text = @"MaxAngle";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        [self.defaultDomeView addSubview:label];
    }
    return _maxAngleSlider;
}
- (UILabel*)angleLabel
{
    if (!_angleLabel) {
        _angleLabel = [UILabel new];
        _angleLabel.frame = CGRectMake(0, 0, 120, 40);
        _angleLabel.center = self.defaultSlider.center;
        _angleLabel.textAlignment = NSTextAlignmentCenter;
        _angleLabel.font = [UIFont boldSystemFontOfSize:40];
        _angleLabel.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _angleLabel.text = [NSString stringWithFormat:@" %li°", self.defaultSlider.angle];
    }
    return _angleLabel;
}
- (UILabel*)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.frame = CGRectMake(0, 80, self.view.frame.size.width, 40);
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont boldSystemFontOfSize:40];
        _valueLabel.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _valueLabel.text = [NSString stringWithFormat:@"%.2f%%", self.defaultSlider.value];
    }
    return _valueLabel;
}

- (UIView*)imageDomeView
{
    if (!_imageDomeView) {
        _imageDomeView = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];

        [_imageDomeView addSubview:self.imageSlider];
    }
    return _imageDomeView;
}
- (MTTCircularSlider*)imageSlider
{
    if (!_imageSlider) {
        _imageSlider = [[MTTCircularSlider alloc] init];
        _imageSlider.frame = CGRectMake(0, 0, 260, 260);
        _imageSlider.center = self.defaultDomeView.center;
        _imageSlider.sliderStyle = MTTCircularSliderStyleImage;
        _imageSlider.selectImage = [UIImage imageNamed:@"select"];
        _imageSlider.unSelectImage = [UIImage imageNamed:@"unselect"];
        _imageSlider.indicatorImage = [UIImage imageNamed:@"indicator"];
        _imageSlider.circulate = YES;
    }
    return _imageSlider;
}
- (void)sliderValueChanged:(MTTCircularSlider*)slider
{
    switch (slider.tag) {
    case 2:
        self.defaultSlider.minAngle = slider.angle;
        self.maxAngleSlider.minAngle = slider.angle;
        break;
    case 3:
        self.defaultSlider.maxAngle = slider.angle;
        self.minAngleSlider.maxAngle = slider.angle;
        break;
    default:
        break;
    }
    self.angleLabel.text = [NSString stringWithFormat:@" %li°", self.defaultSlider.angle];
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", self.defaultSlider.value];
}
- (void)sliderEditingDidEnd:(MTTCircularSlider*)slider
{
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", slider.value];
}
- (void)segmentedChangeValue:(UISegmentedControl*)segmented
{
    CGPoint point = CGPointMake(self.scrollView.frame.size.width * segmented.selectedSegmentIndex, 0);
    [self.scrollView setContentOffset:point animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
