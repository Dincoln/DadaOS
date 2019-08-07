//
//  MenuItem.m
//  DataOS
//
//  Created by Dincoln on 2019/8/7.
//  Copyright © 2019 Dincoln. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem
- (instancetype)initWithItem:(Item *)item
{
    self = [super init];
    if (self) {
        self.item = item;
        __weak typeof(self) weakSelf = self;
        item.callBack = ^(NSString * _Nonnull value) {
            weakSelf.title = [NSString stringWithFormat:@"%@%@", self.item.name, self.item.value];
        };
        
    }
    return self;
}
@end
