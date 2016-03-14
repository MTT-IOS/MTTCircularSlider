# MTTCircularSlider

MTTCircularSlider 是一个IOS平台上的圆形滑杆控件

![(Dome)](http://ww1.sinaimg.cn/large/abb730d0gw1f1wg2u3h3dg208w0fs4qp.gif)

# 安装

MTTCircularSlider 支持 [CocoaPods](http://cocoapods.org).你可以在你项目中的Podfile文件内添加以下代码安装MTTCircularSlider:

```ruby
pod 'MTTCircularSlider'
```

# 使用

在`/MTTCircularSliderDome`内写有比较详细的Dome,可直接查看代码

## 默认样式
``` objectivec
MTTCircularSlider* slider = [[MTTCircularSlider alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
[self.view addSubview:slider];
```
## 自定义图片样式
``` objectivec
slider.sliderStyle = MTTCircularSliderStyleImage;
slider.unselectImage = [UIImage imageNamed:@"unselect"];
slider.selectImage = [UIImage imageNamed:@"select"];
slider.indicatorImage = [UIImage imageNamed:@"indicator"];
```
图片素材参考,三张图片的大小建议一样

`unselectImage`
![unselectImage](http://7xrv0w.com1.z0.glb.clouddn.com/unselect%402x.png?imageView/2/w/200/)

`selectImage`
![selectImage](http://7xrv0w.com1.z0.glb.clouddn.com/select%402x.png?imageView/2/w/200/)

`indicatorImage`
![indicatorImage](http://7xrv0w.com1.z0.glb.clouddn.com/indicator%402x.png?imageView/2/w/200/)

# License

MIT
