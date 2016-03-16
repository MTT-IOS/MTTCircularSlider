# MTTCircularSlider

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
你可以添加`UIControlEventValueChanged`事件,在用户改变角度时触发事件
``` objectivec
[slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
```
你也可以添加`UIControlEventEditingDidEnd`事件,在用户操作结束时触发事件
``` objectivec
[slider addTarget:self action:@selector(sliderEditingDidEnd:) forControlEvents:UIControlEventEditingDidEnd;
```
# 参数

#### sliderStyle:(MTTCircularSliderStyle)
默认值:MTTCircularSliderStyleDefault,用于设置控件样式.

MTTCircularSlider目前有以下3个样式

* MTTCircularSliderStyleDefault = 1, //默认样式
* MTTCircularSliderStyleImage = 2, //自定义图片样式
* MTTCircularSliderStyleNone = 0, //无样式

``` objectivec
@property (nonatomic) MTTCircularSliderStyle sliderStyle;
```
#### circulate:(BOOL)
默认值:NO,设置圆环是否连通循环滑动
``` objectivec
@property (nonatomic, getter=isCirculate) BOOL circulate;
```

#### MTTCircularSliderStyleDefault
以下参数仅在`MTTCircularSliderStyleDefault`样式下生效

``` objectivec
@property (nonatomic) CGFloat lineWidth; //圆环宽度,默认:20
@property (nonatomic, strong) UIColor* selectColor; //已选中进度颜色,默认:#0a68ff
@property (nonatomic, strong) UIColor* unselectColor; //未选中进度颜色,默认:#b5b5b5
@property (nonatomic, strong) UIColor* indicatorColor; //指示器颜色,默认:#FFFFFF
@property (nonatomic) CGFloat contextPadding; //内边距,默认:10
```
#### MTTCircularSliderStyleImage
以下参数仅在`MTTCircularSliderStyleImage`样式下生效

``` objectivec
@property (nonatomic, strong) UIImage* selectImage; //已选中进度图片
@property (nonatomic, strong) UIImage* unselectImage; //已选中进度图片
@property (nonatomic, strong) UIImage* indicatorImage; //指示器图片
```
#### Angle
可以设置以下参数对角度进行操作
``` objectivec
@property (nonatomic) NSInteger angle; //当前角度,默认:0
@property (nonatomic) NSInteger maxAngle; //最大角度,默认:360
@property (nonatomic) NSInteger minAngle; //最小角度,默认:0
```

#### Value
可以设置以下参数对Value进行操作
``` objectivec
@property (nonatomic) CGFloat value; //当前数值,默认:0
@property (nonatomic) CGFloat minValue; //最小数值,默认:0
@property (nonatomic) CGFloat maxValue; //最大数值,默认:1
```

# License

MIT
