//
//  GameLayout.m
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/7
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameLayout.h"

// -----------------------------------------------------------------

@implementation GameLayout

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        NSAssert(self, @"Unable to create class %@", [self class]);
        // class initalization goes here
        
        _circle = [CCSprite spriteWithImageNamed:@"circle.png"];
        _circle.position = ccp(0, 200);
        
        [self addChild:_circle z:1];
    
        self.userInteractionEnabled = TRUE;
        [self setMultipleTouchEnabled:TRUE];
    }
    
    
    return self;
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    beganPoint = [touch locationInNode:self];
    NSLog(@"HERE IS(%f,%f)",beganPoint.x,beganPoint.y);
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
}

// -----------------------------------------------------------------

@end





