//
//  Car.h
//  AnimalCross
//
//  Created by 何松泽 on 16/2/2.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCSprite.h"

#define Car_Init_Exception @"在%@的子类中必须override:%@方法"
#define Car_Direction_Exception @"请给汽车方向设值"

@interface Car : CCSprite

@property (nonatomic, strong)NSString *imageName;

@property (nonatomic, assign)CarDirection carDirection;//汽车开往的方向

@property (nonatomic, assign)float  speed;
@property (nonatomic, assign)BOOL   isMove;

-(instancetype)init;
+(instancetype)node;
-(void)make;        //汽车制作，子类不调用报错
-(void)stop;        //开出视线范围老司机就停车吧
-(void)restart:(CGPoint)restartPoint
        zOrder:(int)z;     //老司机重新发车
-(void)goForwardSpeed:(float)s
             distance:(float)d;
-(void)goBackSpeed:(float)s
          distance:(float)d;
-(void)goLeftSpeed:(float)s
          distance:(float)d;
-(void)goRightSpeed:(float)s
           distance:(float)d;
-(CGPoint)nextCarPosition:(float)distance;

//-(void)setMove:(BOOL)move;

@end
