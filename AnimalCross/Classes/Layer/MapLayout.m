//
//  MapLayout.m
//  AnimalCross
//
//  Created by 何松泽 on 16/3/3.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "MapLayout.h"

@implementation MapLayout

+(instancetype)node
{
    return [[self alloc]init];
}

-(instancetype)initWithMapType:(MapType)mapType
{
    if (self = [super init]) {
        if (mapType == CITY) {
            _tileMap = [CCTiledMap tiledMapWithFile:@"background.tmx"];
            //        NSAssert(_object != nil, @"object not found");
            _tiledBg = [_tileMap layerNamed:@"background"];
            
            _tileBuilding = [CCTiledMap tiledMapWithFile:@"hinder.tmx"];
            _buildingBg = [_tileBuilding layerNamed:@"hinder"];
            _tiledCollision = [_tileBuilding layerNamed:@"collision"];
            
            _sewer1 = [Sewer new];
            _sewer1.position = ccp(Start_Position.x+120, Start_Position.y+320);
//            _sewer1.position = ccp(Start_Position.x+80, Start_Position.y+80);
            _sewer2 = [Sewer new];
//            _sewer2.position = ccp(_sewer1.position.x+190*cosf(ANGLE), _sewer1.position.y - 190*sinf(ANGLE));
            _sewer2.position = ccp(_sewer1.position.x+120*cosf(ANGLE), _sewer1.position.y + 800*sinf(ANGLE));
            
        }
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        Characters character = [[userDefault stringForKey:Choose_Animal] intValue];
        _animal = [[Animal alloc]initWithCharactersName:character];
        _animal.position = Start_Position;
        [_animal runUpFrameAction];

        [self addChild:_tileMap z:1];
        [self addChild:_sewer1 z:1];
        [self addChild:_sewer2 z:1];
        [self addChild:_animal z:1];
        [self addChild:_tileBuilding z:2];
//        [self setViewpointCenter:_animal.position];
        
    }
    return self;
}

-(void)setViewpointCenter:(CGPoint) position {
    
    
    int x = MAX(position.x, SCREEN_WIDTH / 2);
    int y = MAX(position.y, SCREEN_HEIGHT / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width)
            - SCREEN_WIDTH / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height)
            - SCREEN_HEIGHT/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
    
}

@end
