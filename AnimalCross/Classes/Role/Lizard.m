//
//  Lizard.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/9.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Lizard.h"

@implementation Lizard

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.isMove = false;
        self.canPass = true;
        self.character = LIZARD;
    }
    return self;
}

- (void)runNormalFrameAction{
    [self stopAllActions];
    switch (self.curFrameDirection) {
        case Up:
            [self setAnimate:@"lizardUp" image:@"蜥蜴前走/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Down:
            [self setAnimate:@"lizardDown" image:@"蜥蜴后走/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Right:
            [self setAnimate:@"lizardRight" image:@"蜥蜴右走/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Left:
            [self setAnimate:@"lizardLeft" image:@"蜥蜴左左/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        default:
            break;
    }
    
}
- (void)runUpFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Up;
    [self setAnimate:@"lizardUp" image:@"蜥蜴前走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
}

- (void)runDownFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Down;
    [self setAnimate:@"lizardDown" image:@"蜥蜴后走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
}

- (void)runLeftFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Left;
    [self setAnimate:@"lizardLeft" image:@"蜥蜴左左/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
}

- (void)runRightFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Right;
    [self setAnimate:@"lizardRight" image:@"蜥蜴右走/" firstIndex:@"0000" lastIndex:@"0009" isRepeate:YES isGame:YES];
}

@end
