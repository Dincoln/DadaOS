//
//  Item.m
//  DataOS
//
//  Created by Dincoln on 2019/8/7.
//  Copyright © 2019 Dincoln. All rights reserved.
//

#import "Item.h"

@implementation Item

- (void)dealloc{
    
}
- (instancetype)initWithName:(NSString *)name code:(NSString *)code
{
    self = [super init];
    if (self) {
        self.name = name;
        self.code = code;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(getValue) userInfo:nil repeats:YES];
        [self.timer fire];
        [NSRunLoop.currentRunLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

- (void)getValue {
    if (!self.code) {
        return;
    }
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.dataos", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(queue, ^{
        NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://hq.sinajs.cn/list=%@",self.code]] encoding:0x80000632 error:nil];
        NSArray<NSString *> *arr = [str componentsSeparatedByString:@","];
        if (arr.count>3) {
            NSString *str = @"";
            if ((arr[3].doubleValue - arr[2].doubleValue) < 0) {
                str = @"-";
            }
            
            self.value = [NSString stringWithFormat:@"%0.2lf %@%0.2lf %@%0.2lf",arr[3].doubleValue, str, fabs(arr[3].doubleValue - arr[2].doubleValue), str, fabs((arr[3].doubleValue - arr[2].doubleValue)/arr[2].doubleValue *100.f)];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.callBack) {
                    self.callBack(self.value);
                }
            });
        }
    });
}


@end
