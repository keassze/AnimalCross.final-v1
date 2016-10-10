//
//  Key.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/7.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCSprite.h"

@interface Key : CCSprite

@property (nonatomic, strong) NSMutableArray *animateArr;

@property(readonly, copy, nonatomic) NSString *animatePlistFile;
@property(nonatomic, assign)KeyType keyType;
@property (nonatomic, strong) CCSpriteFrame *selfAnimateFrame;
@property (nonatomic, strong) CCSpriteFrameCache *frameCache;

+ (instancetype)node;
- (instancetype)initWith3D:(BOOL)is3D KeyType:(KeyType )keyType;

- (void)setAnimate:(NSString *)fileName
             image:(NSString *)imageName
        firstIndex:(NSString *)first
         lastIndex:(NSString *)last
              is3D:(BOOL)is3D;

@end
