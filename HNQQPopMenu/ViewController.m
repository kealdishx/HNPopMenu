//
//  ViewController.m
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import "ViewController.h"
#import "HNPopMenuManager.h"
#import "HNPopMenuModel.h"

@interface ViewController ()<HNPopMenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation ViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        NSMutableArray *tempArr = [NSMutableArray array];
        NSArray *titleArr = @[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱", @"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱", @"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱", @"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"];
        for (int i = 1; i < 20; i++) {
            HNPopMenuModel *model = [[HNPopMenuModel alloc] init];
            model.title = titleArr[i - 1];
            model.imageName = [NSString stringWithFormat:@"menu_%d",(i % 5) + 1];
            [tempArr addObject:model];
        }
        _dataArr = [tempArr mutableCopy];
    }
    return _dataArr;
}
- (IBAction)addLeftPopMenu {
    [HNPopMenuManager showPopMenuWithView:self.leftButton items:self.dataArr delegate:self dismissAutomatically:YES];
}

- (IBAction)addRightPopMenu:(id)sender {
    [HNPopMenuManager showPopMenuWithView:self.rightButton items:self.dataArr action:^(NSInteger row) {
        NSLog(@"第%ld行被点击了",row);
    } dismissAutomatically:NO];
}


- (void)QQPopMenuView:(HNPopMenuView *)menuView didSelectRow:(NSInteger)row{
    NSLog(@"第%ld行被点击了",row);
}





@end
