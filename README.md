# HNPopMenu
类似QQ和微信的弹出式菜单

![](https://github.com/ZakariyyaSv/HNQQPopMenu/raw/master/demo.png)

### 用法

1. 将source目录下的代码复制到项目目录下；
2. 只需要一行代码实现弹出式菜单,支持block和代理两种创建方式：<br>

```objectivec
// block
[HNPopMenuManager showPopMenuWithView:<#view#> items:<#array#> action:^(NSInteger row) {
        NSLog(@"第%ld行被点击了",row);
    } dismissed:YES];
```

```objectivec
// delegate
[HNPopMenuManager showPopMenuWithView:<#view#> items:<#array#> delegate:<#delegate#> dismissed:YES];
```

### 贡献者

[ZakariyyaSv](https://github.com/ZakariyyaSv)


