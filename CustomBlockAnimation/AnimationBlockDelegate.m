//
//  DRAnimationBlockDelegate.m
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import "AnimationBlockDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationBlockDelegate

+ (instancetype)animationDelegateWithBeginning:(void (^)(void))beginning completion:(void (^)(BOOL))completion {
    AnimationBlockDelegate *result = [AnimationBlockDelegate new];
    result.start = beginning;
    result.stop = completion;
    return result;
}
- (void)animationDidStart:(CAAnimation *)anim {
    if (self.start) {
        self.start();
    }
    self.start = nil;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.stop) {
        self.stop(flag);
    }
    self.stop = nil;
}
@end
