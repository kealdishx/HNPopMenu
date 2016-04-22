//
//  ViewController.swift
//  HNQQPopMenu-swift
//
//  Created by zakariyyaSv on 16/4/22.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HNQQPopMenuViewDelegate {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    private var dataArr : [HNQQPopMenuModel]!{
        get {
            var listArr : [HNQQPopMenuModel]! = Array()
            
            let titleArr = ["扫一扫","加好友","创建讨论组","发送到电脑","面对面快传","收钱"]
            for i in 1..<7 {
                let model = HNQQPopMenuModel()
                model.title = titleArr[i - 1]
                model.imageName = "menu_\(i)"
                listArr.append(model)
            }
            return listArr
        }
    }
    
    @IBAction func addLeftAction() {
        HNQQPopMenuManager.showPopMenuView(leftButton, itemArr: dataArr, action: {
                (row) -> Void in
            print("closure : \(row) clicked")
            }, dismissAutomatically: true)
    }
    
    @IBAction func addRightAction() {
        HNQQPopMenuManager.showPopMenuView(rightButton, itemArr: dataArr, delegate: self, dismissAutomatically: true)
    }
    
    func HNMenuDidSelectRow(menuView: HNQQPopMenuView, row: NSInteger) {
        print("delegate : \(row) clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

