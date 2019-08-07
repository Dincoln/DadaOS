//
//  Item.h
//  DataOS
//
//  Created by Dincoln on 2019/8/7.
//  Copyright © 2019 Dincoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) void (^callBack)(NSString *value);

- (instancetype)initWithName:(NSString *)name code:(NSString *)code;


@end

NS_ASSUME_NONNULL_END
