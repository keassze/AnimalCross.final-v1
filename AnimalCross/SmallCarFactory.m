//
//  SmallCarFactory.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "SmallCarFactory.h"

@implementation SmallCarFactory

-(Car *)factoryMethod:(CarDirection)direction speed:(CGFloat)speed
{
    return [[SmallCar alloc]initWithCarDirection:direction speed:speed];
}

@end
