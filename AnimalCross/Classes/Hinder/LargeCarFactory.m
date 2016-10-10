//
//  LargeCarFactory.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/9.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "LargeCarFactory.h"

@implementation LargeCarFactory

-(Car *)factoryMethod:(CarDirection)direction speed:(CGFloat)speed
{
    return [[LargeCar alloc]initWithCarDirection:direction speed:speed];
}

@end
