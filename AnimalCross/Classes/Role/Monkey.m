//
//  Monkey.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Monkey.h"

@implementation Monkey

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.isMove = false;
        self.canPass = true;
        self.scale = 0.1f;
        self.character = MONKEY;
        
        CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [spriteFrameCache addSpriteFramesWithFile:@"monkeyDown.plist"];
        
//        self = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"后/0000"]];

    }
    return self;
}

- (void)runNormalFrameAction{
    [self stopAllActions];
    switch (self.curFrameDirection) {
        case Up:
            [self setAnimate:@"monkeyUp" image:@"前/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Down:
            [self setAnimate:@"monkeyDown" image:@"后/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Right:
            [self setAnimate:@"monkeyRight" image:@"右/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        case Left:
            [self setAnimate:@"monkeyLeft" image:@"左/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:YES];
            self.curFrameDirection = Normal;
            break;
        default:
            break;
    }
    
}
- (void)runUpFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Up;
    [self setAnimate:@"monkeyUp" image:@"前/" firstIndex:@"0000" lastIndex:@"0024" isRepeate:YES isGame:YES];
}

- (void)runDownFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Down;
    [self setAnimate:@"monkeyDown" image:@"后/" firstIndex:@"0000" lastIndex:@"0024" isRepeate:YES isGame:YES];
}

- (void)runRightFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Right;
    [self setAnimate:@"monkeyRight" image:@"右/" firstIndex:@"0000" lastIndex:@"0027" isRepeate:YES isGame:YES];
}

- (void)runLeftFrameAction{
    [self stopAllActions];
    self.curFrameDirection = Left;
    [self setAnimate:@"monkeyLeft" image:@"左/" firstIndex:@"0000" lastIndex:@"0027" isRepeate:YES isGame:YES];
}



@end
