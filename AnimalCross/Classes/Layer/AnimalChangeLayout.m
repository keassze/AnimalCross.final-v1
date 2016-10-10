//
//  AnimalChangeLayout.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/20.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "AnimalChangeLayout.h"

@implementation AnimalChangeLayout


+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        //        NSAssert(_animal != nil, @"object not found");
        background = [CCSprite9Slice spriteWithImageNamed:@"透明度.png"];
        background.anchorPoint = CGPointZero;
//        background.contentSize = [CCDirector sharedDirector].viewSize;
        background.color = [CCColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
//        [background setOpacity:0.3f];
        [self addChild:background];
        
        _isEnd = NO;
        
        animal = [[Animal alloc]initWithCharactersName:TORTOISE];
        [animal setAnimate:@"tortoiseChange" image:@"龟变形/" firstIndex:@"0000" lastIndex:@"0001" isRepeate:NO isGame:NO];
        animal.position = ccp(SCREEN_WIDTH*0.55f, SCREEN_HEIGHT/2);
        animal.visible = NO;
//        [animal setScale:1.f];
        [self addChild:animal];
    }
    return self;
}

-(void)animalChange
{
    CCActionInterval *fadeIn = [[CCActionFadeIn alloc]initWithDuration:0.5f];
    CCActionInterval *fadeOut = [[CCActionFadeOut alloc]initWithDuration:0.5f];
    CCActionInterval *interval = [[CCActionInterval alloc]initWithDuration:5.5f];
    CCActionCallBlock *dismiss = [CCActionCallBlock actionWithBlock:^{
        animal.visible = NO;
    }];
    CCActionSequence *seq1 =[[CCActionSequence alloc] initOne:fadeIn two:[CCActionCallBlock actionWithBlock:^{
        animal.visible = YES;
        [animal runSpecialFrameAction];
    }]];
    CCActionSequence *seq2 =[[CCActionSequence alloc] initOne:interval two:dismiss];
    CCActionSequence *seq3 = [[CCActionSequence alloc] initOne:seq1 two:seq2];
    CCActionSequence *seq4 = [[CCActionSequence alloc]initOne:seq3 two:fadeOut];
    [background runAction:[[CCActionSequence alloc] initOne:seq4 two:[CCActionCallBlock actionWithBlock:^{
        _isEnd = YES;
    }]]];
}

@end
