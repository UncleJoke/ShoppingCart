//
//  ViewController.m
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "ViewController.h"
#import "CartCell.h"
#import "ShoppingCartInfo.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong ,nonatomic) UITableView     *tableView;
@property (copy ,nonatomic) NSArray           *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadFakeFata];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (NSString*)randomGoods
{
    NSArray *goodsName = @[@"苹果干",@"橘子干",@"鸡蛋",@"鸭蛋",@"火龙果",@"蛇皮果"];
    NSInteger index = (arc4random() % goodsName.count) ;
    return goodsName[index];
}
- (NSString*)randomDes
{
    NSArray *storeName = @[@"一日去同学家玩，进门要换鞋，我说不用了我脚臭穿鞋套就行了。 他爸爸就说：“脚越臭表示身体越好，就换拖鞋吧。” 我只好脱了鞋进了同学的房间一起玩电脑",@"同学的爸爸有事问他就进来了，问完之后关门走了。 三秒后又开门对我说：“你身体不是一般的好啊！”我在那凌乱……",@"一种新的街头涂鸦方式，艺术家用苔藓、酸奶、啤酒和白糖制成一种培养液，然后用画笔在墙上涂鸦，再加上适当的喷水，不久就长出绿色的软软的“涂鸦”！",@"段对白出自动画电影《秒速五厘米》，这部电影总共由三个连续短篇组成，片长63分钟。三个短篇分别是《樱花抄》，《宇航员》，《秒速五厘米》。",@"青梅竹马的美好时光自然无法永远持续，两人想要继续在一起的约定在生活的变迁面前显",@"一年后的相会，让少年费尽心机的去筹划，兜兜转转地搭乘自己从未乘坐的线路，花了几个星期写的，想要"];
    NSInteger index = (arc4random() % storeName.count);
    return storeName[index];
}

- (NSString*)randomStore
{
    NSArray *goodsName = @[@"一号店",@"亚马逊",@"华华手机",@"星星水果店",@"一级代理商",@"黑店"];
    NSInteger index = (arc4random() % goodsName.count);
    return goodsName[index];
}

- (void)loadFakeFata
{
    
    NSInteger storeCount = (arc4random() % 6) + 1;
    NSInteger goodsCount = (arc4random() % 4) + 1;

    
    NSMutableArray *storeInfoes = @[].mutableCopy;
    for (NSInteger i = 0; i < storeCount; i++) {
        ShoppingCartInfo *store = [[ShoppingCartInfo alloc]init];
        store.storeName = [self randomStore];
        store.store_id = (arc4random() % 99999);
        
        NSMutableArray *goods = @[].mutableCopy;
        for (NSInteger j = 0; j < goodsCount; j++) {
            GoodsInfo *good = [[GoodsInfo alloc]init];
            good.goodsName = [self randomGoods];
            good.goodsDescription = [self randomDes];
            good.goods_id = (arc4random() % 99999);
            [goods addObject:good];
        }
        store.goods = goods;
        [storeInfoes addObject:store];
    }
    
    self.dataSource = storeInfoes;
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CartCell cellHeight:self.dataSource[indexPath.row]];
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CartCell *cell = [CartCell tableView:tableView data:self.dataSource[indexPath.row]];
    cell.itemSelectBlock = ^(BOOL select,id item){
        [self updateData];
    };
    return cell;
}


- (void)updateData
{
    BOOL allSelect = YES;
    for (ShoppingCartInfo *temp in self.dataSource) {
        if (!temp.select) {
            allSelect = NO;
            break;
        }
    }
    NSLog(@"所有商品 %@",allSelect?@"全选了":@"未全选");
}



@end
