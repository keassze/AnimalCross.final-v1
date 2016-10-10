//
//  Tortoise.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/4.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Tortoise.h"

@implementation Tortoise

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.isMove = false;
        self.canPass = true;
        self.character = TORTOISE;
    }
    return self;
}

- (void)runNormalFrameAction{
    [self stopAllActions];
    switch (self.curFrameDirection) {
        case Up:
            [self setAnimate:@"tortoiseUp" image:@"前走龟/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Down:
            [self setAnimate:@"tortoiseDown" image:@"后走龟/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Right:
            [self setAnimate:@"tortoiseRight" image:@"右走龟/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Left:
            [self setAnimate:@"tortoiseLeft" image:@"左走龟/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        default:
            break;
    }
    
}
- (void)runUpFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Up;
    [self setAnimate:@"tortoiseUp" image:@"前走龟/" firstIndex:@"0000" lastIndex:@"0039" isRepeate:YES isGame:YES];
}

- (void)runDownFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Down;
    [self setAnimate:@"tortoiseDown" image:@"后走龟/" firstIndex:@"0000" lastIndex:@"0012" isRepeate:YES isGame:YES];
}

- (void)runLeftFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Left;
    [self setAnimate:@"tortoiseLeft" image:@"左走龟/" firstIndex:@"0000" lastIndex:@"0010" isRepeate:YES isGame:YES];
}

- (void)runRightFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Right;
    [self setAnimate:@"tortoiseRight" image:@"右走龟/" firstIndex:@"0000" lastIndex:@"0010" isRepeate:YES isGame:YES];
}

-(void)runDieFrameAction{
    [self stopAllActions];
    self.curFrameDirection = nil;
    
    CCActionInterval * move1 = [[CCActionMoveBy alloc]initWithDuration:0.5f position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock1 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"tortoiseDie" image:@"龟死/" firstIndex:@"0000" lastIndex:@"0023" isRepeate:YES isGame:YES];
    }];
    CCActionCallBlock *callBlock2 = [[CCActionCallBlock alloc]initWithBlock:^{
        self.opacity = 0;
    }];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:callBlock1,move1,callBlock2, nil];
    
    CCActionSequence * seq = [[CCActionSequence alloc]initWithArray:arr];
    [self runAction:seq];
}

-(void)runSpecialFrameAction
{
    [self stopAllActions];
    self.curFrameDirection = nil;
    [self setAnimate:@"tortoiseChange" image:@"龟变形/" firstIndex:@"0000" lastIndex:@"0052" isRepeate:NO isGame:NO];
}


@end
