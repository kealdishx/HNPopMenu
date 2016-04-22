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

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNQQPopMenuViewDelegate>)delegate dismissAutomatically:(BOOL)dismissed{
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


- (instancetype)init{
    [NSException raise:NSInvalidArgumentException format:@"%s Using the %@ initializer directly is not supported. Use %@ or %@ instead.", __PRETTY_FUNCTION__,NSStringFromSelector(@selector(init)),NSStringFromSelector(@selector(showPopMenuWithView:items:action:dismissedAutomatically:)),NSStringFromSelector(@selector(showPopMenuWithView:items:delegate:dismissedAutomatically:))];
    return nil;
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

- (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNQQPopMenuViewDelegate>)delegate dismissedAutomatically:(BOOL)dismissed{
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
        self.popmenuView.tableView.backgroundColor = color;
    }
}

- (void)setBackView:(UIView *)view{
    if (self.popmenuView) {
        self.popmenuView.tableView.backgroundView = view;
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
