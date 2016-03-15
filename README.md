# MTTCircularSlider

MTTCircularSlider 是一个IOS平台上的圆形滑杆控件

![(Dome)](http://ww1.sinaimg.cn/large/abb730d0gw1f1wg2u3h3dg208w0fs4qp.gif)

# 安装

MTTCircularSlider 支持 [CocoaPods](http://cocoapods.org).你可以在你项目中的Podfile文件内添加以下代码添加MTTCircularSlider:

```ruby
pod 'MTTCircularSlider'
```

# 使用

在`/MTTCircularSliderDome`内写有比较详细的Dome,可直接查看代码

#### 默认样式
``` objectivec
MTTCircularSlider* slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
[self.view addSubview:slider];
```
你还可以通过设置以下参数修改UI
``` objectivec
@property (nonatomic) CGFloat lineWidth;//圆环宽度
@property (nonatomic, strong) UIColor* selectColor;//选中部分颜色
@property (nonatomic, strong) UIColor* unselectColor;//未选中部分颜色
@property (nonatomic, strong) UIColor* indicatorColor;//指示器颜色
@property (nonatomic) CGFloat contextPadding;//内边距
```

#### 自定义图片样式
![Dome](http://7xrv0w.com1.z0.glb.clouddn.com/image_style_dome.gif)
``` objectivec
slider.sliderStyle = MTTCircularSliderStyleImage;
slider.unselectImage = [UIImage imageNamed:@"unselect.png"];
slider.selectImage = [UIImage imageNamed:@"select.png"];
slider.indicatorImage = [UIImage imageNamed:@"indicator.png"];
```

图片素材参考,图片的大小建议一样

![unselectImage](http://7xrv0w.com1.z0.glb.clouddn.com/unselect.png?imageView/2/w/200/)
![selectImage](http://7xrv0w.com1.z0.glb.clouddn.com/select.png?imageView/2/w/200/)
![indicatorImage](http://7xrv0w.com1.z0.glb.clouddn.com/indicator.png?imageView/2/w/200/)


#### 事件
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
/**
 *  圆圈宽度,默认:20
 */
@property (nonatomic) CGFloat lineWidth;
/**
 *  已选中进度颜色,默认:red:0.04 green:0.41 blue:1
 */
@property (nonatomic, strong) UIColor* selectColor;
/**
 *  未选中进度颜色,默认:red:0.71 green:0.71 blue:0.71
 */
@property (nonatomic, strong) UIColor* unselectColor;
/**
 *  指示器颜色,默认:whiteColor
 */
@property (nonatomic, strong) UIColor* indicatorColor;
/**
 *  内边距,默认:10
 */
@property (nonatomic) CGFloat contextPadding;
```
#### MTTCircularSliderStyleImage
以下参数仅在`MTTCircularSliderStyleImage`样式下生效

``` objectivec
/**
 *  已选中进度图片
 */
@property (nonatomic, strong) UIImage* selectImage;
/**
 *  已选中进度图片
 */
@property (nonatomic, strong) UIImage* unselectImage;
/**
 *  指示器图片
 */
@property (nonatomic, strong) UIImage* indicatorImage;
```
#### Angle
可以设置以下参数对角度进行操作
``` objectivec
/**
 *  当前角度,默认:0
 */
@property (nonatomic) NSInteger angle;
/**
 *  最大角度,默认:360
 */
@property (nonatomic) NSInteger maxAngle;
/**
 *  最小角度,默认:0
 */
@property (nonatomic) NSInteger minAngle;
```

#### Value
可以设置以下参数对Value进行操作
``` objectivec
/**
 *  当前数值,默认:0
 */
@property (nonatomic) CGFloat value;
/**
 *  最小数值,默认:0
 */
@property (nonatomic) CGFloat minValue;
/**
 *  最大数值,默认:1
 */
@property (nonatomic) CGFloat maxValue;
```

# License

MIT
