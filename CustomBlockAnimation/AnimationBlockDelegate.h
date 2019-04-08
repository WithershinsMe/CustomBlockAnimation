//
//  DRAnimationBlockDelegate.h
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationBlockDelegate : NSObject
@property (copy) void(^start)(void);
@property (copy) void(^stop)(BOOL);
+ (instancetype)animationDelegateWithBeginning:(void(^)(void))beginning
                                    completion:(void(^)(BOOL finished))completion;
@end

