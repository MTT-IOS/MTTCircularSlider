//
//  ViewController.m
//  MTTCircularSliderDome
//
//  Created by Lin on 16/2/26.
//  Copyright © 2016年 MTT. All rights reserved.
//

#import "ViewController.h"
#import "MTTCircularSlider.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MTTCircularSlider* c = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    c.lineWidth = 40;
    //    c.minAngle = 180;
    //    c.backgroundColor = [UIColor clearColor];
    //    c.value = 180;
    [c addTarget:self action:@selector(changValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:c];
}
- (void)changValue:(MTTCircularSlider*)send
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
