//
//  ShoppingCartInfo.h
//  ShoppingCart
//
//  Created by bingjie-macbookpro on 15/11/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartInfo : NSObject

@property (nonatomic, strong) NSString          *storeName;
@property (nonatomic, assign) NSInteger         store_id;

@property (nonatomic, copy  ) NSArray           *goods;

@property (nonatomic, assign) BOOL        select;

@end


@interface GoodsInfo : NSObject

@property (nonatomic, strong) NSString          *goodsName;
@property (nonatomic, assign) NSInteger         goods_id;
@property (nonatomic, strong) NSString          *goodsDescription;

@property (nonatomic, assign) NSInteger        quantity;
@property (nonatomic, assign) CGFloat          price;


@property (nonatomic, assign) BOOL        select;


@end
