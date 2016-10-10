//
//  SpecialGameScene.h
//  AnimalCross
//
//  Created by 何松泽 on 16/2/24.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "KRVideoPlayerController.h"
#import "CCScene.h"

@interface SpecialGameScene : CCScene
{
    CCSprite9Slice *background;
    float time;
}

@property (nonatomic, strong) KRVideoPlayerController *videoController;
@property (nonatomic, strong) CCButton *skipBtn;

+ (instancetype)node;
- (instancetype)init;
//- (void)updateMap:(CCTime)delta;
-(void)updateGame:(CCTime)delta;

@end
