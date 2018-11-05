//
//  UIButton+testBtn.h
//  LearnNew
//
//  Created by jysd on 2018/10/22.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

struct ClickSize{
    CGFloat t; //上边
    CGFloat b; //下边
    CGFloat l; //左边
    CGFloat r; //右边
};

typedef struct ClickSize ClickSize;

CG_INLINE ClickSize
ClickSizeMake(CGFloat t, CGFloat b, CGFloat l, CGFloat r){
    ClickSize click;
    click.t = t;
    click.b = b;
    click.l = l;
    click.r = r;
    return click;
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (testBtn)

- (void)enlargeBtnClickAreaWith:(ClickSize)size;

- (void)setEnlargeEdge:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
