//
//  GameLayout.h
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/7
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface GameLayout : CCLayout<CCDirectorDelegate>
{
    CGPoint beganPoint;
    CGPoint endPoint;
}

// -----------------------------------------------------------------
// properties
@property (nonatomic,strong)CCSprite *circle;

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




