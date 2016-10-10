//
//  MapLayout.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/3.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCLayout.h"
#import "Animal.h"
#import "Tortoise.h"
#import "Sewer.h"
#import "Key.h"

@interface MapLayout : CCLayout

@property (nonatomic, retain)CCTiledMap *tileMap;
@property (nonatomic, retain)CCTiledMapLayer *tiledBg;
@property (nonatomic, retain)CCTiledMapLayer *shadowsBg;

@property (nonatomic, retain)CCTiledMap *tileBuilding;
@property (nonatomic, retain)CCTiledMapLayer *buildingBg;
@property (nonatomic, retain)CCTiledMapLayer *tiledCollision;

@property (nonatomic, retain)CCTiledMapObjectGroup *object;

@property (nonatomic, strong)Animal *animal;
@property (nonatomic, strong)Sewer *sewer1;
@property (nonatomic, strong)Sewer *sewer2;



+ (instancetype)node;
- (instancetype)initWithMapType:(MapType)mapType;
-(void)setViewpointCenter:(CGPoint) position;

@end
