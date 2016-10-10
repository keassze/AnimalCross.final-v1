//
//  CCAnimation+Helper.m
//  CCAnimationHelper
//
//  Created by 何松泽 on 14-10-15.
//  Copyright (c) 2014年 何松泽. All rights reserved.
//

#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)

+ (CCAnimation *)animationWithFrame:(NSString *)frameName
                         firstIndex:(int)nIndex
                         frameCount:(int)nFrameCount
                              delay:(float)fDelayTime
{
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:nFrameCount];
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSString *file;
    
    for (int i = nIndex; i < nFrameCount + nIndex; i++) {
        file = nil;
        file = [NSString stringWithFormat:@"%@%i.png",frameName,i];
        CCSpriteFrame *frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:fDelayTime];
}

+ (CCAnimation *)animationWithpListFile:(NSString *)plistName
                          animationName:(NSString *)animationName
                             firstIndex:(int)nIndex
                             frameCount:(int)nFrameCount
                                  delay:(float)fDelayTime
{
    CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:plistName];
    return [self animationWithFrame:animationName firstIndex:nIndex frameCount:nFrameCount delay:fDelayTime];
}




@end
