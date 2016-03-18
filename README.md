# MTTCircularSlider

[中文介绍](http://mttios.com/2016/03/15/MTTCircularSlider_Usage)

MTTCircularSlider is a circular slider for IOS

![(Dome)](http://ww1.sinaimg.cn/large/abb730d0gw1f1wg2u3h3dg208w0fs4qp.gif)

# Installation

MTTCircularSlider is available on [CocoaPods](http://cocoapods.org). Just add the following to your project Podfile:
```ruby
pod 'MTTCircularSlider'
```

# Usage

See dome Xcode project in `/MTTCircularSliderDome`

#### Default Style
``` objectivec
MTTCircularSlider* slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
[self.view addSubview:slider];
```

#### Image Style
![Dome](http://7xrv0w.com1.z0.glb.clouddn.com/image_style_dome.gif)
``` objectivec
MTTCircularSlider* slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
slider.sliderStyle = MTTCircularSliderStyleImage;
slider.unselectImage = [UIImage imageNamed:@"unselect.png"];
slider.selectImage = [UIImage imageNamed:@"select.png"];
slider.indicatorImage = [UIImage imageNamed:@"indicator.png"];
[self.view addSubview:slider];
```

Image material([PSD Source](http://www.psdgraphics.com/psd/metal-volume-knob-psd/))

![unselectImage](http://7xrv0w.com1.z0.glb.clouddn.com/unselect.png?imageView/2/w/200/)
![selectImage](http://7xrv0w.com1.z0.glb.clouddn.com/select.png?imageView/2/w/200/)
![indicatorImage](http://7xrv0w.com1.z0.glb.clouddn.com/indicator.png?imageView/2/w/200/)


#### Event
``` objectivec
[slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
[slider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd;
```
# Options

#### sliderStyle:(MTTCircularSliderStyle)

* MTTCircularSliderStyleDefault = 1, //Default Style
* MTTCircularSliderStyleImage = 2, //Customize Image Style
* MTTCircularSliderStyleNone = 0, //None Style

``` objectivec
@property (nonatomic) MTTCircularSliderStyle sliderStyle;//Default:MTTCircularSliderStyleDefault
```
#### circulate:(BOOL)
``` objectivec
@property (nonatomic, getter=isCirculate) BOOL circulate;//Default:NO
```

#### MTTCircularSliderStyleDefault
The parameters are effective when `MTTCircularSliderStyleDefault`

``` objectivec
@property (nonatomic) CGFloat lineWidth; //Default:20
@property (nonatomic, strong) UIColor* selectColor; //Default:#0a68ff
@property (nonatomic, strong) UIColor* unselectColor; //Default:#b5b5b5
@property (nonatomic, strong) UIColor* indicatorColor; //Default:#FFFFFF
@property (nonatomic) CGFloat contextPadding; //Default:10
```
#### MTTCircularSliderStyleImage
The parameters are effective when `MTTCircularSliderStyleImage`

``` objectivec
@property (nonatomic, strong) UIImage* selectImage;
@property (nonatomic, strong) UIImage* unselectImage;
@property (nonatomic, strong) UIImage* indicatorImage;
```
#### Angle
``` objectivec
@property (nonatomic) NSInteger angle; //Default:0
@property (nonatomic) NSInteger maxAngle; //Default:360
@property (nonatomic) NSInteger minAngle; //Default:0
```

#### Value
``` objectivec
@property (nonatomic) CGFloat value; //Default:0
@property (nonatomic) CGFloat minValue; //Default:0
@property (nonatomic) CGFloat maxValue; //Default:1
```

# License

MIT
