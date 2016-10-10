//
//  Car.m
//  AnimalCross
//
//  Created by 何松泽 on 16/2/2.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Car.h"

@implementation Car


+ (instancetype)node
{
    return [[self alloc] init];
}

-(instancetype)init
{
//    NSString *imageName;
    self.imageName = @"货车.png";
    if (self = [super initWithImageNamed:self.imageName]) {
        self.speed = Quick_Car_Speed;
        self.isMove = YES;
        
    }
    return self;
}

-(void)goForwardSpeed:(float)s distance:(float)d
{
    s = self.speed;
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(d*sinf(VIEW_ANGLE), d*cosf(VIEW_ANGLE))];
 
    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc]initWithAction:move];
    [self runAction:forever];
}

-(void)goBackSpeed:(float)s distance:(float)d
{
    s = self.speed;
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(-d*sinf(VIEW_ANGLE), -d*cosf(VIEW_ANGLE))];

    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc]initWithAction:move];
    [self runAction:forever];
}

-(void)goLeftSpeed:(float)s distance:(float)d
{
    s = self.speed;
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(-d*cosf(ANGLE), d*sinf(ANGLE))];

    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc]initWithAction:move];
    [self runAction:forever];
}

-(void)goRightSpeed:(float)s distance:(float)d
{
    s = self.speed;
    self.isMove = true;
    CCActionInterval * move = [[CCActionMoveBy alloc]initWithDuration:d/s position:CGPointMake(d*cosf(ANGLE), -d*sinf(ANGLE))];

    CCActionRepeatForever *forever = [[CCActionRepeatForever alloc]initWithAction:move];
    [self runAction:forever];
}

-(CGPoint)nextCarPosition:(float)distance
{
    CGPoint nextCarPosition;
    if (self.carDirection == carRight) {//向右开的车，下一辆在左边
        nextCarPosition = ccp(self.position.x-distance*cosf(ANGLE) - self.boundingBox.size.width*cosf(ANGLE), self.position.y+distance*sinf(ANGLE) + self.boundingBox.size.width*sinf(ANGLE));
    }else if (self.carDirection == carLeft){//向左开的车，下一辆在右边
        nextCarPosition = ccp(self.position.x+distance*cosf(ANGLE) + self.boundingBox.size.width*cosf(ANGLE), self.position.y-distance*sinf(ANGLE) - self.boundingBox.size.width*sinf(ANGLE));
    }else{
        [NSException raise:NSInternalInconsistencyException format:Car_Init_Exception, [NSString stringWithUTF8String:object_getClassName(self)], NSStringFromSelector(_cmd)];
    }
    return nextCarPosition;
}

-(void)make
{
    if ([self isMemberOfClass:[Car class]]) {
        
    }else{
        [NSException raise:NSInternalInconsistencyException format:Car_Init_Exception, [NSString stringWithUTF8String:object_getClassName(self)], NSStringFromSelector(_cmd)];
    }
}

-(void)stop
{
    [self stopAllActions];
}

-(void)restart:(CGPoint)restartPoint
        zOrder:(int)z
{
    if (self.carDirection == carLeft) {
        if (self.position.x < restartPoint.x-(SCREEN_WIDTH+self.boundingBox.size.width*2)) {
            [self stop];
            self.position = restartPoint;
            [self make];
        }
    }else if (self.carDirection == carRight){
        if (self.position.x > restartPoint.x+SCREEN_WIDTH+self.boundingBox.size.width*2) {
            [self stop];
            self.position = restartPoint;
            [self make];
        }
    }
    [self setZOrder:z];
}

@end
