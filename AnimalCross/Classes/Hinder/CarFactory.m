//
//  CarFactory.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/9.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CarFactory.h"

@implementation CarFactory

-(Car *)factoryMethod:(CarDirection)direction speed:(CGFloat)speed
{
    [NSException raise:NSInternalInconsistencyException format:Car_Init_Exception, [NSString stringWithUTF8String:object_getClassName(self)], NSStringFromSelector(_cmd)];
    return nil;
}

@end
