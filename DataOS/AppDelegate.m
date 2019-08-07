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
    self.item = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    self.item.title = @"";
    self.item.menu = self.menu;
    
    MenuItem *menu1 = [[MenuItem alloc] initWithItem:[[Item alloc] initWithName:@"" code:@"sh000001"]];
    MenuItem *menu2 = [[MenuItem alloc] initWithItem:[[Item alloc] initWithName:@"" code:@"sh601318"]];
    MenuItem *menu3 = [[MenuItem alloc] initWithItem:[[Item alloc] initWithName:@"" code:@"sz000961"]];
    MenuItem *menu4 = [[MenuItem alloc] initWithItem:[[Item alloc] initWithName:@"" code:@"sh600623"]];
    NSMenuItem *menu5 = [[NSMenuItem alloc] initWithTitle:@"退出" action:@selector(close:) keyEquivalent:@""];

    self.item.menu.itemArray = @[menu1, menu2, menu3, menu4, menu5];
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




@end
