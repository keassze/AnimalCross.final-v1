//
//  SpecialMapLayout.m
//  animalSpecialCross
//
//  Created by 何松泽 on 16/3/31.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "SpecialMapLayout.h"

@implementation SpecialMapLayout

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _isSpecialStart = NO;
        _isSpecialEnd = NO;
        
        
//        _background = [CCSprite9Slice spriteWithImageNamed:@"透明度.png"];
//        _background.anchorPoint = CGPointZero;
//        _background.color = [CCColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
//        _background.opacity = 0.f;
//        [self addChild:_background z:1];
        
        _tileMap = [CCTiledMap tiledMapWithFile:@"city-special.tmx"];
        //        NSAssert(_object != nil, @"object not found");
        _tileMap.position = ccp(0, 0);
        _tiledBg = [_tileMap layerNamed:@"background"];
        _tiledCollision = [_tileMap layerNamed:@"collision"];
        [self addChild:_tileMap];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        _animalSpecial = [[AnimalSpecial alloc]initWithCharactersName:(Characters)[[userDefault valueForKey:Choose_Animal] integerValue]];
        _animalSpecial.opacity = 0.f;
        _animalSpecial.visible = YES;
        _animalSpecial.position = ccp(80, SCREEN_HEIGHT/2);
        [self addChild:_animalSpecial];
        
        _keyArr = [[NSMutableArray alloc]init];
        for (int i = 1 ; i <= 50; i++) {
            Key *key = [[Key alloc]initWith3D:NO KeyType:FISH];
            key.position = ccp(_animalSpecial.position.x + Animal_Distance*2*i, _animalSpecial.position.y);
            key.visible = NO;
            [self addChild:key];
            [_keyArr addObject:key];
        }
        for (int i = 1; i <= 10; i++) {
//            [self makeKey:i];
        }
        
    }
    return self;
}
-(void)makeKey:(int)num
{
    for (int i = 1 ; i <= 2; i++) {
        Key *key = [[Key alloc]initWith3D:NO KeyType:FISH];
        key.position = ccp(_animalSpecial.position.x + Animal_Distance*7*num, _animalSpecial.position.y + Animal_Distance *2*i*num);
        key.visible = NO;
        [self addChild:key];
        [_keyArr addObject:key];
    }
    for (int i = 1 ; i <= 2; i++) {
        Key *key = [[Key alloc]initWith3D:NO KeyType:FISH];
        key.position = ccp(_animalSpecial.position.x + Animal_Distance*7*(num+1), _animalSpecial.position.y - Animal_Distance *2*i*num);
        key.visible = NO;
        [self addChild:key];
        [_keyArr addObject:key];
    }
}
-(BOOL)specialCollision
{
    CGPoint nowUpPoint=[_tiledCollision tileCoordinateAt:ccp(_animalSpecial.position.x, _animalSpecial.position.y + _animalSpecial.boundingBox.size.height/2)];
    CGPoint nowDownPoint=[_tiledCollision tileCoordinateAt:ccp(_animalSpecial.position.x, _animalSpecial.position.y - _animalSpecial.boundingBox.size.height/2)];
    CGPoint nowLeftPoint=[_tiledCollision tileCoordinateAt:ccp(_animalSpecial.position.x - _animalSpecial.boundingBox.size.width/2, _animalSpecial.position.y)];
    CGPoint nowRightPoint=[_tiledCollision tileCoordinateAt:ccp(_animalSpecial.position.x + _animalSpecial.boundingBox.size.width/2, _animalSpecial.position.y)];
    int gidUp = [_tiledCollision tileGIDAt:ccp(nowUpPoint.x, nowUpPoint.y+1)];
    int gidDown = [_tiledCollision tileGIDAt:ccp(nowDownPoint.x, nowDownPoint.y-1)];
    int gidLeft =[_tiledCollision tileGIDAt:ccp(nowLeftPoint.x , nowLeftPoint.y)];
    int gidRight = [_tiledCollision tileGIDAt:ccp(nowRightPoint.x, nowRightPoint.y)];
//    NSLog(@"%d,%d,%d,%d",gidUp,gidDown,gidLeft,gidRight);
    NSDictionary *propertiesUp = [_tileMap propertiesForGID:gidUp];
    NSDictionary *propertiesDown = [_tileMap propertiesForGID:gidDown];
    NSDictionary *propertiesLeft = [_tileMap propertiesForGID:gidLeft];
    NSDictionary *propertiesRight = [_tileMap propertiesForGID:gidRight];
    if (propertiesUp||propertiesDown||propertiesLeft||propertiesRight) {
        //        NSLog(@"%@",[properties valueForKey:@"Collision"]);
        if ([[propertiesUp valueForKey:@"Collision"] isEqualToString:@"true"]) {
            return YES;
        }
        if ([[propertiesDown valueForKey:@"Collision"] isEqualToString:@"true"]) {
            return YES;
        }
        if ([[propertiesRight valueForKey:@"Collision"] isEqualToString:@"true"]) {
            return YES;
        }
        if ([[propertiesLeft valueForKey:@"Collision"] isEqualToString:@"true"]) {
            return YES;
        }
    }else{
        return NO;
    }
    return NO;
}

//-(void)dismissSpecial:(CCTime)delta
//{
//    CCActionInterval *fadeIn = [[CCActionFadeIn alloc]initWithDuration:1.0f];
//    CCActionInterval *fadeOut = [[CCActionFadeOut alloc]initWithDuration:1.0f];
//    CCActionSequence *seq1 =[[CCActionSequence alloc] initOne:fadeIn two:[CCActionCallBlock actionWithBlock:^{
//        background.opacity= 1.f;
//        animalSpecial.visible = NO;
//        _tileMap.visible = NO;
//    }]];
//    [background runAction:[[CCActionSequence alloc] initOne:seq1 two:fadeOut]];
    
    //无法使用延时动作，自行计算opacity来实现FadeIn/FadeOut
//    time1 += delta;
//    if (time1<= 1.f) {
//        _background.opacity = 1.f*time1;
//    }else if(time1 <= 3.f){
//        time2 +=delta;
//        _background.opacity = 1- 1.f*time2;
//        _tileMap.visible = NO;
//        animalSpecial.visible = NO;
//    }
//}

@end
