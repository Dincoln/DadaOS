//
//  AppDelegate.m
//  DataOS
//
//  Created by Dincoln on 2018/5/14.
//  Copyright © 2018年 Dincoln. All rights reserved.
//

#import "AppDelegate.h"
#import <MASShortcut/Shortcut.h>
#import "MenuItem.h"
@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *item;

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
                                   }
                               }];
    
    [[MASShortcutBinder sharedBinder] registerDefaultShortcuts:@{
                                                                 MMShortcutSettingLockScreen :
                                                                     [MASShortcut shortcutWithKeyCode:kVK_ANSI_L modifierFlags:(NSEventModifierFlagCommand)]
                                                                 }];
    
    self.index = 0;
    self.isShow = YES;
    self.item = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    self.item.title = @"";
    self.item.menu = self.menu;
    
    NSArray<NSString *> *arr = @[@"sh000001", @"sz000063", @"sz000961", @"sh600623", @"sh601228", @"sh600750"];
    NSArray<NSMenuItem *> *items = [self itemsWithArr:arr];
    self.item.menu.itemArray = items;
    self.index = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.isShow) {
            self.item.title = self.item.menu.itemArray[self.index%(self.item.menu.itemArray.count - 1)].title;
        }
        self.index ++;
    }];
    [timer fire];
}
- (IBAction)close:(NSMenuItem *)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (NSMutableArray<NSMenuItem *> *)itemsWithArr:(NSArray<NSString *> *)arr {
    
    NSMutableArray<NSMenuItem *> *items = [NSMutableArray array];
    for (NSString *str in arr) {
       [items addObject: [[MenuItem alloc] initWithItem:[[Item alloc] initWithName:@"" code:str]]];
    }
    [items addObject:[[NSMenuItem alloc] initWithTitle:@"退出" action:@selector(close:) keyEquivalent:@""]];
    return items;
}




@end
