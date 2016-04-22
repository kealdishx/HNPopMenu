//
//  HNQQPopMenuView.swift
//  HNQQPopMenu-swift
//
//  Created by zakariyyaSv on 16/4/22.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

import UIKit

protocol HNQQPopMenuViewDelegate : class {
    func HNMenuDidSelectRow(menuView:HNQQPopMenuView,row : NSInteger);
}

class HNQQPopMenuView: UIView,UITableViewDelegate,UITableViewDataSource{
    private let triangleHeight : CGFloat = 10.0;
    private let margin : CGFloat = 10.0;
    private var dataArr : [HNQQPopMenuModel]!;
    private var startPoint : CGPoint!;
    var triangleLayer : CAShapeLayer!;
    var action : actionClosure?
    var dismissed = true
    var tableView = UITableView();
    weak var delegate : HNQQPopMenuViewDelegate?;
    
    var menuWidth : CGFloat! = 150.0 {
        didSet {
            if menuWidth != oldValue {
                var tableViewFrame = tableView.frame
                let tableViewCenter = tableView.center
                tableViewFrame.size.width = menuWidth
                tableViewFrame.origin.x = tableViewCenter.x - menuWidth * 0.5
                if tableViewFrame.origin.x < margin + menuWidth * 0.5 {
                    tableViewFrame.origin.x = margin - menuWidth * 0.5
                }
                else if tableViewFrame.origin.x > UIScreen.mainScreen().bounds.size.width - margin{
                    tableViewFrame.origin.x = UIScreen.mainScreen().bounds.size.width - margin - menuWidth * 0.5
                }
                tableView.frame = tableViewFrame

            }
        }
    }
    var cellHeight : CGFloat! = 40.0 {
        didSet {
            if cellHeight != oldValue {
                tableView.rowHeight = cellHeight
            }
            
        }
    }
    init(view : UIView,itemArr:Array<HNQQPopMenuModel>){
        super.init(frame: CGRectZero);
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
        let centerPoint = view.center;
        let tableViewY : CGFloat = CGRectGetMaxY(view.frame) + margin - 0.5 * cellHeight * (CGFloat)(itemArr.count)
        var tableViewX = centerPoint.x - menuWidth * 0.5 + menuWidth * 0.5
        if tableViewX < margin + menuWidth * 0.5 {
            tableViewX = margin - menuWidth * 0.5
        }
        else if tableViewX + menuWidth > UIScreen.mainScreen().bounds.size.width - margin{
            tableViewX = UIScreen.mainScreen().bounds.size.width - margin - menuWidth * 0.5
        }
        startPoint = CGPointMake(centerPoint.x, (CGFloat)(tableViewY) - (CGFloat)(triangleHeight) + 0.5 * (CGFloat)(cellHeight) * (CGFloat)(itemArr.count))
        tableView.frame = CGRectMake(tableViewX, tableViewY, menuWidth, cellHeight * (CGFloat)(itemArr.count))
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.layer.cornerRadius = 10.0
        tableView.layer.masksToBounds = true
        tableView.bounces = false
        tableView.layer.anchorPoint = centerPoint.x > UIScreen.mainScreen().bounds.size.width * 0.5 ? CGPointMake(1.0, 0) : CGPointMake(0.0, 0.0)
        tableView.transform = CGAffineTransformMakeScale(0.001, 0.001)
        tableView.rowHeight = cellHeight
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        dataArr = itemArr
        self.drawTriangleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawTriangleLayer() {
        let triangleLength = triangleHeight * 2.0 / 1.732
        let path = UIBezierPath()
        path.moveToPoint(startPoint)
        path.addLineToPoint(CGPointMake(startPoint.x - triangleLength * 0.5, startPoint.y + triangleHeight))
        path.addLineToPoint(CGPointMake(startPoint.x + triangleLength * 0.5, startPoint.y + triangleHeight))
        triangleLayer = CAShapeLayer()
        triangleLayer.path = path.CGPath
        triangleLayer.fillColor = UIColor.whiteColor().CGColor
        triangleLayer.strokeColor = UIColor.whiteColor().CGColor
        let time = dispatch_time(DISPATCH_TIME_NOW, (Int64)(150 * NSEC_PER_MSEC))
        dispatch_after(time, dispatch_get_main_queue(), {
            () -> Void in
            self.layer.addSublayer(self.triangleLayer)
        })
        
    }
    
    func tableViewBackgroundColor(color:UIColor){
        triangleLayer.removeFromSuperlayer()
        self.drawTriangleLayer()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        HNQQPopMenuManager.dismiss()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : HNPopMenuTableViewCell = HNPopMenuTableViewCell.initWithTableView(tableView)
        let model = dataArr[indexPath.row]
        cell.imageView?.image = UIImage.init(named: model.imageName as String)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView(tableView, didDeselectRowAtIndexPath: indexPath)
        delegate?.HNMenuDidSelectRow(self, row: indexPath.row)
        action?(indexPath.row)
        if dismissed {
            HNQQPopMenuManager.dismiss()
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
