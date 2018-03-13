//
//  HNPopMenuManager.m
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import "HNPopMenuManager.h"

@interface HNPopMenuManager()

@property (nonatomic,strong) HNPopMenuView *popmenuView;

@end

@implementation HNPopMenuManager

+ (instancetype)sharedManager{
    static HNPopMenuManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNPopMenuManager alloc] init];
    });
    return manager;
}

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNPopMenuViewDelegate>)delegate dismissAutomatically:(BOOL)dismissed{
    [[self sharedManager] showPopMenuWithView:view items:itemArr delegate:delegate dismissedAutomatically:dismissed];
}

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action dismissAutomatically:(BOOL)dismissed{
    [[self sharedManager] showPopMenuWithView:view items:itemArr action:action dismissedAutomatically:dismissed];
}

+ (void)setBackgroundColor:(UIColor *)color{
    [[self sharedManager] setBackgroundColour:color];
}

+ (void)setBackgroundView:(UIView *)view{
    [[self sharedManager] setBackView:view];
}

+ (void)dismiss{
    [[self sharedManager] dismiss];
}

#pragma mark - implementation
- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr{
    if (self.popmenuView) {
        [self dismiss];
    }
    self.popmenuView = [[HNPopMenuView alloc] initWithView:view items:itemArr];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow == nil) {
        return;
    }
    [keyWindow addSubview:self.popmenuView];
    [UIView animateWithDuration:0.2f animations:^{
        self.popmenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        self.popmenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNPopMenuViewDelegate>)delegate dismissedAutomatically:(BOOL)dismissed{
    [self showPopMenuWithView:view items:itemArr];
    self.popmenuView.delegate = delegate;
    self.popmenuView.dismissed = dismissed;
}

- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action dismissedAutomatically:(BOOL)dismissed{
    [self showPopMenuWithView:view items:itemArr];
    self.popmenuView.dismissed = dismissed;
    if (action) {
        self.popmenuView.clickAction = action;
    }
}

- (void)setBackgroundColour:(UIColor *)color{
    if (self.popmenuView) {
        [self.popmenuView setTableViewBackgroundColor:color];
    }
}

- (void)setBackView:(UIView *)view{
    if (self.popmenuView) {
        self.popmenuView.tableView.backgroundView = view;
    }
}

- (void)dismiss{
    [UIView animateWithDuration:0.2f animations:^{
        self.popmenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
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
