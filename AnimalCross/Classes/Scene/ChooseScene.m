//
//  ChooseScene.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/19.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "ChooseScene.h"
#import "MainGameScene.h"

@implementation ChooseScene

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {

        
        // Background
        CCSprite *background = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"aboutScene_background.png"]];
        background.position =  ccp(SCREEN_WIDTH * 0.5 ,SCREEN_HEIGHT * 0.5);
        [self addChild:background z:-10];

        
        CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [spriteFrameCache addSpriteFramesWithFile:@"ChooseButton.plist"];
        //向左选择
        leftButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageL.normal.0.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageL.pressed.0.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CSBargainSale.BtLeft.disabled.0.png"]];
        leftButton.position = ccp(SCREEN_WIDTH/5, SCREEN_HEIGHT/2);
        [leftButton setTarget:self selector:@selector(pushLeft:)];
        [self addChild:leftButton];
        //向右选择
        rightButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageR.normal.0.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageR.pressed.0.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CSBargainSale.BtRight.disabled.0.png"]];
        rightButton.position = ccp(SCREEN_WIDTH*4/5, SCREEN_HEIGHT/2);
        [rightButton setTarget:self selector:@selector(pushRight:)];
        [self addChild:rightButton];
        //确定
        sureButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageR.normal.0.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CharSelect.pageR.pressed.0.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CSBargainSale.BtRight.disabled.0.png"]];
        sureButton.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/5);
        [sureButton setTarget:self selector:@selector(sureChoose)];
        [self addChild:sureButton z:2];
        //返回主界面
        CCButton *backButton = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_normal.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_pressed.png"]];
        backButton.position = Left_Up_Btn;
        [backButton setTarget:self selector:@selector(back_main)];
        [self addChild:backButton];
        
        animalLayout = [[CCLayout alloc]init];
        animalLayout.position = ccp(0, 0);
        [self addChild:animalLayout];
        
        animal = [[Animal alloc]initWithCharactersName:MONKEY];
        animal.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [animalLayout addChild:animal];
        
    }
    return self;
}

-(void)pushLeft:(CCButton *)sender
{
    [rightButton setVisible:YES];
    [rightButton setUserInteractionEnabled:YES];
    [animal runAction:[CCActionSequence actions:[CCActionMoveBy actionWithDuration:0.3f position:ccp(SCREEN_WIDTH,0)],[CCActionCallBlock actionWithBlock:^{
        //        [animal runAction:[CCActionHide action]];
        //            sender.userInteractionEnabled = false;
        [animal removeFromParent];
        animal = [[Animal alloc]initWithCharactersName:animal.character-1];
        animal.position = ccp(-SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [animal setScale:0.8f];
        [self addChild:animal];
        [animal runAction:[CCActionMoveBy actionWithDuration:0.3f position:ccp(SCREEN_WIDTH,0)]];
    }],nil]];
    if (animal.character == MONKEY){
        [sender setVisible:NO];
        [sender setUserInteractionEnabled:NO];
    }
    
}

-(void)pushRight:(CCButton *)sender
{
    [leftButton setVisible:YES];
    [leftButton setUserInteractionEnabled:YES];
    [animal runAction:[CCActionSequence actions:[CCActionMoveBy actionWithDuration:0.3f position:ccp(- SCREEN_WIDTH,0)],[CCActionCallBlock actionWithBlock:^{
        [animal removeFromParent];
        animal = [[Animal alloc]initWithCharactersName:animal.character+1];
        animal.position = ccp(SCREEN_WIDTH*3/2, SCREEN_HEIGHT/2);
        [animal setScale:0.8f];
        [self addChild:animal];
        [animal runAction:[CCActionMoveBy actionWithDuration:0.3f position:ccp(- SCREEN_WIDTH,0)]];
    }],nil]];
    if (animal.character == MONKEY){
        [sender setVisible:NO];
        [sender setUserInteractionEnabled:NO];
    }
}

-(void)sureChoose
{
    //写入玩家选择的动物
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:[NSString stringWithFormat:@"%d",animal.character] forKey:Choose_Animal];
    NSLog(@"%@,%d",[userDefault stringForKey:Choose_Animal],animal.character);
    [[CCDirector sharedDirector]replaceScene:[MainGameScene new] withTransition:[CCTransition transitionCrossFadeWithDuration:0.3f]];
    
}

-(void)back_main
{
    [[CCDirector sharedDirector]replaceScene:[InterfaceScene new] withTransition:
     [CCTransition transitionCrossFadeWithDuration:0.3f]];
}

@end
