//
//  AppDelegate.m
//  GridTurnToListDemo
//
//  Created by 刘星星 on 16/10/20.
//  Copyright © 2016年 刘星星. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[CustomViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
