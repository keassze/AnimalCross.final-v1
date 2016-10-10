//
//  InterfaceScene.m
//  AnimalCross
//
//  Created by 何松泽 on 16/2/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//
#define BUTTON_SIZE         24.0f
#define TITLE_SIZE          40.0f

#import "InterfaceScene.h"
#import "ChooseScene.h"
#import "AboutUsScene.h"
#import "MainGameScene.h"
#import "SetScene.h"
/**
 *  @author 小泽, 16-03-29 15:03:22
 *
 *  主界面
 */
@implementation InterfaceScene

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
        CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [spriteFrameCache addSpriteFramesWithFile:@"InterfaceSceneTexture.plist"];
        
        [[OALSimpleAudio sharedInstance]playBg:@"interFaceSceneBg.mp3" loop:YES];
        
        CCSprite9Slice *background = [CCSprite9Slice spriteWithImageNamed:@"Login_bg.png"];
        background.anchorPoint = CGPointZero;
        background.contentSize = [CCDirector sharedDirector].viewSize;
        CCLOG(@"%f,%f",[CCDirector sharedDirector].viewSize.width,[CCDirector sharedDirector].viewSize.height);
//        background.color = [CCColor grayColor];
        [self addChild:background];
        
        
        CCButton *setButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Set_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Set_pressed.png"] disabledSpriteFrame:nil];
        setButton.position = ccp(SCREEN_WIDTH/3-20, SCREEN_HEIGHT/5-20);
        [setButton setTarget:self selector:@selector(toSet)];
        [self addChild:setButton];
        
        CCButton *startButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Start_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Start_pressed.png"] disabledSpriteFrame:nil];
        startButton.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/5-20);
        [startButton setTarget:self selector:@selector(startGame)];
        [self addChild:startButton];
        
        CCButton *aboutButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"AboutUs_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"AboutUs_pressed.png"] disabledSpriteFrame:nil];
        aboutButton.position = ccp(SCREEN_WIDTH-SCREEN_WIDTH/3+20, SCREEN_HEIGHT/5-25);
//        aboutButton.scale = 1.1f;
        [aboutButton setTarget:self selector:@selector(aboutUs)];
        [self addChild:aboutButton];
        [self initTitle];
    }
    return self;
}

-(void)initTitle
{
    CCSprite9Slice *dong = [CCSprite9Slice spriteWithImageNamed:@"动.png"];
    dong.position = ccp(-50, SCREEN_HEIGHT*4/5);
    [self addChild:dong];
    
    CCSprite9Slice *wu = [CCSprite9Slice spriteWithImageNamed:@"物.png"];
    wu.position = ccp(-50, SCREEN_HEIGHT*4/5);
    //        background.color = [CCColor grayColor];
    [self addChild:wu];
    
    
    CCSprite9Slice *da = [CCSprite9Slice spriteWithImageNamed:@"大.png"];
    da.position = ccp(-50, SCREEN_HEIGHT*4/5);
    //        background.color = [CCColor grayColor];
    [self addChild:da];
    CCSprite9Slice *tao = [CCSprite9Slice spriteWithImageNamed:@"逃.png"];
    tao.position = ccp(-50, SCREEN_HEIGHT*4/5);
    //        background.color = [CCColor grayColor];
    [self addChild:tao];
    CCSprite9Slice *wang = [CCSprite9Slice spriteWithImageNamed:@"亡.png"];
    wang.position = ccp(SCREEN_WIDTH*3/4, SCREEN_HEIGHT+50);
    //        background.color = [CCColor grayColor];
    [self addChild:wang];
    
    //题目动画
    CCActionInterval *moveDong = [[CCActionMoveTo alloc]initWithDuration:0.3f position:ccp(SCREEN_WIDTH/4, SCREEN_HEIGHT*4/5)];
    CCActionCallBlock *blockWu = [[CCActionCallBlock alloc]initWithBlock:^{
        CCActionInterval *moveWu = [[CCActionMoveTo alloc]initWithDuration:0.5f position:ccp(SCREEN_WIDTH/4+70, SCREEN_HEIGHT*4/5)];
        [wu runAction:moveWu];
    }];
    CCActionCallBlock *blockDa = [[CCActionCallBlock alloc]initWithBlock:^{
        CCActionInterval *moveDa = [[CCActionMoveTo alloc]initWithDuration:0.5f position:ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT*4/5)];
        [da runAction:moveDa];
    }];
    CCActionCallBlock *blockTao = [[CCActionCallBlock alloc]initWithBlock:^{
        CCActionInterval *moveTao = [[CCActionMoveTo alloc]initWithDuration:0.5f position:ccp(SCREEN_WIDTH/2+80, SCREEN_HEIGHT*4/5)];
        [tao runAction:moveTao];
    }];
    CCActionCallBlock *blockWang = [[CCActionCallBlock alloc]initWithBlock:^{
        CCActionInterval *moveWang1 = [[CCActionMoveTo alloc]initWithDuration:0.3f position:ccp(SCREEN_WIDTH*3/4, SCREEN_HEIGHT*4/5+30)];
        CCActionInterval *moveWang2 = [[CCActionMoveTo alloc]initWithDuration:0.5f position:ccp(SCREEN_WIDTH*3/4, SCREEN_HEIGHT*4/5+70)];
        CCActionSequence *wangSeq1 = [[CCActionSequence alloc]initOne:moveWang1 two:moveWang2];
        CCActionSequence *wangSeq2 = [[CCActionSequence alloc]initOne:wangSeq1 two:moveWang1];
        
        CCActionEaseBounceIn *bounce = [[CCActionEaseBounceIn alloc]initWithAction:wangSeq2];
        [wang runAction:bounce];
    }];

    NSMutableArray *animateArr = [[NSMutableArray alloc]initWithObjects:moveDong,blockWu,moveDong,blockDa,moveDong,blockTao,moveDong,blockWang, nil];
    CCActionInterval *seq = [[CCActionSequence alloc]initWithArray:animateArr];
    [dong runAction:seq];
    
}

- (void)startGame
{
//    [[CCDirector sharedDirector] pushScene:[MainGameScene new]];
    [[CCDirector sharedDirector]replaceScene:[ChooseScene new] withTransition:
     [CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:0.5f]];
//         [CCTransition transitionCrossFadeWithDuration:0.3f]];
}

-(void)aboutUs
{
//    [[CCDirector sharedDirector]replaceScene:[AboutUsScene new] withTransition:[CCTransition transitionCrossFadeWithDuration:0.3f]];
//    [OALSimpleAudio sharedInstance].bgVolume = 0.5f;
    [[CCDirector sharedDirector] pushScene:[AboutUsScene new]];
}

-(void)toSet
{
    [[CCDirector sharedDirector] pushScene:[SetScene new]];
}

@end
