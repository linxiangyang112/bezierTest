//
//  UIButton+testBtn.m
//  LearnNew
//
//  Created by jysd on 2018/10/22.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "UIButton+testBtn.h"
 #import <objc/runtime.h>

static char tNameKey;
static char bNameKey;
static char lNameKey;
static char rNameKey;

@implementation UIButton (testBtn)

//这个方法设置 上下左右扩大范围一致
- (void)enlargeBtnClickAreaWith:(ClickSize)size{
    objc_setAssociatedObject(self, &tNameKey, [NSNumber numberWithFloat:size.t], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bNameKey, [NSNumber numberWithFloat:size.b], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &lNameKey, [NSNumber numberWithFloat:size.l], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rNameKey, [NSNumber numberWithFloat:size.r], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//这个方法可随意设置 上下左右扩大的点击范围
- (void)setEnlargeEdge:(CGFloat)size{
    objc_setAssociatedObject(self, &tNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &lNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//如果 上下左右 这些值存在 就改变btn 的bounds 如果不存在就不改变
- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &tNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &lNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

@end
