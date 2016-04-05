//
//  HNPopMenuTableViewCell.m
//  HNQQPopMenu
//
//  Created by 许浩男 on 16/4/2.
//  Copyright © 2016年 Zakariyya. All rights reserved.
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return cell;
}

@end
