//
//  HNPopMenuTableViewCell.swift
//  HNQQPopMenu-swift
//
//  Created by zakariyyaSv on 16/4/22.
//  Copyright © 2016年 Zakariyya. All rights reserved.
//

import UIKit

class HNPopMenuTableViewCell: UITableViewCell {
    
    class func initWithTableView(tableView:UITableView) -> HNPopMenuTableViewCell{
        let identifier = "popMenuTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HNPopMenuTableViewCell
        if (cell == nil) {
            cell = HNPopMenuTableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            cell?.textLabel?.font = UIFont.systemFontOfSize(15.0)
        }
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
