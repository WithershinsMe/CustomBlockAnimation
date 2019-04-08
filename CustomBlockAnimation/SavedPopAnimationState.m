//
//  DRSavedPopAnimationState.m
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import "SavedPopAnimationState.h"

@implementation SavedPopAnimationState

+ (instancetype)savedStateWithLayer:(CALayer *)layer keyPath:(NSString *)keyPath {
    SavedPopAnimationState *saveState = [SavedPopAnimationState new];
    saveState.layer = layer;
    saveState.keyPath = keyPath;
    saveState.oldValue = [layer valueForKeyPath:keyPath];
    return saveState;
}
@end
