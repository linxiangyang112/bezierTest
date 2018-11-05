//
//  NSArray+CrashCL.m
//  LearnNew
//
//  Created by jysd on 2018/10/22.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "NSArray+CrashCL.h"
#import <objc/runtime.h>

@implementation NSArray (CrashCL)

+ (void)load{
    //此方法交换在数组内容是空或者1的时候失效
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sysMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method myMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xy_objectAtIndex:));
        method_exchangeImplementations(sysMethod, myMethod);
        
        Method sysMethod1 = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:));
        Method myMethod1 = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(xy_objectAtIndex0:));
        method_exchangeImplementations(sysMethod1, myMethod1);
        
        Method sysMethod2 = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:));
        Method myMethod2 = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(xy_objectAtIndex2:));
        method_exchangeImplementations(sysMethod2, myMethod2);
        
    });
}

- (id)xy_objectAtIndex2:(NSInteger)index{
    if (self.count - 1 < index) {
        @try {
            return [self xy_objectAtIndex2:index];
        } @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self xy_objectAtIndex2:index];
    }
}

- (id)xy_objectAtIndex0:(NSInteger)index{
    if (self.count - 1 < index) {
        @try {
            return [self xy_objectAtIndex0:index];
        } @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self xy_objectAtIndex0:index];
    }
}

- (id)xy_objectAtIndex:(NSInteger)index{
    if (self.count - 1 < index) {
        @try {
            return [self xy_objectAtIndex:index];
        } @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    }
    else{
        return [self xy_objectAtIndex:index];
    }
}

@end
