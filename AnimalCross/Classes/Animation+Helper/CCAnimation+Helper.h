//
//  CCAnimation+Helper.h
//  CCAnimationHelper
//
//  Created by 何松泽 on 14-10-15.
//  Copyright (c) 2014年 何松泽. All rights reserved.
//

#import "cocos2d.h"

@interface CCAnimation (Helper)

+ (CCAnimation *)animationWithpListFile:(NSString *)plistName
                     animationName:(NSString *)animationName
                       firstIndex:(int)nIndex
                        frameCount:(int)nFrameCount
                             delay:(float)fDelayTime;

//利用帧缓存中的帧名称
+ (CCAnimation *)animationWithFrame:(NSString *)frameName
                        firstIndex:(int)nIndex
                         frameCount:(int)nFrameCount
                              delay:(float)fDelayTime;


@end
