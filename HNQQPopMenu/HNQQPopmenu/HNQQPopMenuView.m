//
//  HNQQDropMenuView.m
//  HNQQPopMenu
//
//  Created by 许浩男 on 16/4/2.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

#import "HNQQPopMenuView.h"
#import "HNPopMenuTableViewCell.h"
#import "HNQQPopMenuManager.h"
#import "HNQQPopMenuModel.h"

static const CGFloat triangleHeight = 10.0f;
static const CGFloat margin = 10.0f;

@interface HNQQPopMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,assign) CGPoint startPoint;

@end

@implementation HNQQPopMenuView

- (instancetype)initWithView:(UIView *)view items:(NSArray *)itemArr{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        _menuWidth = 150.0f;
        _cellHeight = 40.0f;
        CGPoint centerPoint = view.center;
        CGFloat tableViewY = CGRectGetMaxY(view.frame) + margin - 0.5 * _cellHeight * itemArr.count;
        CGFloat tableViewX = centerPoint.x - _menuWidth * 0.5 + _menuWidth * 0.5;
        if (tableViewX < margin + _menuWidth * 0.5) {
            tableViewX = margin - _menuWidth * 0.5;
        }
        else if (tableViewX + _menuWidth > [UIScreen mainScreen].bounds.size.width - margin){
            tableViewX = [UIScreen mainScreen].bounds.size.width - margin - _menuWidth * 0.5;
        }
        _startPoint = CGPointMake(centerPoint.x, tableViewY - triangleHeight + 0.5 * _cellHeight * itemArr.count);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, _menuWidth, _cellHeight * itemArr.count) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.cornerRadius = 10.0f;
        _tableView.layer.masksToBounds = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.layer.anchorPoint = centerPoint.x > [UIScreen mainScreen].bounds.size.width * 0.5 ? CGPointMake(1.0f, 0.0f) :CGPointMake(0.0f, 0.0f);
        _tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        _tableView.rowHeight = _cellHeight;
        _dataArr = itemArr;
        [self addSubview:_tableView];
        [self drawTriangleLayer];
    }
    return self;
}

- (void)drawTriangleLayer{
    CGFloat triangleLength = triangleHeight * 2.0 / 1.732;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_startPoint];
    [path addLineToPoint:CGPointMake(_startPoint.x - triangleLength * 0.5, _startPoint.y + triangleHeight)];
    [path addLineToPoint:CGPointMake(_startPoint.x + triangleLength * 0.5, _startPoint.y + triangleHeight)];
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.path = path.CGPath;
    triangleLayer.fillColor = [UIColor whiteColor].CGColor;
    triangleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.triangleLayer = triangleLayer;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer addSublayer:triangleLayer];
    });
}

- (void)setMenuWidth:(CGFloat)menuWidth{
    _menuWidth = menuWidth;
    CGRect tableViewFrame = _tableView.frame;
    CGPoint tableViewCenter = _tableView.center;
    tableViewFrame.size.width = _menuWidth;
    tableViewFrame.origin.x = tableViewCenter.x - _menuWidth * 0.5;
    if (tableViewFrame.origin.x < margin + _menuWidth * 0.5) {
        tableViewFrame.origin.x = margin - _menuWidth * 0.5;
    }
    else if (tableViewFrame.origin.x > [UIScreen mainScreen].bounds.size.width - margin){
        tableViewFrame.origin.x = [UIScreen mainScreen].bounds.size.width - margin - _menuWidth * 0.5;
    }
    _tableView.frame = tableViewFrame;
}

- (void)setCellHeight:(CGFloat)cellHeight{
    _cellHeight = cellHeight;
    _tableView.rowHeight = _cellHeight;
}

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextBeginPath(context);
//    CGFloat triangleLength = triangleHeight * 2.0 / 1.732;
//    CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);
//    CGContextAddLineToPoint(context, _startPoint.x - triangleLength * 0.5, _startPoint.y + triangleHeight);
//    CGContextAddLineToPoint(context, _startPoint.x + triangleLength * 0.5, _startPoint.y + triangleHeight);
//    CGContextClosePath(context);
//    [[UIColor whiteColor] setFill];
//    [[UIColor whiteColor] setStroke];
//    CGContextDrawPath(context, kCGPathFillStroke);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [HNQQPopMenuManager dismiss];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HNPopMenuTableViewCell *cell = [[HNPopMenuTableViewCell alloc] initWithTableView:tableView];
    HNQQPopMenuModel *model = self.dataArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.imageName];
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(QQPopMenuView:didSelectRow:)]) {
        [self.delegate QQPopMenuView:self didSelectRow:indexPath.row];
        [HNQQPopMenuManager dismiss];
    }
    if (self.clickAction) {
        self.clickAction(indexPath.row);
        [HNQQPopMenuManager dismiss];
    }
}


@end
