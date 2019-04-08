//
//  UIView+DR_CustomBlockAnimations.h
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CustomBlockAnimations)
+ (void)popAnimationWithDuration:(NSTimeInterval)duration animations:(void(^)(void))animations;
@property (nonatomic,strong,class) NSMutableArray *stats;
@end

NS_ASSUME_NONNULL_END
