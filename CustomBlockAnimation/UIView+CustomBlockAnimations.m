//
//  UIView+DR_CustomBlockAnimations.m
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import "UIView+CustomBlockAnimations.h"
#include <objc/objc.h>
#import <objc/runtime.h>
#import "SavedPopAnimationState.h"

static void *DR_currentAnimationContext = NULL;
static void *DR_popAnimationContext     = &DR_popAnimationContext;

static const char* kObjectPropertyKey = "kObjectPropertyKey";

@implementation UIView (CustomBlockAnimations)

+ (void)load {
    SEL originalSelector = @selector(actionForLayer:forKey:);
    SEL extendedSelector = @selector(DR_actionForLayer:forKey:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method extendedMethod = class_getInstanceMethod(self, extendedSelector);
    
    NSAssert(originalMethod, @"original method should exist");
    NSAssert(extendedMethod, @"exchanged method should exist");
    
    if(class_addMethod(self, originalSelector, method_getImplementation(extendedMethod), method_getTypeEncoding(extendedMethod))) {
        class_replaceMethod(self, extendedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, extendedMethod);
    }

}
+ (NSMutableArray *)stats {
    return objc_getAssociatedObject(self, kObjectPropertyKey);
}
+ (void)setStats:(NSMutableArray *)stats {
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:stats];
    objc_setAssociatedObject(self, kObjectPropertyKey, tmp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<CAAction>)DR_actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    if (DR_currentAnimationContext == DR_popAnimationContext) {
        
        NSMutableArray *stats = [NSMutableArray new];
        
        [stats addObject:[SavedPopAnimationState savedStateWithLayer:layer keyPath:event]];
        
        [UIView setStats:stats];
       
        return (id<CAAction>)[NSNull null];
    }
    return [self DR_actionForLayer:layer forKey:event];
}
+ (void)popAnimationWithDuration:(NSTimeInterval)duration animations:(void(^)(void))animations {
    DR_currentAnimationContext = DR_popAnimationContext;
    
    animations();
    [[UIView stats] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SavedPopAnimationState *saveState = (SavedPopAnimationState *)obj;
        CALayer *layer = saveState.layer;
        NSString *keyPath = saveState.keyPath;
        id oldValue = saveState.oldValue;
        id newValue = [layer valueForKeyPath:keyPath];
        
    
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keyPath];
        
        CGFloat easing = 0.2;
        CAMediaTimingFunction *easeIn  = [CAMediaTimingFunction functionWithControlPoints:1.0 :0.0 :(1.0-easing) :1.0];
        CAMediaTimingFunction *easeOut = [CAMediaTimingFunction functionWithControlPoints:easing :0.0 :0.0 :1.0];
        
        anim.duration = duration;
        anim.keyTimes = @[@0, @(0.35), @1];
        anim.values = @[oldValue, newValue, oldValue];
        anim.timingFunctions = @[easeIn, easeOut];
        
        [layer addAnimation:anim forKey:keyPath];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [layer setValue:oldValue forKey:keyPath];
        [CATransaction commit];
    }];
    [[self DR_savedPopAnimationStates] removeAllObjects];
    DR_currentAnimationContext = NULL;
}
+ (NSMutableArray *)DR_savedPopAnimationStates {
    return [NSMutableArray array];
}
@end
