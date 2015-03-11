//
//  AppDelegate.h
//  PacteraTestApp
//
//  Created by AppsWiz on 11/03/2015.
//  Copyright (c) 2015 AppsWiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void(^)(NSData *data))completionHandler;


@end

