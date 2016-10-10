//
//  AnimalChangeLayout.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/20.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCLayout.h"
#import "Animal.h"
#import "Tortoise.h"
#import "Lizard.h"
#import "Monkey.h"

@interface AnimalChangeLayout : CCLayout
{
    Animal *animal;
    CCSprite9Slice *background;
}
@property (nonatomic, assign)BOOL isEnd;

+ (instancetype)node;
- (instancetype)init;
- (void)animalChange;

@end
