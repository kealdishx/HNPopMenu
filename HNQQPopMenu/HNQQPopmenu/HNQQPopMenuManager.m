//
//  HNQQPopMenuManager.m
//  HNQQPopMenu
//
//  Created by 许浩男 on 16/4/2.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNQQPopMenuManager.h"

@interface HNQQPopMenuManager()

@property (nonatomic,strong) HNQQPopMenuView *popmenuView;

@end

@implementation HNQQPopMenuManager

+ (instancetype)sharedManager{
    static HNQQPopMenuManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNQQPopMenuManager alloc] init];
    });
    return manager;
}

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNQQPopMenuViewDelegate>)delegate{
    [[self sharedManager] showPopMenuWithView:view items:itemArr delegate:delegate];
}

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action{
    [[self sharedManager] showPopMenuWithView:view items:itemArr action:action];
}

+ (void)dismiss{
    [[self sharedManager] dismiss];
}


#pragma mark - implementation
- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr{
    if (self.popmenuView) {
        [self dismiss];
    }
    self.popmenuView = [[HNQQPopMenuView alloc] initWithView:view items:itemArr];
    self.popmenuView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self.popmenuView];
    
    [UIView animateWithDuration:0.25f animations:^{
            self.popmenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
}

- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNQQPopMenuViewDelegate>)delegate{
    [self showPopMenuWithView:view items:itemArr];
    self.popmenuView.delegate = delegate;
}

- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action{
    [self showPopMenuWithView:view items:itemArr];
    if (action) {
        self.popmenuView.clickAction = action;
    }
}

- (void)dismiss{
    [UIView animateWithDuration:0.2f animations:^{
        self.popmenuView.tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.popmenuView.triangleLayer removeFromSuperlayer];
        });
    } completion:^(BOOL finished) {
        [self.popmenuView.tableView removeFromSuperview];
        [self.popmenuView removeFromSuperview];
        self.popmenuView = nil;
    }];
}



@end
