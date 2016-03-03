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

@property (nonatomic, strong) UISegmentedControl* domeSegmented;

@property (nonatomic, strong) UIScrollView* domeScroll;

@property (nonatomic, strong) UIView* defaultDomeView;
@property (nonatomic, strong) MTTCircularSlider* defaultSlider;
@property (nonatomic, strong) UILabel* angleLabel;
@property (nonatomic, strong) UILabel* valueLabel;

@property (nonatomic, strong) UIView* imageDomeView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:44 / 255.0 blue:48 / 255.0 alpha:1];
    [self.view addSubview:self.domeScroll];
    [self.view addSubview:self.domeSegmented];
}
- (UISegmentedControl*)domeSegmented
{
    if (!_domeSegmented) {
        _domeSegmented = [[UISegmentedControl alloc] initWithItems:@[ @"Default", @"Image" ]];
        _domeSegmented.frame = CGRectMake(0, 40, 200, 30);
        _domeSegmented.center = CGPointMake(self.view.center.x, _domeSegmented.center.y);
        _domeSegmented.tintColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _domeSegmented.selectedSegmentIndex = 0;
    }
    return _domeSegmented;
}
- (UIScrollView*)domeScroll
{
    if (!_domeScroll) {
        _domeScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _domeScroll.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
        _domeScroll.pagingEnabled = YES;
        [_domeScroll addSubview:self.defaultDomeView];
    }
    return _domeScroll;
}
- (UIView*)defaultDomeView
{
    if (!_defaultDomeView) {
        _defaultDomeView = [UIView new];
        _defaultDomeView.frame = CGRectMake(0, 0, self.domeScroll.frame.size.width, self.domeScroll.frame.size.height);

        [_defaultDomeView addSubview:self.angleLabel];
        [_defaultDomeView addSubview:self.valueLabel];
        [_defaultDomeView addSubview:self.defaultSlider];
    }
    return _defaultDomeView;
}
- (MTTCircularSlider*)defaultSlider
{
    if (!_defaultSlider) {
        _defaultSlider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
        _defaultSlider.center = self.defaultDomeView.center;
        _defaultSlider.lineWidth = 40;
        _defaultSlider.angle = 180;
        _defaultSlider.maxValue = 100;
        _defaultSlider.selectColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _defaultSlider.unSelectColor = [UIColor colorWithRed:20 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];

        [_defaultSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_defaultSlider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _defaultSlider;
}
- (UILabel*)angleLabel
{
    if (!_angleLabel) {
        _angleLabel = [UILabel new];
        _angleLabel.frame = CGRectMake(0, 0, 120, 40);
        _angleLabel.center = self.view.center;
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
        _valueLabel.frame = CGRectMake(0, self.defaultSlider.frame.origin.y - 60, self.view.frame.size.width, 40);
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont boldSystemFontOfSize:40];
        _valueLabel.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _valueLabel.text = [NSString stringWithFormat:@"%.2f%%", self.defaultSlider.value];
    }
    return _valueLabel;
}
- (void)sliderValueChanged:(MTTCircularSlider*)slider
{
    self.angleLabel.text = [NSString stringWithFormat:@" %li°", slider.angle];
}
- (void)sliderEditingDidEnd:(MTTCircularSlider*)slider
{
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", slider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
