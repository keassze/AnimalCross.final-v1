//
//  GameInfo.h
//  AnimalCross
//
//  Created by 何松泽 on 16/1/5.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#ifndef GameInfo_h
#define GameInfo_h

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define VIEW_ANGLE          M_PI/5.35//VIEW_ANGLE越小越接近正常运动
#define ANGLE               M_PI/13.75
//#define Animal_Distance     24/sin(VIEW_ANGLE)
#define Animal_Distance     32
#define Tortoise_Speed      100
#define Slow_Car_Speed      100
#define Middle_Car_Speed    150
#define Quick_Car_Speed     200
#define Car_Distance        Animal_Distance/Tortoise_Speed*Quick_Car_Speed
//玩家选择角色
#define Choose_Animal       @"Choose_Animal"
//音效音量
#define Voice_Volume        @"Voicce_Volume"
#define Effect_Volume       @"Effect_Volume"

#define Left_Up_Btn         ccp(30, SCREEN_HEIGHT - 30)
//城市坐标
#define Start_Position      ccp(64*8, 290)
#define First_Left          ccp(912,300)
#define First_Right         ccp(100, 450)

#define Second_Left         ccp(1100, 450)//单行道

#define Third_Right         ccp(220, 748)
#define Third_Left          ccp(1100, 580)

#define Forth_Right1        ccp(400, 965)
#define Forth_Right2        ccp(430, 1015)
#define Forth_Left          ccp(1210, 880)

#define Fifth_Right         ccp(500, 1135)
#define Fifth_Left          ccp(1300,978)

#define Map_End_Position    ccp(-820.750032,-1105.000050)
#define End_Position        ccp(1096.042343,1124.941470)
#define Box_Position        ccp(1184.689306,1258.139503)

typedef enum{       //玩家角色
    TORTOISE = 0,
    MONKEY,
    LIZARD,
}Characters;

typedef enum{       //钥匙类型
    FISH = 0,
    BANANA,
    CABBAGE,
}KeyType;

typedef enum{       //地图
    CITY = 0,
    FOREST,
    DESERT,
}MapType;

typedef enum{       //玩家状态
    Normal,
    Die,
    Special,
    Change,
    Up,
    Down,
    Left,
    Right,
}PlayerDirection;

typedef enum{       //能否通过
    canUp = 1,
    canDown,
    canLeft,
    canRight,
}CanPass;

typedef enum{       //汽车方向
    carLeft,
    carRight,
}CarDirection;

#endif /* GameInfo_h */
