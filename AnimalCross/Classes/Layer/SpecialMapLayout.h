//
//  SpecialMapLayout.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/31.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCLayout.h"
#import "AnimalSpecial.h"
#import "Key.h"

@interface SpecialMapLayout : CCLayout
{
    float time1;
    float time2;
}
@property (nonatomic, retain)CCTiledMap *tileMap;
@property (nonatomic, retain)CCTiledMapLayer *tiledBg;
@property (nonatomic, retain)CCTiledMapLayer *tiledCollision;
@property (nonatomic, strong)CCSprite9Slice *background;
@property (nonatomic, strong)AnimalSpecial *animalSpecial;
@property (nonatomic, strong)NSMutableArray *keyArr;
@property (nonatomic, assign)BOOL isSpecialStart;       //特殊关卡是否开始了
@property (nonatomic, assign)BOOL isSpecialEnd;         //特殊关卡是否结束了

+ (instancetype)node;
- (instancetype)init;
- (void)makeKey:(int)num;
- (BOOL)specialCollision;
//- (void)dismissSpecial:(CCTime)delta;

@end
