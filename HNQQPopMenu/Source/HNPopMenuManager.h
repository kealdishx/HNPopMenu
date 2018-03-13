//
//  HNPopMenuManager.h
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HNPopMenuView.h"

@class HNPopMenuManager;

@interface HNPopMenuManager : NSObject

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr delegate:(id<HNPopMenuViewDelegate>)delegate dismissAutomatically:(BOOL)dismissed;

+ (void)showPopMenuWithView:(UIView *)view items:(NSArray *)itemArr action:(action)action dismissAutomatically:(BOOL)dismissed;

+ (void)setBackgroundColor:(UIColor *)color;

+ (void)setBackgroundView:(UIView *)view;

+ (void)dismiss;

@end
