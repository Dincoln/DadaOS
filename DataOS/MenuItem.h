//
//  MenuItem.h
//  DataOS
//
//  Created by Dincoln on 2019/8/7.
//  Copyright © 2019 Dincoln. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Item.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuItem : NSMenuItem
@property (nonatomic, strong) Item *item;
- (instancetype)initWithItem:(Item *)item;

@end

NS_ASSUME_NONNULL_END
