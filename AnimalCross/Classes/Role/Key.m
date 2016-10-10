//
//  Key.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/7.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Key.h"

@implementation Key

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)initWith3D:(BOOL)is3D KeyType:(KeyType)keyType
{
    if (self = [super init]) {
        switch (keyType) {
            case FISH:
            {
                if (is3D) {
                    [self setAnimate:@"fish3D" image:@"鱼动画/" firstIndex:@"0000" lastIndex:@"0019" is3D:is3D];
                }else{
                    [self setAnimate:@"fish2D" image:@"鱼动作/" firstIndex:@"0000" lastIndex:@"0019" is3D:is3D];
                }
            }
                break;
            case BANANA:
                
                break;
            case CABBAGE:
                
                break;
            default:
                break;
        }
        
        
    }
    return self;
}

-(void)setAnimate:(NSString *)fileName
            image:(NSString *)imageName
       firstIndex:(NSString *)first
        lastIndex:(NSString *)last
             is3D:(BOOL)is3D
{
    _animatePlistFile = fileName;
    
    _frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [_frameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",_animatePlistFile] textureFilename:[NSString stringWithFormat:@"%@.png",_animatePlistFile]];
    
    _animateArr = [[NSMutableArray alloc]init];
    
    for (int i = [first intValue]; i < [last intValue]; i++) {
        if (i < 10) {
            _selfAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@000%d",imageName, i]];
        }else if(i >= 10 && i < 100){
            _selfAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@00%d",imageName, i]];
        }else if (i >= 100 && i<1000){
            _selfAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@0%d",imageName, i]];
        }else if (i >= 1000){
            _selfAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@%d",imageName, i]];
        }else{
            NSLog(@"图片名字请重新设置");
        }
        [_animateArr addObject:_selfAnimateFrame];
    }
    if (is3D) {
        
    }else{
        self.scale = 1.5f;
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:_animateArr delay:0.1];
    CCAction *act = [CCActionAnimate actionWithAnimation:animation];
    CCActionRepeatForever *repeatForever = [CCActionRepeatForever actionWithAction:act];
    [self runAction:repeatForever];
}

@end
