//
//  AnimateScene.h
//  AnimalCross
//
//  Created by 何松泽 on 16/2/1.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "CCScene.h"

@interface AnimateScene : CCScene

@property (nonatomic, strong) NSMutableArray *animateArr;

@property (nonatomic, strong) CCButton *skipBtn;
@property (nonatomic, strong) CCButton *nextBtn;

@property (nonatomic, strong) CCSprite *startAnimateSprite;
@property (nonatomic, strong) CCSpriteFrame *startAnimateFrame;
@property (nonatomic, strong) CCSpriteFrameCache *frameCache;

@property(readonly, copy, nonatomic) NSString *animatePlistFile;


+ (instancetype)node;
- (instancetype)init;
- (void)skipAnimate;
- (void)nextAnimate;

- (void)setAnimate:(NSString *)fileName
             image:(NSString *)imageName
        firstIndex:(NSString *)first
       lastIndex:(NSString *)last;
- (void)startAnimate;

@end
