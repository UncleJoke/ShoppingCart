//
//  GoodsCell.h
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface GoodsCell : UITableViewCell

@property (copy  , nonatomic) void (^itemSelectBlock)(BOOL select , id item);


+ (GoodsCell*)tableView:(UITableView *)tableView data:(id)data;

+ (CGFloat)cellHeight;

@end
