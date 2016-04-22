# HNQQPopMenu
类似QQ和微信的弹出式菜单
###只需要一行代码实现弹出式菜单,支持block和代理两种创建方式：<br>
####1.block(闭包)<br>
#####`objective-c`:<br>
```objective-c
[HNQQPopMenuManager showPopMenuWithView:<#view#> items:<#array#> action:^(NSInteger row) {
        NSLog(@"第%ld行被点击了",row);
    } dismissed:YES];
```
#####`swift`:<br>
```swift
 HNQQPopMenuManager.showPopMenuView(view, itemArr: dataArr, action: {
                (row) -> Void in
            print("closure : \(row) clicked")
            }, dismissAutomatically: true)
```
####2.delegate<br>
#####`objective-c`:<br>
```objective-c
[HNQQPopMenuManager showPopMenuWithView:<#view#> items:<#array#> delegate:<#delegate#> dismissed:YES];
```
#####`swift`:<br>
```swift
HNQQPopMenuManager.showPopMenuView(view, itemArr: dataArr, delegate: delegate, dismissAutomatically: true)
```

![](https://github.com/ZakariyyaSv/HNQQPopMenu/raw/master/demo.gif)
