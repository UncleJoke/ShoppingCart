//
//  CartCell.h
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCartInfo;

@interface CartCell : UITableViewCell

@property (copy  , nonatomic) void (^itemSelectBlock)(BOOL select , id item);

+ (CartCell*)tableView:(UITableView *)tableView data:(id)data;
+ (CGFloat)cellHeight:(ShoppingCartInfo*)item;

@end
