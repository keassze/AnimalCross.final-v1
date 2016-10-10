//
//  MainGameScene.h
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/5
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "AnimalChangeLayout.h"
#import "MapLayout.h"
#import "Animal.h"
#import "AnimalSpecial.h"
#import "SmallCar.h"
#import "MiddleCar.h"
#import "LargeCar.h"
#import "CarFactory.h"
#import "LargeCarFactory.h"
#import "MiddleCarFactory.h"
#import "SmallCarFactory.h"
#import "Car.h"
#import "Key.h"
#import "Tortoise.h"
#import "InterfaceScene.h"
#import "SpecialMapLayout.h"
// -----------------------------------------------------------------
/**
 *  @author 小泽, 16-03-29 15:03:07
 *
 *  游戏主逻辑界面
 */
@interface MainGameScene : CCScene
{
    int pauseCount;
    BOOL isStart;
    BOOL isSpecialStart;
    
    
    CGPoint beganPoint;
    CGPoint endPoint;
    CGPoint nextCarPoint;
    CGPoint animalSpecialPoint;
    CGFloat leftTime;
    
    NSMutableArray *carArr;
    
    CarFactory *middleFactory;
    CarFactory *largeFactory;
    CarFactory *smallFactory;
    
    Car *car;
    Car *smallCar_1;
    Car *smallCar_2;
    Car *smallCar_3;
    Car *smallCar_4;
    Car *smallCar_5;
    Car *smallCar_6;
    
    Car *middleCar_1;
    Car *middleCar_2;
    Car *middleCar_3;
    Car *middleCar_4;
    Car *middleCar_5;
    Car *middleCar_6;
    
    Car *largeCar_1;
    Car *largeCar_2;
    Car *largeCar_3;
    Car *largeCar_4;
    Car *largeCar_5;
    Car *largeCar_6;
    
    Key *key;
    CanPass direction;
    CCSprite *shadow;
    
    CCLabelTTF *needLabel;
    CCLabelTTF *numLabel;
    int keyNum;
    
    MapLayout *mapLayout;
    CCLayout *pauseLayout;
    AnimalChangeLayout *animalLayout;
    SpecialMapLayout *specialLayout;
    
    CCButton *pauseBtn;
    CCButton *backGameBtn;
    NSMutableArray *keyArr;
    
    CCSprite9Slice *background;//拥有透明度的图层，用于Layout间的切换
    float time;
    float dieTime;
    float specialTime;
    OALSimpleAudio* audioBg;
//    AnimalSpecial  *animalSpecial;
}

// -----------------------------------------------------------------
// properties
@property (nonatomic, strong)Animal *animal1;

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
- (void)initCar;
- (void)initPauseLayout;
- (void)initLabel;

-(void)pauseGame;
-(void)reStartGame;
-(void)nextGame;
-(void)backInterfaceScene;

-(void)updateGame:(CCTime)delta;
-(void)updateMap:(CCTime)delta;
-(void)updateSpeciaMap:(CCTime)delta;

-(BOOL)canPass:(CanPass)d;
//-(BOOL)specialCollision;
-(void)specialEnd:(CCTime)delta;
-(void)dieForHawk;
// -----------------------------------------------------------------

@end




