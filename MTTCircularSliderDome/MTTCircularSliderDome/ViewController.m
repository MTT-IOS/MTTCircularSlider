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
@property (nonatomic, strong) UILabel* valueLabel;
@property (nonatomic, strong) UILabel* angleLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.angleLabel];
    [self.view addSubview:self.slider];
}
- (MTTCircularSlider*)slider
{
    if (!_slider) {
        _slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _slider.center = self.view.center;
        _slider.lineWidth = 40;
        _slider.backgroundColor = [UIColor clearColor];
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
    }
    return _angleLabel;
}
- (void)sliderValueChanged:(MTTCircularSlider*)slider
{
    self.angleLabel.text = [NSString stringWithFormat:@" %li°", slider.angle];
}
- (void)sliderEditingDidEnd:(MTTCircularSlider*)slider
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
