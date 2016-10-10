//
//  MiddleCarFactory.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/9.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "MiddleCarFactory.h"

@implementation MiddleCarFactory

-(Car *)factoryMethod:(CarDirection)direction speed:(CGFloat)speed
{
    return [[MiddleCar alloc]initWithCarDirection:direction speed:speed];
}

@end
