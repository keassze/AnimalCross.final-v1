//
//  Animal.m
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/5
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Animal.h"
#import "CCAnimation+Helper.h"
#import "Monkey.h"

// -----------------------------------------------------------------

@implementation Animal

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        normalFrameAction = nil;
        dieFrameAction = nil;
        specialFrameAction = nil;
        upFrameAction = nil;
        downFrameAction = nil;
        leftFrameAction = nil;
        rightFrameAction = nil;
        
        _isMove = false;
        _canPass = true;
        
    }
    
    return self;
}

//- (id)initWithPlayerPlistFile:(NSString *)fileName
//{
//    if (self = [self init]) {
//        NSString *plistName = [NSString stringWithFormat:@"%@.plist",fileName];
//        _playerPlistFile = plistName;
//    }
//    return self;
//}

//- (void)setAnimationPlistFile:(NSString *)fileName
//{
//    _playerPlistFile = fileName;
//}

- (id)initWithCharactersName:(Characters)charactersName{
//    NSString *plistFileName = [NSString stringWithFormat:@"tt"];
    if (self = [self init]) {
        switch (charactersName) {
            case TORTOISE:
                self.character = TORTOISE;
                [self setAnimate:@"tortoiseDown" image:@"后走龟/" firstIndex:@"0000" lastIndex:@"0012" isRepeate:YES isGame:NO];
                break;
            case MONKEY:
                self.character = MONKEY;
                [self setAnimate:@"monkeyDown" image:@"后/" firstIndex:@"0000" lastIndex:@"0024" isRepeate:YES isGame:NO];
                break;
            case LIZARD:
                self.character = LIZARD;
                [self setAnimate:@"lizardDown" image:@"蜥蜴后走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:NO];
                break;
            default:
                break;
        }
    }
    return self;
}


#pragma mark ActionMethod

- (CCAction *)spriteWithRepeatAction:(NSString *)animationName firstIndex:(int)nIndex frameCount:(int)nCount delay:(float)fDelay
{
    return [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:[CCAnimation animationWithpListFile:_playerPlistFile animationName:animationName firstIndex:nIndex frameCount:nCount delay:fDelay]]];
}

-(void)runNormalFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Normal;
    [self runAction:normalFrameAction];
}

- (void)runUpFrameAction{
    switch (self.character) {
        case TORTOISE:
        {
            [self stopAllActions];
            self.curFrameDirection = Up;
            [self setAnimate:@"tortoiseUp" image:@"前走龟/" firstIndex:@"0000" lastIndex:@"0039" isRepeate:YES isGame:YES];
        }
            break;
        case MONKEY:
        {
            [self stopAllActions];
            self.curFrameDirection = Up;
            [self setAnimate:@"monkeyUp" image:@"前/" firstIndex:@"0000" lastIndex:@"0024" isRepeate:YES isGame:YES];
        }
            break;
        case LIZARD:
        {
            [self stopAllActions];
            self.curFrameDirection = Up;
            [self setAnimate:@"lizardUp" image:@"蜥蜴前走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
        }
            break;
        default:
            break;
    }
    
}

- (void)runDownFrameAction{
    switch (self.character) {
        case TORTOISE:
        {
            [self stopAllActions];
            self.curFrameDirection = Down;
            [self setAnimate:@"tortoiseDown" image:@"后走龟/" firstIndex:@"0000" lastIndex:@"0012" isRepeate:YES isGame:YES];
        }
            break;
        case MONKEY:
        {
            [self stopAllActions];
            self.curFrameDirection = Down;
            [self setAnimate:@"monkeyDown" image:@"后/" firstIndex:@"0000" lastIndex:@"0024" isRepeate:YES isGame:YES];
        }
            break;
        case LIZARD:
        {
            [self stopAllActions];
            self.curFrameDirection = Down;
            [self setAnimate:@"lizardDown" image:@"蜥蜴后走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
        }
            break;
        default:
            break;
    }
}

- (void)runLeftFrameAction{
    switch (self.character) {
        case TORTOISE:
        {
            [self stopAllActions];
            self.curFrameDirection = Left;
            [self setAnimate:@"tortoiseLeft" image:@"左走龟/" firstIndex:@"0000" lastIndex:@"0010" isRepeate:YES isGame:YES];
        }
            break;
        case MONKEY:
        {
            [self stopAllActions];
            self.curFrameDirection = Left;
            [self setAnimate:@"monkeyLeft" image:@"左/" firstIndex:@"0000" lastIndex:@"0027" isRepeate:YES isGame:YES];
        }
            break;
        case LIZARD:
        {
            [self stopAllActions];
            self.curFrameDirection = Left;
            [self setAnimate:@"lizardLeft" image:@"蜥蜴左左/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
        }
            break;
        default:
            break;
    }
}

- (void)runRightFrameAction{
    switch (self.character) {
        case TORTOISE:
        {
            [self stopAllActions];
            self.curFrameDirection = Right;
            [self setAnimate:@"tortoiseRight" image:@"右走龟/" firstIndex:@"0000" lastIndex:@"0010" isRepeate:YES isGame:YES];
        }
            break;
        case MONKEY:
        {
            [self stopAllActions];
            self.curFrameDirection = Right;
            [self setAnimate:@"monkeyRight" image:@"右/" firstIndex:@"0000" lastIndex:@"0027" isRepeate:YES isGame:YES];
        }
            break;
        case LIZARD:
        {
            [self stopAllActions];
            self.curFrameDirection = Right;
            [self setAnimate:@"lizardRight" image:@"蜥蜴右走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
        }
            break;
        default:
            break;
    }
}

-(void)runToBox:(CGPoint)boxPoint
{
    CCActionAnimate *moveToBox = [CCActionMoveTo actionWithDuration:1.0f position:boxPoint];
    [self runAction:moveToBox];
}

-(void)runDieFrameAction
{
    [self stopAllActions];
    self.curFrameDirection = nil;
    
    CCActionInterval * move1 = [[CCActionMoveBy alloc]initWithDuration:0.5f position:CGPointMake(-30, 10)];
    CCActionInterval * move2 = [[CCActionMoveBy alloc]initWithDuration:0.5f position:CGPointMake(50, 10)];
    CCActionCallBlock *callBlock1 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"tortoiseDie2" image:@"龟死/" firstIndex:@"0001" lastIndex:@"0023" isRepeate:YES isGame:YES];
    }];
    CCActionCallBlock *callBlock2 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setVisible:false];
    }];
    NSArray *arr;
    arr = [[NSArray alloc]initWithObjects:callBlock1,move2,callBlock2, nil];
    
    CCActionSequence * seq = [[CCActionSequence alloc]initWithArray:arr];
    [self runAction:seq];
//    [[OALSimpleAudio sharedInstance]playEffect:@"撞车2.wav"];
}

-(void)runSpecialFrameAction
{
    [self stopAllActions];
    self.curFrameDirection = nil;
    [self setAnimate:@"tortoiseChange" image:@"龟变形/" firstIndex:@"0000" lastIndex:@"0052" isRepeate:NO isGame:NO];
}

-(void)goForwardSpeed:(float)s distance:(float)d
{
    self.isMove = true;
    CCActionInterval * move1 = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(d*sinf(VIEW_ANGLE), d*cosf(VIEW_ANGLE))];
    NSLog(@"%f,%f",d*sinf(VIEW_ANGLE),d*cosf(VIEW_ANGLE));
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        self.isMove = false;
    }];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:move1,callBlock, nil];
    
    CCActionSequence * seq1 = [[CCActionSequence alloc]initWithArray:arr];
    [self runAction:seq1];
}

-(void)goBackSpeed:(float)s distance:(float)d
{
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(-d*sinf(VIEW_ANGLE), -d*cosf(VIEW_ANGLE))];
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        self.isMove = false;
    }];
    
    CCActionSequence * seq = [[CCActionSequence alloc]initOne:move two:callBlock];
    [self runAction:seq];
}

-(void)goLeftSpeed:(float)s distance:(float)d
{
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(-d*cosf(ANGLE), d*sinf(ANGLE))];
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        self.isMove = false;
    }];
    
    CCActionSequence * seq = [[CCActionSequence alloc]initOne:move two:callBlock];
    [self runAction:seq];
}

-(void)goRightSpeed:(float)s distance:(float)d
{
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(d*cosf(ANGLE), -d*sinf(ANGLE))];
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        self.isMove = false;
    }];
    
    CCActionSequence * seq = [[CCActionSequence alloc]initOne:move two:callBlock];
    [self runAction:seq];
}
/**
 *  @author 小泽, 16-03-22 15:03:29
 *
 *  播放帧动画
 *
 *  @param fileName  文件名
 *  @param imageName 文件中帧动画名字
 *  @param first     从第几张开始
 *  @param last      在第几张结束
 *  @param isRepeate 是否循环播放动画
 */
-(void)setAnimate:(NSString *)fileName
            image:(NSString *)imageName
       firstIndex:(NSString *)first
        lastIndex:(NSString *)last
        isRepeate:(BOOL)isRepeate
           isGame:(BOOL)isGame
{
    _animatePlistFile = fileName;
    
    frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",_animatePlistFile] textureFilename:[NSString stringWithFormat:@"%@.png",_animatePlistFile]];
    
    _animateArr = [[NSMutableArray alloc]init];
    
    for (int i = [first intValue]; i < [last intValue]; i++) {
        if (i < 10) {
            selfAnimateFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@000%d",imageName, i]];
        }else if(i >= 10 && i < 100){
            selfAnimateFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@00%d",imageName, i]];
        }else if (i >= 100 && i<1000){
            selfAnimateFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@0%d",imageName, i]];
        }else if (i >= 1000){
            selfAnimateFrame = [frameCache spriteFrameByName:[NSString stringWithFormat:@"%@%d",imageName, i]];
        }else{
            NSLog(@"图片名字请重新设置");
        }
        [_animateArr addObject:selfAnimateFrame];
    }
    if (isGame) {
        self.scale = 0.3f;
    }else{
        self.scale = 1.f;
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:_animateArr delay:0.1];
    CCAction *act = [CCActionAnimate actionWithAnimation:animation];
    if (isRepeate) {
        CCActionRepeatForever *repeatForever = [CCActionRepeatForever actionWithAction:act];
        [self runAction:repeatForever];
    }else{
        [self runAction:act];
    }
    
}

#pragma mark  CollisionMethod
/**
 *  @author 小泽, 16-03-22 15:03:04
 *
 *  AABBs（Axis-aligned Bounding Boxes）碰撞检测
 *
 *  @param other 碰撞物
 *
 *  @return 是否进行碰撞
 */
- (BOOL)isEasyCollision:(CCSprite *)other
{
    float otherRadius = other.boundingBox.size.height/2;
    float selfRadius = self.boundingBox.size.height/2;
    if (ccpDistance(ccp(self.position.x+self.boundingBox.size.width/2, self.position.y+self.boundingBox.size.height/2), ccp(other.position.x+other.boundingBox.size.width/2, other.position.y+other.boundingBox.size.height/2))<=otherRadius+selfRadius) {
        return YES;
    }else{
        return NO;
    }
}
/**
 *  @author 小泽, 16-03-22 15:03:39
 *
 *  2.5D碰撞检测
 *
 *  @param other 碰撞物
 *
 *  @return 是否发生碰撞
 */
-(BOOL)is25DCollision:(CCSprite *)other
{
    float selfTrueHeight = self.boundingBox.size.height-self.boundingBox.size.width*tanf(ANGLE)*2;      //动物的真实高度
    float otherTrueHeight = other.boundingBox.size.height-other.boundingBox.size.width*tanf(ANGLE)*2;  //碰撞物的真实高度
    float otherLeft = other.position.x - other.boundingBox.size.width/2;    //碰撞物左端
    float otherRight= other.position.x + other.boundingBox.size.width/2;    //碰撞物右端
    float otherTop  = other.position.y + otherTrueHeight/2;                 //碰撞物顶端
    float otherBottom = other.position.y - otherTrueHeight/2;               //碰撞物底端
    float selfTop = self.position.y+selfTrueHeight/2;                       //动物顶端
    if (otherRight > self.position.x && otherLeft < self.position.x && selfTop <= otherTop && selfTop >= otherBottom) {
        return YES;
    }else{
        return NO;
    }
}


@end
