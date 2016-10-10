//
//  AboutUsScene.m
//  糖果大作战-TileMap
//
//  Created by 何松泽 on 15/11/9.
//  Copyright © 2015年 suliwei. All rights reserved.
//

#import "AboutUsScene.h"
#import "InterfaceScene.h"

#define US_STRING @"程序：何松泽\n\n美工：罗张美、董珊\n\n策划：何松泽"
#define GAME_STRING @"游戏介绍：\n游戏通过触碰屏幕来控制角色移动，左划左移，右划右移，单击或者上划前行，下划后退。玩家需要通过移动操作躲避障碍物、行走的汽车的同时收集能拯救笼子里动物的钥匙碎片。在笼子前方有个下水井盖，可以通过它来进入特殊关卡，在特殊关卡中能获得前面游戏中收集不够的钥匙碎片，假如在特殊关卡失败就会马上从特殊关卡中退出回到原本的关卡。被拯救了的动物可以选择使用。"
/**
 *  @author 小泽, 16-03-29 15:03:20
 *
 *  关于界面
 */
@implementation AboutUsScene

- (void)onEnter{
    [super onEnter];
}

+(instancetype)node
{
    return [[self alloc]init];
}

-(instancetype)init
{
    if (self = [super init]) {
//        [[OALSimpleAudio sharedInstance] playBg:@"aboutScene.mp3" loop:YES];
        
//        CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
//        [spriteFrameCache addSpriteFramesWithFile:@"AboutSceneTexture.plist"];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"aboutScene_background.png"]];
        background.position =  ccp(SCREEN_WIDTH * 0.5 ,SCREEN_HEIGHT * 0.5);
        [self addChild:background z:-10];
        
        CCSprite *panel = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"aboutScene_panel.png"]];
        panel.scale = 0.7f;
        panel.position = ccp(SCREEN_WIDTH / 2, SCREEN_HEIGHT * 0.35);
        [self addChild:panel];
        
        usButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"aboutScene_us_normal.png"]];
        usButton.scale = 0.5f;
//        [usButton runAction:[[CCActionFlipX alloc]initWithFlipX:YES]];
        usButton.position = ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT*0.90);
//        usButton.position = ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT*0.75);
        [usButton setTarget:self selector:@selector(aboutUs)];
        [self addChild:usButton];
        
        gameButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"aboutScene_us_normal.png"]];
        gameButton.scale = 0.5f;
        gameButton.position = ccp(SCREEN_WIDTH/2 + 20, SCREEN_HEIGHT*0.90);
        [gameButton setTarget:self selector:@selector(aboutGame)];
        [self addChild:gameButton];
        
        CCButton *backButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"]];
        backButton.position = Left_Up_Btn;
        [backButton setTarget:self selector:@selector(back_main)];
        [self addChild:backButton];
        
        aboutLabel = [[CCLabelTTF alloc]initWithString:@"" fontName:@"consolas" fontSize:18.0f];
        [aboutLabel setDimensions:CGSizeMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
        aboutLabel.position = ccp(SCREEN_WIDTH/2+40, SCREEN_HEIGHT * 0.25);
        [self addChild:aboutLabel];
        
        canUs = YES;
        canGame = YES;
    }
    return self;
}

-(void)aboutUs
{
//    CCActionFlipX *flipX = [CCActionFlipX actionWithFlipX:YES];
//    [(CCNode *)sender runAction:flipX];
    if (canUs) {
        if (canGame) {
            
        }else{
            CCActionInterval *moveGame = [[CCActionMoveTo alloc]initWithDuration:0.2f position:ccp(SCREEN_WIDTH/2 + 20, SCREEN_HEIGHT*0.9)];
            CCActionInterval *rotateGame = [[CCActionRotateBy alloc]initWithDuration:0.1f angle:30];
            CCActionSequence *seqGame = [[CCActionSequence alloc]initOne:moveGame two:rotateGame];
            [gameButton runAction:seqGame];
        }
        CCActionInterval *moveUs = [[CCActionMoveTo alloc]initWithDuration:0.2f position:ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT*0.75)];
        CCActionInterval *rotateUs = [[CCActionRotateBy alloc]initWithDuration:0.1f angle:-30];
        CCActionSequence *seqUs = [[CCActionSequence alloc]initOne:moveUs two:rotateUs];
        [usButton runAction:seqUs];
        
        aboutLabel.string = US_STRING;
        aboutLabel.fontSize = 18.0f;
        
        canUs = NO;
        canGame = YES;
    }
    
}

-(void)aboutGame
{
    if (canGame) {
        if (canUs) {
            
        }else{
            CCActionInterval *moveUs = [[CCActionMoveTo alloc]initWithDuration:0.2f position:ccp(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT*0.90)];
            CCActionInterval *rotateUs = [[CCActionRotateBy alloc]initWithDuration:0.1f angle:30];
            CCActionSequence *seqUs = [[CCActionSequence alloc]initOne:moveUs two:rotateUs];
            [usButton runAction:seqUs];
        }
        CCActionInterval *moveGame = [[CCActionMoveTo alloc]initWithDuration:0.2f position:ccp(SCREEN_WIDTH/2 + 20, SCREEN_HEIGHT*0.85)];
        CCActionInterval *rotateGame = [[CCActionRotateBy alloc]initWithDuration:0.1f angle:-30];
        CCActionSequence *seqGame = [[CCActionSequence alloc]initOne:moveGame two:rotateGame];
        [gameButton runAction:seqGame];
        
        aboutLabel.string = GAME_STRING;
        aboutLabel.fontSize = 15.0f;
        
        canGame = NO;
        canUs = YES;
    }
    
}

-(void)back_main
{
//    [[OALSimpleAudio sharedInstance] stopBg];
//    [[CCDirector sharedDirector] presentScene:[InterfaceScene new] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
//    [[OALSimpleAudio sharedInstance] stopBg];
    [[CCDirector sharedDirector]popScene];
//    [[CCDirector sharedDirector] replaceScene:[InterfaceScene new] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
//    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:0.3f]];
//    [[CCDirector sharedDirector]popScene];
}

@end
