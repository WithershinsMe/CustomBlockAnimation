//
//  DRSavedPopAnimationState.h
//  Anim
//
//  Created by GK on 2019/4/8.
//  Copyright © 2019 com.gk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SavedPopAnimationState : NSObject
@property (strong) CALayer *layer;
@property (nonnull,copy) NSString *keyPath;
@property (nonnull,strong) id oldValue;

+ (instancetype)savedStateWithLayer:(CALayer *)layer keyPath:(NSString *)keyPath;
@end

NS_ASSUME_NONNULL_END
