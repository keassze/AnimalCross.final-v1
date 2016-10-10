//
//  Animal.h
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/5
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"


// -----------------------------------------------------------------

@interface Animal : CCSprite
{
    CCSpriteFrame *selfAnimateFrame;
    CCSpriteFrameCache *frameCache;
    CCAction *normalFrameAction;
    CCAction *dieFrameAction;
    CCAction *specialFrameAction;
    CCAction *upFrameAction;
    CCAction *downFrameAction;
    CCAction *leftFrameAction;
    CCAction *rightFrameAction;
    
}

// -----------------------------------------------------------------
// properties

@property (nonatomic, assign) BOOL isMove;//是否运动中
@property (nonatomic, assign) BOOL canPass;//能否通过

@property (nonatomic, strong) NSMutableArray *animateArr;
@property(readonly, copy, nonatomic) NSString *animatePlistFile;


@property (nonatomic,assign) PlayerDirection curFrameDirection;
@property (nonatomic,assign) Characters character;
@property(assign, nonatomic) int speed;

@property(readonly, copy, nonatomic) NSString *playerPlistFile;


// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
//- (id)initWithPlayerPlistFile:(NSString *)fileName;
//- (void)setAnimationPlistFile:(NSString *)fileName;
- (id)initWithCharactersName:(Characters)charactersName;
- (CCAction *)spriteWithRepeatAction:(NSString *)animationName firstIndex:(int)nIndex frameCount:(int)nCount delay:(float)fDelay;

- (void)runNormalFrameAction;
- (void)runDieFrameAction;
- (void)runSpecialFrameAction;
- (void)runUpFrameAction;
- (void)runDownFrameAction;
- (void)runLeftFrameAction;
- (void)runRightFrameAction;
- (void)runToBox:(CGPoint)boxPoint;

- (void)goForwardSpeed:(float)s
             distance:(float)d;
- (void)goBackSpeed:(float)s
          distance:(float)d;
- (void)goLeftSpeed:(float)s
          distance:(float)d;
- (void)goRightSpeed:(float)s
           distance:(float)d;
- (void)setAnimate:(NSString *)fileName
             image:(NSString *)imageName
        firstIndex:(NSString *)first
         lastIndex:(NSString *)last
         isRepeate:(BOOL)isRepeate
            isGame:(BOOL)isGame;

- (BOOL)isEasyCollision:(CCSprite *)other;
- (BOOL)is25DCollision:(CCSprite *)other;
// -----------------------------------------------------------------

@end




