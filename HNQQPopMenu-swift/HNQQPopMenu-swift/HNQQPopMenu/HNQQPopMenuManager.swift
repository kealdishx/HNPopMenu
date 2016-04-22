//
//  HNQQPopMenuManager.swift
//  HNQQPopMenu-swift
//
//  Created by zakariyyaSv on 16/4/22.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

import UIKit

typealias actionClosure = (NSInteger) -> Void


class HNQQPopMenuManager: NSObject {
    
    private var popMenuView : HNQQPopMenuView!
    
    private class var sharedInstance: HNQQPopMenuManager {
        struct Static {
            static var once :dispatch_once_t = 0
            static var instance : HNQQPopMenuManager? = nil
        }
        dispatch_once(&Static.once){
            Static.instance = HNQQPopMenuManager()
        }
        
        return Static.instance!
    }
    
    class func showPopMenuView(view:UIView,itemArr:Array<HNQQPopMenuModel>,delegate:HNQQPopMenuViewDelegate,dismissAutomatically:Bool){
        self.sharedInstance.showPopMenuView(view, itemArr: itemArr, delegate: delegate, dismissedAutomatically: dismissAutomatically)
    }
    
    class func showPopMenuView(view:UIView,itemArr:Array<HNQQPopMenuModel>,action:actionClosure,dismissAutomatically:Bool){
        self.sharedInstance.showPopMenuView(view, itemArr: itemArr, action: action, dismissedAutomatically: dismissAutomatically)
    }
    
    class func setBackgroundColor(color:UIColor){
        self.sharedInstance.setBackgroundColor(color)
    }
    
    class func setBackgroundView(view:UIView){
        self.sharedInstance.setBackView(view)
    }
    
    class func dismiss(){
       self.sharedInstance.dismiss()
    }
    
    
    private func showPopMenuView(view:UIView,itemArr:Array<HNQQPopMenuModel>,delegate:HNQQPopMenuViewDelegate,dismissedAutomatically:Bool){
        self.showPopMenuView(view, itemArr: itemArr)
        popMenuView.delegate = delegate
        popMenuView.dismissed = dismissedAutomatically
    }
    
    private func showPopMenuView(view:UIView,itemArr:Array<HNQQPopMenuModel>,action:actionClosure?,dismissedAutomatically:Bool){
        self.showPopMenuView(view, itemArr: itemArr)
        if (action != nil) {
            popMenuView.action = action
        }
        popMenuView.dismissed = dismissedAutomatically
    }
    
    private func showPopMenuView(view:UIView,itemArr:Array<HNQQPopMenuModel>){
        if (popMenuView != nil) {
            self.dismiss()
        }
        popMenuView = HNQQPopMenuView.init(view: view, itemArr: itemArr)
        popMenuView.frame = UIScreen.mainScreen().bounds
        UIApplication.sharedApplication().keyWindow?.addSubview(popMenuView)
        UIView.animateWithDuration(0.25) { 
            () -> Void in
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }
    
    private func setBackgroundColor(color:UIColor){
        if (popMenuView != nil) {
            popMenuView.tableViewBackgroundColor(color)
        }
    }
    
    private func setBackView(view:UIView){
        if (popMenuView != nil) {
            popMenuView.tableView.backgroundView = view
        }
    }
    
    private func dismiss(){
        
        UIView.animateWithDuration(0.2, animations: { 
            () -> Void in
            self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.001, 0.001)
            let time = dispatch_time(DISPATCH_TIME_NOW,(Int64)(100 * NSEC_PER_MSEC))
            dispatch_after(time, dispatch_get_main_queue(), {
                () -> Void in
                self.popMenuView?.triangleLayer?.removeFromSuperlayer()
            })

            }) { (completed) in
                self.popMenuView?.tableView.removeFromSuperview()
                self.popMenuView.removeFromSuperview()
                self.popMenuView = nil
        }
    }
    
}
