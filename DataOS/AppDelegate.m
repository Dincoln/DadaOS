//
//  AppDelegate.m
//  DataOS
//
//  Created by Dincoln on 2018/5/14.
//  Copyright © 2018年 Dincoln. All rights reserved.
//

#import "AppDelegate.h"
#import <MASShortcut/Shortcut.h>
@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *item;

@property (nonatomic, strong) NSMenuItem *menuItem;

@property (nonatomic, strong) NSMutableArray<NSMenuItem *> *menuItemArr;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isShow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSString *const MMShortcutSettingLockScreen = @"lockScreenShortcut";
    self.isShow = YES;
    MASShortcutBinder *binder = [MASShortcutBinder sharedBinder];
    [[MASShortcutBinder sharedBinder] setBindingOptions:@{NSValueTransformerNameBindingOption : MASDictionaryTransformerName}];
    __weak typeof(self) weakSelf = self;
    [binder bindShortcutWithDefaultsKey:MMShortcutSettingLockScreen
                               toAction:^{
                                   weakSelf.isShow = !weakSelf.isShow;
                                   if (!weakSelf.isShow) {
                                       self.item.title = @"";
                                       self.menuItem.title = @"";
                                   }
                               }];
    
    [[MASShortcutBinder sharedBinder] registerDefaultShortcuts:@{
                                                                 MMShortcutSettingLockScreen :
                                                                     [MASShortcut shortcutWithKeyCode:kVK_ANSI_L modifierFlags:(NSEventModifierFlagCommand)]
                                                                 }];
    
    self.index = 0;
    self.item = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    self.item.title = @"";
    self.item.menu = self.menu;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self action];
    }];
    [timer fire];
}
- (IBAction)close:(NSMenuItem *)sender {
    [[NSApplication sharedApplication] terminate:self];
}


- (void)action {
    
    NSArray<NSString *> *array = @[@"sh000001", @"sh601318", @"sz000961", @"sh600623"];
    NSString *code;
    if (self.index % 4 == 0) {
        code = array[0];
    }else if(self.index % 4 == 1){
        code = array[1];
    }else if (self.index % 4 == 2){
        code = array[2];
    }else if (self.index % 4 == 3){
        code = array[3];
    }
    NSError *err;
    NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://hq.sinajs.cn/list=%@",code]] encoding:0x80000632 error:&err];
    NSArray<NSString *> *arr = [str componentsSeparatedByString:@","];
    if (arr.count>3) {
        NSString *str = @"";
        if ((arr[3].doubleValue - arr[2].doubleValue) >0) {
            str = @"a";
        }else{
            str = @"b";
        }
        if (self.isShow) {
            self.item.title = [[NSString stringWithFormat:@"%0.2lf %@%0.2lf %@%0.2lf",arr[3].doubleValue, str, fabs(arr[3].doubleValue - arr[2].doubleValue), str, fabs((arr[3].doubleValue - arr[2].doubleValue)/arr[2].doubleValue *100.f)] stringByReplacingOccurrencesOfString:@"." withString:@"c"];
            if (self.index%4 == 0) {
                self.menuItem.title = self.item.title;
            }
        }else{
            self.item.title = @"";
            if (self.index%4 == 0) {
                self.menuItem.title = @"";
            }
        }
    }
    self.index ++;
}






- (NSMenuItem *)menuItem{
    if (!_menuItem) {
        _menuItem = [[NSMenuItem alloc] init];
        [self.item.menu insertItem:_menuItem atIndex:0];
    }
    return _menuItem;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
