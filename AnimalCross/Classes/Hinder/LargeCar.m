//
//  LargeCar.m
//  AnimalCross
//
//  Created by 何松泽 on 16/2/24.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "LargeCar.h"

@implementation LargeCar


+ (instancetype)node
{
    return [[self alloc] init];
}

-(instancetype)initWithCarDirection:(CarDirection)direction speed:(CGFloat)speed
{
    //    NSString *imageName;
    if (direction == carLeft) {
        self.imageName = @"货车左.png";
    }else if (direction == carRight){
        self.imageName = @"货车右.png";
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
//    NSLog(@"货车");
}


@end
