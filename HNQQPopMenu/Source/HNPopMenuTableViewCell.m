//
//  HNPopMenuTableViewCell.m
//  HNPopMenu
//
//  Created by ZakariyyaSv on 16/4/2.
//  Copyright © 2016年 ZakariyyaSv. All rights reserved.
//

#import "HNPopMenuTableViewCell.h"

@implementation HNPopMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"popmenuTableViewCell";
    HNPopMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HNPopMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return cell;
}

@end
