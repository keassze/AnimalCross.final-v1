//
//  AnimateScene.m
//  AnimalCross
//
//  Created by 何松泽 on 16/2/1.
//  Copyright © 2016年 HSZ. All rights reserved.
//
#define DelayTime   0.1f

#import "AnimateScene.h"
#import "InterfaceScene.h"
/**
 *  @author 小泽, 16-03-29 15:03:41
 *
 *  片头界面
 */
@implementation AnimateScene

+(instancetype)node
{
    return [[self alloc]init];
}

-(instancetype)init
{
    self = [super init];
//
//    _startAnimateSprite = [[CCSprite alloc]initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Icon-72.png"]];
    _startAnimateSprite = [[CCSprite alloc]init];
    _startAnimateSprite.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);

    _skipBtn = [[CCButton alloc]initWithTitle:@"skip" fontName:@"consolas" fontSize:14.f];
    _skipBtn.position = ccp(SCREEN_WIDTH - 20, SCREEN_HEIGHT - 20);
    [_skipBtn setTarget:self selector:@selector(skipAnimate)];
    
    _nextBtn = [[CCButton alloc]initWithTitle:@"next" fontName:@"consolas" fontSize:14.f];
    _nextBtn.position = ccp(SCREEN_WIDTH - 20, 20);
    [_nextBtn setVisible:FALSE];
    [_nextBtn setTarget:self selector:@selector(nextAnimate)];
    
    //播放动画
    [self startAnimate];

    [self addChild:_startAnimateSprite z:-1];
    [self addChild:_skipBtn z:1];
    [self addChild:_nextBtn z:1];
    
    return self;
}

-(void)skipAnimate
{
    [[CCDirector sharedDirector]replaceScene:[InterfaceScene new]];
}

-(void)nextAnimate
{
    [_nextBtn setVisible:FALSE];
//    [self setAnimate:@"OpenAnimate" image:@"分镜完成5/" firstIndex:@"0365" lastIndex:@"0410"];
    [self setAnimate:@"片头2" image:@"2/" firstIndex:@"0022" lastIndex:@"0042"];
}

-(void)setAnimate:(NSString *)fileName
            image:(NSString *)imageName
       firstIndex:(NSString *)first
      lastIndex:(NSString *)last
{
    _animatePlistFile = fileName;
    
    _frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [_frameCache addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",_animatePlistFile] textureFilename:[NSString stringWithFormat:@"%@.png",_animatePlistFile]];
    
    _animateArr = [[NSMutableArray alloc]init];
    
    for (int i = [first intValue]; i <= [last intValue]; i++) {
        if (i < 10) {
            _startAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@000%d",imageName, i]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@000%d",imageName, i]);
        }else if(i >= 10 && i < 100){
            _startAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@00%d",imageName, i]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@00%d",imageName, i]);
        }else if (i >= 100 && i<1000){
            _startAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@0%d",imageName, i]];
        }else if (i >= 1000){
            _startAnimateFrame = [_frameCache spriteFrameByName:[NSString stringWithFormat:@"%@%d",imageName, i]];
        }else{
            NSLog(@"图片名字请重新设置");
        }
        [_animateArr addObject:_startAnimateFrame];
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:_animateArr delay:DelayTime];
    CCAction *act = [CCActionAnimate actionWithAnimation:animation];
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        [_nextBtn setVisible:TRUE];
    }];
    
    NSMutableArray *seqArr = [[NSMutableArray alloc]initWithObjects:act,callBlock,nil];
    CCActionSequence *seq = [[CCActionSequence alloc]initWithArray:seqArr];
    [_startAnimateSprite runAction:seq];
}

-(void)startAnimate
{
    //顺序播放片头动画
    
    CCActionCallBlock *callBlock1 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt1" image:@"1/" firstIndex:@"0000" lastIndex:@"0021"];
    }];
    CCActionInterval * move1 = [[CCActionMoveBy alloc]initWithDuration:2.1 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock2 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt2" image:@"2/" firstIndex:@"0000" lastIndex:@"0042"];
    }];
    CCActionInterval * move2 = [[CCActionMoveBy alloc]initWithDuration:4.2 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock3 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt3" image:@"3/" firstIndex:@"0000" lastIndex:@"0027"];
    }];
    CCActionInterval * move3 = [[CCActionMoveBy alloc]initWithDuration:2.7 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock4 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt4" image:@"4/" firstIndex:@"0000" lastIndex:@"0020"];
    }];
    CCActionInterval * move4 = [[CCActionMoveBy alloc]initWithDuration:2.0 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock5 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt5" image:@"5/" firstIndex:@"0000" lastIndex:@"0021"];
    }];
    CCActionInterval * move5 = [[CCActionMoveBy alloc]initWithDuration:2.1 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock6 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt6" image:@"6/" firstIndex:@"0000" lastIndex:@"0045"];
    }];
    CCActionInterval * move6 = [[CCActionMoveBy alloc]initWithDuration:4.5 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock7 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt7" image:@"7/" firstIndex:@"0000" lastIndex:@"0014"];
    }];
    CCActionInterval * move7 = [[CCActionMoveBy alloc]initWithDuration:1.4 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock8 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt8" image:@"8/" firstIndex:@"0000" lastIndex:@"0063"];
    }];
    CCActionInterval * move8 = [[CCActionMoveBy alloc]initWithDuration:6.3 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock9 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt9" image:@"9/" firstIndex:@"0000" lastIndex:@"0052"];
    }];
    CCActionInterval * move9 = [[CCActionMoveBy alloc]initWithDuration:5.2 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock10 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt10" image:@"10/" firstIndex:@"0000" lastIndex:@"0016"];
    }];
    CCActionInterval * move10 = [[CCActionMoveBy alloc]initWithDuration:1.6 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock11 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt11" image:@"11/" firstIndex:@"0000" lastIndex:@"0042"];
    }];
    CCActionInterval * move11 = [[CCActionMoveBy alloc]initWithDuration:4.2 position:CGPointMake(0, 0)];
    CCActionCallBlock *callBlock12 = [[CCActionCallBlock alloc]initWithBlock:^{
        [self setAnimate:@"pt12" image:@"12/" firstIndex:@"0000" lastIndex:@"0049"];
    }];
    CCActionInterval * move12 = [[CCActionMoveBy alloc]initWithDuration:4.9 position:CGPointMake(0, 0)];
    NSMutableArray *seqArr = [[NSMutableArray alloc]initWithObjects:callBlock1,move1,callBlock2,move2,callBlock3,move3,callBlock4,move4,callBlock5,move5,callBlock6,move6,callBlock7,move7,callBlock8,move8,callBlock9,move9,callBlock10,move10,callBlock11,move11,callBlock12,move12, nil];
    CCActionSequence *seq = [[CCActionSequence alloc]initWithArray:seqArr];
    
    [_startAnimateSprite runAction:seq];
}

@end
