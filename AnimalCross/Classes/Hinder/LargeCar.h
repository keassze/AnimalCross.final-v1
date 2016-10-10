//
//  LargeCar.h
//  AnimalCross
//
//  Created by 何松泽 on 16/2/24.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "Car.h"

@interface LargeCar : Car

+(instancetype)node;
-(instancetype)initWithCarDirection:(CarDirection)direction
                              speed:(CGFloat)speed;

@end
