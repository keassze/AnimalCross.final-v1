//
//  HelloWorldScene.m
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/4
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "HelloWorldScene.h"


// -----------------------------------------------------------------------

@implementation HelloWorldScene

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    
    // The thing is, that if this fails, your app will 99.99% crash anyways, so why bother
    // Just make an assert, so that you can catch it in debug
    NSAssert(self, @"Whoops");
    
    // Background
    CCSprite9Slice *background = [CCSprite9Slice spriteWithImageNamed:@"white_square.png"];
    background.anchorPoint = CGPointZero;
    background.contentSize = [CCDirector sharedDirector].viewSize;
    CCLOG(@"%f,%f",[CCDirector sharedDirector].viewSize.width,[CCDirector sharedDirector].viewSize.height);
    background.color = [CCColor grayColor];
    [self addChild:background];
    
    // The standard Hello World text
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"ArialMT" fontSize:64];
    label.positionType = CCPositionTypeNormalized;
    label.position = (CGPoint){0.5, 0.5};
    [self addChild:label];
    
    _animal1 = [[Animal alloc]initWithCharactersName:TORTOISE];
    _animal1.position = ccp(200, 200);
    _animal1.scale = 1.f;
    [self addChild:_animal1 z:100];
    [_animal1 runLeftFrameAction];
    // done
    return self;
}



// -----------------------------------------------------------------------

@end























// why not add a few extra lines, so we dont have to sit and edit at the bottom of the screen ...
