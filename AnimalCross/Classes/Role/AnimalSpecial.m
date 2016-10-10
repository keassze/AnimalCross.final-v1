//
//  AnimalSpecial.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/31.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "AnimalSpecial.h"

@implementation AnimalSpecial

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
//        normalFrameAction = nil;
//        dieFrameAction = nil;
//        specialFrameAction = nil;
//        upFrameAction = nil;
//        downFrameAction = nil;
//        leftFrameAction = nil;
//        rightFrameAction = nil;
//        
//        _isMove = false;
//        _canPass = true;
        
    }
    
    return self;
}

- (id)initWithCharactersName:(Characters)charactersName{
    //    NSString *plistFileName = [NSString stringWithFormat:@"tt"];
    if (self = [self init]) {
        switch (charactersName) {
            case TORTOISE:
                self = [super initWithImageNamed:@"tortoiseSpecial.png"];
                break;
            case MONKEY:
                self = [super initWithImageNamed:@"tortoiseSpecial.png"];
                break;
            case LIZARD:
                self = [super initWithImageNamed:@"tortoiseSpecial.png"];
                break;
            default:
                break;
        }
        self.scale = 0.6f;
    }
    return self;
}

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

@end
