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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MTTCircularSlider* slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    slider.center = self.view.center;
    slider.layer.borderWidth = 1;
    slider.lineWidth = 40;
    slider.backgroundColor = [UIColor clearColor];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}
- (void)sliderValueChanged:(MTTCircularSlider*)send
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
