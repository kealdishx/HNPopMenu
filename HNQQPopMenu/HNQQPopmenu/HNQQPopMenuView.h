//
//  HNQQDropMenuView.h
//  HNQQPopMenu
//
//  Created by 许浩男 on 16/4/2.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^action)(NSInteger row);

@class HNQQPopMenuView;

@protocol HNQQPopMenuViewDelegate <NSObject>

@optional

- (void)QQPopMenuView:(HNQQPopMenuView *)menuView didSelectRow:(NSInteger)row;

@end

@interface HNQQPopMenuView : UIView

/**
 *  popmenu's width,default is 150.
 */
@property (nonatomic,assign) CGFloat menuWidth;

/**
 *  menu cell's height,default is 40.
 */
@property (nonatomic,assign) CGFloat cellHeight;

// menuView's tableView,menu cell's container.
@property (nonatomic,strong,readonly) UITableView *tableView;

@property (nonatomic,strong) CAShapeLayer *triangleLayer;

@property (nonatomic,weak) id<HNQQPopMenuViewDelegate> delegate;

@property (nonatomic,strong) action clickAction;

- (instancetype)initWithView:(UIView *)view items:(NSArray *)itemArr;



@end
