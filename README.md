# HNQQPopMenu
类似QQ和微信的弹出式菜单
###只需要一行代码实现弹出式菜单,支持block和代理两种创建方式：<br>
####1.block<br>
```objective-c
[HNQQPopMenuManager showPopMenuWithView:<#view#> items:<#array#> action:^(NSInteger row) {
        NSLog(@"第%ld行被点击了",row);
    }];
```
####2.delegate<br>
```objective-c
[HNQQPopMenuManager showPopMenuWithView:<#view#> items:<#array#> delegate:<#delegate#>];
```

![](https://github.com/ZakariyyaSv/HNQQPopMenu/raw/master/demo.gif =400×600)
