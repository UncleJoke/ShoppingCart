//
//  GoodsCell.m
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "GoodsCell.h"
#import "ShoppingCartInfo.h"


@interface GoodsCell ()

@property (strong, nonatomic) UIImageView     *goodsView;
@property (strong, nonatomic) UILabel     *desLabel;
@property (strong, nonatomic) UILabel     *nameLabel;
@property (strong, nonatomic) UIButton    *selectButton;
@property (strong, nonatomic) GoodsInfo    *item;

@end

@implementation GoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubviews];
    }
    return self;
}

+ (CGFloat)cellHeight
{
    return 100;
}
+ (UIColor *)randomColor
{
    CGFloat red     = ( arc4random() % 256);
    CGFloat green   = ( arc4random() % 256);
    CGFloat blue    = ( arc4random() % 256);
    
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
}

- (void)setItem:(GoodsInfo *)item
{
    _item = item;
    
    self.selectButton.selected = item.select;
    
    self.nameLabel.text = item.goodsName;
    self.desLabel.text = item.goodsDescription;
    
    
    self.selectButton.frame = CGRectMake(15, ([self.class cellHeight] - 25)/2, 25, 25);
    self.goodsView.frame = CGRectMake(45, 0, [self.class cellHeight] , [self.class cellHeight]);
    self.nameLabel.frame = CGRectMake(50 + [self.class cellHeight], 5, 100, 20);
    self.desLabel.frame = CGRectMake(50 + [self.class cellHeight], 25, SCREEN_WIDTH - 50 - [self.class cellHeight] , [self.class cellHeight] - 25);

}

- (void)buttonClick:(UIButton*)button
{
    button.selected = !button.selected;
    self.item.select = button.selected;
    if (self.itemSelectBlock) {
        self.itemSelectBlock(button.selected,self.item);
    }
}

- (void)setupSubviews
{
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"orimuse_uncollect"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"orimuse_collect"] forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:_selectButton];
    
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_nameLabel];
    
    self.desLabel = [[UILabel alloc]init];
    _desLabel.font = [UIFont systemFontOfSize:14];
    _desLabel.numberOfLines = 0;
    _desLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_desLabel];
    
    self.goodsView = [[UIImageView alloc]init];
    _goodsView.backgroundColor = [self.class randomColor];
    [self.contentView addSubview:_goodsView];

}

+ (GoodsCell*)tableView:(UITableView *)tableView data:(id)data
{
    static NSString *cellID = @"GoodsCell";
    GoodsCell *cell = (GoodsCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[GoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell setItem:data];
    return cell;
}


@end
