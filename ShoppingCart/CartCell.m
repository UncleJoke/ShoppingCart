//
//  CartCell.m
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "CartCell.h"
#import "ShoppingCartInfo.h"
#import "GoodsCell.h"

@interface CartCell()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel     *nameLabel;
@property (strong, nonatomic) UIButton    *selectButton;
@property (strong, nonatomic) ShoppingCartInfo    *item;

@end

@implementation CartCell

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


- (void)setItem:(ShoppingCartInfo *)item
{
    _item = item;
    
    self.selectButton.selected = item.select;
    self.nameLabel.text = item.storeName;
    
    _selectButton.frame = CGRectMake(10, 5, 25, 25);
    _nameLabel.frame = CGRectMake(40, 5, 200, 25);
    self.tableView.frame = CGRectMake(0, 30, SCREEN_WIDTH, [GoodsCell cellHeight]*item.goods.count);
    [self.tableView reloadData];

}

+ (CGFloat)cellHeight:(ShoppingCartInfo*)item
{
    return item.goods.count * [GoodsCell cellHeight] + 25 + 10 + 10;
}

- (void)buttonClick:(UIButton*)button
{
    button.selected = !button.selected;
    self.item.select = button.selected;
    for (GoodsInfo *info in self.item.goods) {
        info.select = button.selected;
    }
    [self.tableView reloadData];
    
    if (self.itemSelectBlock) {
        self.itemSelectBlock(button.selected,self.item);
    }
    
    NSLog(@" %@ %@",self.item.storeName ,button.selected?@"全选了":@"未全选");

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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[GoodsCell class] forCellReuseIdentifier:@"GoodsCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.tableView];
}

#pragma mark Table  Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.item.goods count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GoodsCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = [GoodsCell tableView:tableView data:self.item.goods[indexPath.row]];
    
    cell.itemSelectBlock = ^(BOOL select,id item){
        [self updateData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)updateData
{
    BOOL allSelect = YES;
    for (ShoppingCartInfo *temp in self.item.goods) {
        if (!temp.select) {
            allSelect = NO;
            break;
        }
    }
    self.selectButton.selected = allSelect;
    
    if (allSelect) {
        
        if (self.itemSelectBlock) {
            self.itemSelectBlock(YES,self.item);
        }
    }
    
    NSLog(@" %@ %@",self.item.storeName ,allSelect?@"全选了":@"未全选");

}


+ (CartCell*)tableView:(UITableView *)tableView data:(id)data
{
    static NSString *cellID = @"CartCell";
    CartCell *cell = (CartCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [cell setItem:data];
    return cell;
}

@end
