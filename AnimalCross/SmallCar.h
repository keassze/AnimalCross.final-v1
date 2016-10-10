//
//  SmallCar.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Car.h"

@interface SmallCar : Car

+(instancetype)node;
-(instancetype)initWithCarDirection:(CarDirection)direction
                              speed:(CGFloat)speed;

@end
