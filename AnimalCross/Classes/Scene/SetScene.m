//
//  SetScene.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/28.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "SetScene.h"

@implementation SetScene

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
//        [[OALSimpleAudio sharedInstance] playBg:@"interFaceSceneBg.mp3" loop:YES];
        //写入之前的音量
        userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault valueForKey:Voice_Volume] == nil) {//如果第一次进入，直接选择全音量
            [userDefault setValue:@"1.0" forKey:Voice_Volume];
        }
        if ([userDefault valueForKey:Effect_Volume] == nil) {//如果第一次进入，直接选择全音效
            [userDefault setValue:@"1.0" forKey:Effect_Volume];
        }
        
        CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [spriteFrameCache addSpriteFramesWithFile:@"setSceneTexture.plist"];
        
        //背景图
        CCSprite *setBg = [[CCSprite alloc]initWithImageNamed:@"setBg.png"];
        setBg.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [self addChild:setBg z:-1];
        //音量图标
        CCSprite *voiceSign = [[CCSprite alloc]initWithImageNamed:@"voiceSign.png"];
        voiceSign.scale = 0.8f;
        voiceSign.position = ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2-50);
        [self addChild:voiceSign];
        CCSprite *musicSign = [[CCSprite alloc]initWithImageNamed:@"voiceSign.png"];
        musicSign.scale = 0.8f;
        musicSign.position = ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2+50);
        [self addChild:musicSign];
        //音效开关
        if ([[userDefault valueForKey:Effect_Volume] isEqualToString:@"1.0"]) {
            voiceSwitch = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"voiceOn.png"]];
            _isVoiceOn = YES;
        }else{
            voiceSwitch = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"voiceOff.png"]];
            _isVoiceOn = NO;
        }
        voiceSwitch.position = ccp(SCREEN_WIDTH*2/3 -50, SCREEN_HEIGHT/2-50);
        [voiceSwitch setTarget:self selector:@selector(turnEffect)];
        [self addChild:voiceSwitch];
        //音量条
        slider = [[CCSlider alloc]initWithBackground:[CCSpriteFrame frameWithImageNamed:@"voiceSlider1.0.png"] andHandleImage:[CCSpriteFrame frameWithImageNamed:@"voiceBtn.png"]];
        slider.position = ccp(SCREEN_WIDTH*2/3 -100, SCREEN_HEIGHT/2 + 45);
        slider.sliderValue = [[userDefault valueForKey:Voice_Volume] floatValue];
        [self addChild:slider];
        //返回键
        backBtn = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"]];
        backBtn.position = Left_Up_Btn;
        [backBtn setTarget:self selector:@selector(back_main)];
        [self addChild:backBtn];
        
        _isVoiceOn = YES;
        
        [self schedule:@selector(updateVoice:) interval:1/60.f];
    }
    return self;
}

-(void)back_main
{
    [userDefault setValue:[NSString stringWithFormat:@"%f",slider.sliderValue] forKey:Voice_Volume];
    
    [[CCDirector sharedDirector]popScene];
}

-(void)turnEffect
{
    if (_isVoiceOn) {
        [OALSimpleAudio sharedInstance].effectsVolume = 0;
        [voiceSwitch setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"voiceOff.png"] forState:CCControlStateNormal];
//        slider.sliderValue = 0;
        _isVoiceOn = NO;
    }else{
        [voiceSwitch setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"voiceOn.png"] forState:CCControlStateNormal];
        [OALSimpleAudio sharedInstance].effectsVolume = 1;
//        slider.sliderValue = 1;
        _isVoiceOn = YES;
    }
    [userDefault setValue:[NSString stringWithFormat:@"%f",[OALSimpleAudio sharedInstance].effectsVolume] forKey:Effect_Volume];
}

-(void)updateVoice:(CCTime)delta
{
    NSLog(@"%@,%@",[userDefault valueForKey:Effect_Volume],[userDefault valueForKey:Voice_Volume]);
    [OALSimpleAudio sharedInstance].bgVolume = slider.sliderValue;//根据slider的值判断声音大小
//    NSString *value;
//    if (slider.sliderValue<0.95) {
//        value = [NSString stringWithFormat:@"%0.1f",slider.sliderValue];
//    }else{
//        value = @"1.0";
//    }
//    
//    [slider setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"voiceSlider%@.png",value]] forState:CCControlStateNormal];
//    NSLog(@"%f",slider.sliderValue);
}

@end
