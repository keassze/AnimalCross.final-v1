//
//  SetScene.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/28.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCScene.h"

@interface SetScene : CCScene
{
    CCSlider *slider;
    CCButton *voiceSwitch;
    CCButton *backBtn;
    
    NSUserDefaults *userDefault;
}

@property(assign, nonatomic)BOOL isVoiceOn;

+ (instancetype)node;
- (instancetype)init;

@end
