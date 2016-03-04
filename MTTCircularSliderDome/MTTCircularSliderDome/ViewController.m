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

@property (nonatomic, strong) MTTCircularSlider* slider;
@property (nonatomic, strong) UILabel* angleLabel;
@property (nonatomic, strong) UILabel* valueLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:44 / 255.0 blue:48 / 255.0 alpha:1];
    [self.view addSubview:self.angleLabel];
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.slider];
}
- (MTTCircularSlider*)slider
{
    if (!_slider) {
        _slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
        _slider.center = self.view.center;
        _slider.lineWidth = 40;
        _slider.angle = 180;
        //        _slider.maxAngle = 270;
        //        _slider.minAngle = 90;
        _slider.maxValue = 100;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _slider;
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
        _angleLabel.text = [NSString stringWithFormat:@" %li°", self.slider.angle];
    }
    return _angleLabel;
}
- (UILabel*)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.frame = CGRectMake(0, self.slider.frame.origin.y - 60, self.view.frame.size.width, 40);
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont boldSystemFontOfSize:40];
        _valueLabel.textColor = [UIColor colorWithRed:254 / 255.0 green:185 / 255.0 blue:19 / 255.0 alpha:1];
        _valueLabel.text = [NSString stringWithFormat:@"%.1f%%", self.slider.value];
    }
    return _valueLabel;
}
- (void)sliderValueChanged:(MTTCircularSlider*)slider
{
    self.angleLabel.text = [NSString stringWithFormat:@" %li°", slider.angle];
}
- (void)sliderEditingDidEnd:(MTTCircularSlider*)slider
{
    self.valueLabel.text = [NSString stringWithFormat:@"%.1f%%", self.slider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
