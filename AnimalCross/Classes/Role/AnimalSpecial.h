//
//  AnimalSpecial.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/31.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCSprite.h"

@interface AnimalSpecial : CCSprite

+ (instancetype)node;
- (instancetype)init;

- (id)initWithCharactersName:(Characters)charactersName;
- (BOOL)isEasyCollision:(CCSprite *)other;

@end
