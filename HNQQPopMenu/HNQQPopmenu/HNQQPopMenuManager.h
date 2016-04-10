//
//  HNQQPopMenuManager.h
//  HNQQPopMenu
//
//  Created by 许浩男 on 16/4/2.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HNQQPopMenuView.h"

@class HNQQPopMenuManager;

@interface HNQQPopMenuManager : NSObject

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNQQPopMenuViewDelegate>)delegate dismissAutomatically:(BOOL)dismissed;

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action dismissAutomatically:(BOOL)dismissed;

+ (void)setBackgroundColor:(UIColor *)color;

+ (void)setBackgroundView:(UIView *)view;

+ (void)dismiss;

@end
