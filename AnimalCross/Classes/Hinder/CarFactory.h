//
//  CarFactory.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/9.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface CarFactory : NSObject


-(Car *)factoryMethod:(CarDirection)direction
                speed:(CGFloat)speed;

@end
