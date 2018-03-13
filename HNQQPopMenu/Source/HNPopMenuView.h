//
//  HNQQDropMenuView.h
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^action)(NSInteger row);

@class HNPopMenuView;

@protocol HNPopMenuViewDelegate <NSObject>

@optional

- (void)QQPopMenuView:(HNPopMenuView *)menuView didSelectRow:(NSInteger)row;

@end

@interface HNPopMenuView : UIView

/**
 *  popmenu's width,default is 150.
 */
@property (nonatomic,assign) CGFloat menuWidth;

/**
 *  menu cell's height,default is 44.
 */
@property (nonatomic,assign) CGFloat cellHeight;

/**
 *  the longest distance between menuView and screen, default is 40.
 */
@property (nonatomic,assign) CGFloat limitMargin;

// menuView's tableView,menu cell's container.
@property (nonatomic,strong,readonly) UITableView *tableView;

@property (nonatomic,strong) CAShapeLayer *triangleLayer;

@property (nonatomic,weak) id<HNPopMenuViewDelegate> delegate;

@property (nonatomic,copy) action clickAction;

@property (nonatomic,assign) BOOL dismissed;

- (instancetype)initWithView:(UIView *)view items:(NSArray *)itemArr;

- (void)setTableViewBackgroundColor:(UIColor *)backgroundColor;

@end
