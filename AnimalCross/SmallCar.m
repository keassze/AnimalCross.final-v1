//
//  SmallCar.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "SmallCar.h"

@implementation SmallCar

+ (instancetype)node
{
    return [[self alloc] init];
}

-(instancetype)initWithCarDirection:(CarDirection)direction speed:(CGFloat)speed
{
    //    NSString *imageName;
    if (direction == carLeft) {
        self.imageName = @"小车左.png";
    }else if (direction == carRight){
        self.imageName = @"小车右.png";
    }else{
        [NSException raise:NSInternalInconsistencyException format:Car_Direction_Exception];
    }
    
    if (self = [super initWithImageNamed:self.imageName]) {
        self.carDirection = direction;
        self.speed = speed;
        self.isMove = YES;
    }
    return self;
}

-(void)make
{
    if (self.carDirection == carLeft) {
        [self goLeftSpeed:self.speed distance:Car_Distance];
    }else if (self.carDirection == carRight){
        [self goRightSpeed:self.speed distance:Car_Distance];
    }
//    NSLog(@"小车");
}


@end
