//
//  MainGameScene.m
//
//  Created by : 何松泽
//  Project    : AnimalCross
//  Date       : 16/1/5
//
//  Copyright (c) 2016年 HSZ.
//  All rights reserved.
//
// -----------------------------------------------------------------
#define Need_Key_City  30

#import "MainGameScene.h"
#import "AnimalSpecial.h"
// -----------------------------------------------------------------

@implementation MainGameScene

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    audioBg = [OALSimpleAudio sharedInstance];
    
    [audioBg playBg:@"happyMainGameBg.mp3" loop:YES];//背景音乐
    
    CCSpriteFrameCache *spriteFrameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [spriteFrameCache addSpriteFramesWithFile:@"gameSceneTexture.plist"];

    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    // class initalization goes here
    
    //原本关卡地图
    mapLayout = [[MapLayout alloc]initWithMapType:CITY];
    mapLayout.position = ccp(-220, -180);//开始
//    mapLayout.position = ccp(-426, -429);//第二、三条街
//    mapLayout.position = ccp(-602, -768);//第四条街
//    mapLayout.position = ccp(-719, -948);
    _animal1 = mapLayout.animal;
//    _animal1.position = ccp(-300, -200);
    [self addChild:mapLayout];
    //动物变形
    animalLayout = [[AnimalChangeLayout alloc]init];
    animalLayout.anchorPoint = _animal1.position;
    animalLayout.opacity = 0.8f; 
    animalLayout.visible = NO;
    [self addChild:animalLayout z:4];
    
    key = [[Key alloc]initWith3D:YES KeyType:FISH];
    key.position = ccp(500, 400);
    [mapLayout addChild:key z:2];
    
    keyArr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i <= 15; i++) {
        Key *key1 = [[Key alloc]initWith3D:YES KeyType:FISH];
        key1.position = ccp(_animal1.position.x + Animal_Distance*sinf(VIEW_ANGLE)*i*2, _animal1.position.y+Animal_Distance*cosf(VIEW_ANGLE)*i*2);
        [mapLayout addChild:key1 z:2];
        [keyArr addObject:key1];
    }
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    leftTime = 10;
    //特殊关卡地图
    specialLayout = [[SpecialMapLayout alloc]init];
    specialLayout.position = ccp(0, 0);
    specialLayout.visible = YES;
    specialLayout.tiledBg.opacity = 0.f;
//    specialLayout.animalSpecial.opacity = 0.f;
    [self addChild:specialLayout z:3];
    
    
    //转场背景图
    background = [CCSprite9Slice spriteWithImageNamed:@"透明度.png"];
    background.anchorPoint = CGPointZero;
    background.color = [CCColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    [background setOpacity:0.f];
    [self addChild:background z:10000];
    
    [self setUserInteractionEnabled:TRUE];//允许交互
    [self setMultipleTouchEnabled:TRUE];//允许多点触碰
    
    [self initCar];
    [self initLabel];
    [self initPauseLayout];
    isStart         = NO;
    isSpecialStart  = NO;
    
    [self schedule:@selector(updateGame:) interval:1/60.f];
    [self schedule:@selector(updateDie:) interval:1.f];
    [self schedule:@selector(updateCar:) interval:1/60.f];
    [self schedule:@selector(updateMap:) interval:1/60.f];
    [self schedule:@selector(updateSpeciaMap:) interval:1/60.f];
    
    return self;
}

-(void)initLabel
{
    needLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"/%d",Need_Key_City] fontName:@"American Typewriter" fontSize:20];
    needLabel.position = ccp(SCREEN_WIDTH*0.90, SCREEN_HEIGHT*0.90);
//    [needLabel  setDimensions:CGSizeMake(20, 15)];
    [self addChild:needLabel z:4];
    
    numLabel = [[CCLabelTTF alloc]initWithString:[NSString stringWithFormat:@"%d",keyNum] fontName:@"consolas" fontSize:20];
    numLabel.position = ccp(SCREEN_WIDTH*0.85, SCREEN_HEIGHT*0.90);
//    [needLabel  setDimensions:CGSizeMake(15, 15)];
    [self addChild:numLabel z:4];
}

-(void)initPauseLayout
{
    //暂停按钮
    pauseBtn = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pause.png"]];
    pauseBtn.position = ccp(30, SCREEN_HEIGHT - 30);
    [pauseBtn setBackgroundOpacity:0.6f forState:CCControlStateNormal];
    [pauseBtn setTarget:self selector:@selector(pauseGame)];
    [self addChild:pauseBtn z:1];
    //暂停界面
    pauseLayout = [[CCLayout alloc]init];
    pauseLayout.position = ccp(0, SCREEN_HEIGHT);
    pauseLayout.visible = YES;
    [self addChild:pauseLayout z:1000];
    CCSprite9Slice *pauseBg = [CCSprite9Slice spriteWithImageNamed:@"pauseBg.png"];
    pauseBg.scale  = 0.9f;
    pauseBg.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [pauseLayout addChild:pauseBg z:0];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    Characters character = [[userDefault stringForKey:Choose_Animal] intValue];
    Animal *animal = [[Animal alloc]initWithCharactersName:character];
    animal.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [animal runDownFrameAction];
    [pauseLayout addChild:animal z:1];
    //重新关卡
    CCButton *restartBtn = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"again.png"]];
    restartBtn.scale = 0.8f;
    restartBtn.position = ccp(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-100);
    [restartBtn setTarget:self selector:@selector(reStartGame)];
    [pauseLayout addChild:restartBtn z:1];
    //返回游戏
    backGameBtn = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"close.png"]];
    backGameBtn.scale = 0.7f;
    backGameBtn.position = ccp(SCREEN_WIDTH/2 - 90, SCREEN_HEIGHT/2 + 120);
    [backGameBtn setTarget:self selector:@selector(pauseGame)];
    [pauseLayout addChild:backGameBtn z:1];
    //下一关
    CCButton *nextButton = [[CCButton alloc]initWithTitle:@""  spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back.png"]];
    nextButton.scale = 0.8f;
    nextButton.position = ccp(SCREEN_WIDTH/2+70, SCREEN_HEIGHT/2 - 100);
    [nextButton setTarget:self selector:@selector(nextGame)];
    [pauseLayout addChild:nextButton z:1];
    //退出当前游戏
    CCButton *closeBtn = [[CCButton alloc]initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"back_normal.png"]];
    closeBtn.scale = 0.8f;
    closeBtn.position = ccp(SCREEN_WIDTH/2-70, SCREEN_HEIGHT/2-100);
    [closeBtn setTarget:self selector:@selector(backInterfaceScene)];
    [pauseLayout addChild:closeBtn z:1];
}

-(void)initCar
{
    middleFactory = [[MiddleCarFactory alloc]init];
    largeFactory = [[LargeCarFactory alloc]init];
    smallFactory = [[SmallCarFactory alloc]init];
    
    middleCar_1 = [middleFactory factoryMethod:carLeft speed:Middle_Car_Speed];
    middleCar_2 = [middleFactory factoryMethod:carLeft speed:Middle_Car_Speed];
    middleCar_3 = [middleFactory factoryMethod:carLeft speed:Middle_Car_Speed];
    middleCar_4 = [middleFactory factoryMethod:carRight speed:Middle_Car_Speed];
    middleCar_5 = [middleFactory factoryMethod:carRight speed:Middle_Car_Speed];
    middleCar_6 = [middleFactory factoryMethod:carRight speed:Middle_Car_Speed];
    
    largeCar_1 = [largeFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    largeCar_2 = [largeFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    largeCar_3 = [largeFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    largeCar_4 = [largeFactory factoryMethod:carRight speed:Middle_Car_Speed];
    largeCar_5 = [largeFactory factoryMethod:carRight speed:Middle_Car_Speed];
    largeCar_6 = [largeFactory factoryMethod:carRight speed:Middle_Car_Speed];
    
    smallCar_1 = [smallFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    smallCar_2 = [smallFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    smallCar_3 = [smallFactory factoryMethod:carLeft speed:Slow_Car_Speed];
    smallCar_4 = [smallFactory factoryMethod:carRight speed:Slow_Car_Speed];
    smallCar_5 = [smallFactory factoryMethod:carRight speed:Slow_Car_Speed];
    smallCar_6 = [smallFactory factoryMethod:carRight speed:Slow_Car_Speed];
    
    [smallCar_1 make];
    [smallCar_2 make];
    [smallCar_3 make];
    [smallCar_4 make];
    [smallCar_5 make];
    [smallCar_6 make];
    
    [middleCar_1 make];
    [middleCar_2 make];
    [middleCar_3 make];
    [middleCar_4 make];
    [middleCar_5 make];
    [middleCar_6 make];
    
    [largeCar_1 make];
    [largeCar_2 make];
    [largeCar_3 make];
    [largeCar_4 make];
    [largeCar_5 make];
    [largeCar_6 make];
    
    carArr = [[NSMutableArray alloc]initWithObjects:middleCar_1,middleCar_2,middleCar_3,middleCar_4,middleCar_5,middleCar_6,largeCar_1,largeCar_2,largeCar_3,largeCar_4,largeCar_5,largeCar_6,smallCar_1,smallCar_2,smallCar_3,smallCar_4,smallCar_5,smallCar_6, nil];
    
    middleCar_1.position = First_Left;
    middleCar_2.position = [middleCar_1 nextCarPosition:Car_Distance*2];
    middleCar_3.position = [middleCar_2 nextCarPosition:Car_Distance*2];
    
    largeCar_4.position = First_Right;
    largeCar_5.position = [largeCar_4 nextCarPosition:Car_Distance*2];
//    largeCar_6.position = [largeCar_5 nextCarPosition:Car_Distance*2];
    largeCar_6.position = ccp(-SCREEN_WIDTH, -SCREEN_HEIGHT);
    
    largeCar_1.position = Third_Left;
    largeCar_2.position = [largeCar_1 nextCarPosition:Car_Distance*1.5];
    largeCar_3.position = [largeCar_2 nextCarPosition:Car_Distance*1.5];

    
    smallCar_1.position = Second_Left;
    smallCar_2.position = [smallCar_1 nextCarPosition:Car_Distance*3];
    smallCar_3.position = [smallCar_2 nextCarPosition:Car_Distance*3];
    
    middleCar_4.position = Third_Right;
    middleCar_5.position = [middleCar_4 nextCarPosition:Car_Distance];
    middleCar_6.position = [middleCar_5 nextCarPosition:Car_Distance];
    
    [mapLayout addChild:middleCar_1 z:1];
    [mapLayout addChild:middleCar_2 z:1];
    [mapLayout addChild:middleCar_3 z:1];
    
    [mapLayout addChild:smallCar_1 z:1];
    [mapLayout addChild:smallCar_2 z:1];
    [mapLayout addChild:smallCar_3 z:1];
    [mapLayout addChild:smallCar_4 z:1];
    [mapLayout addChild:smallCar_5 z:1];
    [mapLayout addChild:smallCar_6 z:1];
    
    [mapLayout addChild:largeCar_1 z:1];
    [mapLayout addChild:largeCar_2 z:1];
    [mapLayout addChild:largeCar_3 z:1];
    [mapLayout addChild:middleCar_4 z:1];
    [mapLayout addChild:middleCar_5 z:1];
    [mapLayout addChild:middleCar_6 z:1];
    
    [mapLayout addChild:largeCar_4 z:2];
    [mapLayout addChild:largeCar_5 z:2];
    [mapLayout addChild:largeCar_6 z:2];
}

#pragma mark    BUTTON_EVENT
-(void)pauseGame
{
    pauseCount++;
    if (pauseCount%2 == 1) {
        [audioBg paused];
        backGameBtn.visible = YES;
        [pauseLayout runAction:[CCActionSequence actions:[CCActionMoveBy actionWithDuration:0.3f position:ccp(0, -SCREEN_HEIGHT)],[CCActionCallBlock actionWithBlock:^{
            pauseBtn.userInteractionEnabled = NO;
            [[CCDirector sharedDirector] pause];
        }],nil]];
    }else if (pauseCount%2 == 0){
        [[CCDirector sharedDirector] resume];
        pauseBtn.userInteractionEnabled = YES;
        [pauseLayout runAction:[CCActionSequence actions:[CCActionMoveBy actionWithDuration:0.3f position:ccp(0, SCREEN_HEIGHT)],[CCActionCallBlock actionWithBlock:^{
            [audioBg bgPlaying];

        }],nil]];
    }
}

-(void)reStartGame
{
    [[CCDirector sharedDirector]resume];
    
    [audioBg playBg:@"happyMainGameBg.mp3" loop:YES];
    
    [[CCDirector sharedDirector]replaceScene:[MainGameScene new] withTransition:
     [CCTransition transitionCrossFadeWithDuration:0.3f]];
}

-(void)nextGame
{
    
}

-(void)backInterfaceScene
{
    [[CCDirector sharedDirector]resume];
    
    [audioBg stopBg];//停止背景音乐
    
    [[CCDirector sharedDirector]replaceScene:[InterfaceScene new] withTransition:
     [CCTransition transitionCrossFadeWithDuration:0.3f]];
    NSLog(@"backback");
}

#pragma mark    UPDATE
-(void)updateCar:(CCTime)delta
{
    if (mapLayout.position.y < - 400) {//第一条街道汽车复用
        if (mapLayout.position.y < - 633){//第二街道汽车和第三条右侧复用
            [smallCar_1 restart:Fifth_Left zOrder:1];
            [smallCar_2 restart:Fifth_Left zOrder:1];
            [smallCar_3 restart:Fifth_Left zOrder:1];
            [middleCar_4 restart:Fifth_Right zOrder:1];
            [middleCar_5 restart:Fifth_Right zOrder:1];
//            [middleCar_6 restart:Fifth_Right zOrder:1];
        }else{
            [smallCar_1 restart:Second_Left zOrder:1];
            [smallCar_2 restart:Second_Left zOrder:1];
            [smallCar_3 restart:Second_Left zOrder:1];
            [largeCar_1 restart:Third_Left zOrder:1];
            [largeCar_2 restart:Third_Left zOrder:1];
            [largeCar_3 restart:Third_Left zOrder:1];
            
            [middleCar_4 restart:Third_Right zOrder:1];
            [middleCar_5 restart:Third_Right zOrder:1];
            [middleCar_6 restart:Third_Right zOrder:1];
        }
        [middleCar_1 restart:Forth_Left zOrder:2];
        [middleCar_2 restart:Forth_Left zOrder:2];
        [middleCar_3 restart:Forth_Left zOrder:2];
        [largeCar_4 restart:Forth_Right1 zOrder:1];
        [largeCar_5 restart:Forth_Right1 zOrder:1];
        [largeCar_6 restart:Forth_Right1 zOrder:1];
        [smallCar_4 restart:Forth_Right2 zOrder:2];
        [smallCar_5 restart:Forth_Right2 zOrder:2];
        [smallCar_6 restart:Forth_Right2 zOrder:2];
    }else if (mapLayout.position.y > - 480){
        [middleCar_1 restart:First_Left zOrder:2];
        [middleCar_2 restart:First_Left zOrder:2];
        [middleCar_3 restart:First_Left zOrder:2];
        [largeCar_4 restart:First_Right zOrder:2];
        [largeCar_5 restart:First_Right zOrder:2];
//        [largeCar_6 restart:First_Right zOrder:2];
        [smallCar_1 restart:Second_Left zOrder:1];
        [smallCar_2 restart:Second_Left zOrder:1];
        [smallCar_3 restart:Second_Left zOrder:1];
        [largeCar_1 restart:Third_Left zOrder:1];
        [largeCar_2 restart:Third_Left zOrder:1];
        [largeCar_3 restart:Third_Left zOrder:1];
        [middleCar_4 restart:Third_Right zOrder:1];
        [middleCar_5 restart:Third_Right zOrder:1];
        [middleCar_6 restart:Third_Right zOrder:1];
        NSLog(@"%f",largeCar_1.boundingBox.size.width);
        
    }
}

-(void)updateMap:(CCTime)delta
{
    if (isStart) {        //当点击开始时，地图开始翻滚
        if (_animal1.position.y>= End_Position.y) {
            if (fabs(mapLayout.position.y) <=fabs(Map_End_Position.y) ) {
                mapLayout.position = ccp(mapLayout.position.x-delta*65, mapLayout.position.y-delta*100);
            }
            if (keyNum >= Need_Key_City) {
//                [_animal1 runToBox:Box_Position];
                [_animal1 runAction:[CCActionCallBlock actionWithBlock:^{
                    [self pauseGame];
                    backGameBtn.visible = NO;
//                    [[OALSimpleAudio sharedInstance]stopBg];
                    [[OALSimpleAudio sharedInstance]playEffect:@"口哨音效.WAV" loop:NO];
                    [self unschedule:@selector(updateMap:)];
                }]];
            }
                    
        }else{
            if (_animal1.position.y <= fabs(mapLayout.position.y)+20) {// 被老鹰抓走
                if (_animal1.curFrameDirection != Die) {
                    [self dieForHawk];
                    _animal1.curFrameDirection = Die;
                }
            }else if (_animal1.position.y >= fabs(mapLayout.position.y)+120){
                mapLayout.position = ccp(mapLayout.position.x-delta*40, mapLayout.position.y-delta*60);
            }
            else{
                mapLayout.position = ccp(mapLayout.position.x-delta*10, mapLayout.position.y-delta*15);
            }
        }
    }
}

-(void)updateSpeciaMap:(CCTime)delta
{
    if (specialLayout.isSpecialStart) {
        time+=delta/4;
        specialLayout.tiledBg.opacity = 1.f*time;     //无法使用延迟动作，自行计算opacity来实现FadeIn/FadeOut
        specialLayout.animalSpecial.opacity = 1.f*time;
    }
    if (specialLayout.isSpecialStart && animalLayout.isEnd) {
        if (time >= 1.f) {
            if (specialLayout.position.x<= -3870 + 588) {
//                [self specialEnd:delta];
                specialTime+=delta;
                if (specialTime<= 1.f) {
                    background.opacity = 1.f*specialTime;
                }else if(specialTime <= 2.f){
                    background.opacity = 0.f;
                    specialLayout.animalSpecial.visible = NO;
                    specialLayout.visible = NO;
                    specialLayout.isSpecialStart = NO;
                    specialLayout.isSpecialEnd = YES;           //特殊关卡已结束
                    [mapLayout setViewpointCenter:_animal1.position];
                    [self schedule:@selector(updateMap:) interval:1/60.f];
                    [self schedule:@selector(updateGame:) interval:1/60.f];
                }
            }else{
                specialLayout.position = ccp(specialLayout.position.x - 100*delta, specialLayout.position.y);
                NSArray *keyArray = [NSArray arrayWithArray:specialLayout.keyArr];
                
                for (Key *k in keyArray) {
                    k.visible = YES;
                    BOOL getKey = [specialLayout.animalSpecial isEasyCollision:k];
                    if (getKey) {
                        k.visible = NO;
                        [k removeFromParent];
                        [specialLayout.keyArr removeObject:k];
                        keyNum +=1;
                        numLabel.string = [NSString stringWithFormat:@"%d",keyNum];
                    }
                }
                if ([specialLayout specialCollision]) {//特殊关卡碰撞检测
//                    [self specialEnd:delta];
                    specialTime+=delta*5;
                    if (specialTime<= 1.f) {
                        background.opacity = 1.f*specialTime;
                    }else if(specialTime <= 2.f){
                        background.opacity = 0.f;
                        specialLayout.visible = NO;
                        specialLayout.animalSpecial.visible = NO;
                        specialLayout.isSpecialStart = NO;
                        specialLayout.isSpecialEnd = YES;           //特殊关卡已结束
                        [self schedule:@selector(updateMap:) interval:1/60.f];
                        [self schedule:@selector(updateGame:) interval:1/60.f];
                    }
                }
            }
        }
        
    }
}

-(void)updateKey:(CCTime)delta
{
    for (Key *k in keyArr) {
        if ([_animal1 isEasyCollision:k]) {
        k.visible = NO;
        keyNum +=1;
        numLabel.string = [NSString stringWithFormat:@"%d",keyNum];
        }
    }
}

-(void)updateDie:(CCTime)delta
{
    if (_animal1.curFrameDirection == Die) {
        dieTime +=delta;
        if (dieTime >= 2.f) {
            [_animal1 runAction:[CCActionCallBlock actionWithBlock:^{
                [self pauseGame];
                backGameBtn.visible = NO;
                [[OALSimpleAudio sharedInstance]stopBg];
                [[OALSimpleAudio sharedInstance]playBg:@"95 - Lunch Break.mp3" loop:NO];
            }]];
        }
    }
    
}

-(void)updateGame:(CCTime)delta
{
//    NSLog(@"%f,%f",mapLayout.position.x,mapLayout.position.y);//Forth_Right y = -426,x=-429第一条街的复用
//    [mapLayout setViewpointCenter:_animal1.position];
    if (_animal1.curFrameDirection == Die) {
        [self unschedule:@selector(updateMap:)];
    }
    float carX;
    float carY;
    float carWidth;
    float carHeight;
    float animalX = _animal1.boundingBox.origin.x;              //_animal1.position.x;
    float animalY = _animal1.boundingBox.origin.y;              //_animal1.position.y;
    float animalWidth = _animal1.boundingBox.size.width;
    
    NSArray *keyArray = [NSArray arrayWithArray:keyArr];
    
    for (Key *k in keyArray) {
        BOOL getKey = [_animal1 isEasyCollision:k];
        if (getKey) {
            k.visible = NO;
            [k removeFromParent];
            [keyArr removeObject:k];
            keyNum +=1;
            numLabel.string = [NSString stringWithFormat:@"%d",keyNum];
        }
    }

    if (!specialLayout.isSpecialEnd) {                          //还没进入过特殊关卡进行判断
        if ([_animal1 isEasyCollision:mapLayout.sewer1]) {       //进入特殊关卡
            specialLayout.isSpecialStart = YES;
            _animal1.position = mapLayout.sewer2.position;
            animalLayout.visible = YES;
            [animalLayout animalChange];
            [self unschedule:@selector(updateMap:)];
            [self unschedule:@selector(updateGame:)];
        }else if ([_animal1 isEasyCollision:mapLayout.sewer2]){
            specialLayout.isSpecialStart = YES;
            _animal1.position = mapLayout.sewer1.position;
            animalLayout.visible = YES;
            [animalLayout animalChange];
            [self unschedule:@selector(updateMap:)];
            [self unschedule:@selector(updateGame:)];
        }
    }
    
    
    for (Car *c in carArr) {
        carX = c.position.x;
        carY = c.position.y;
        carWidth = c.boundingBox.size.width;
        carHeight = c.boundingBox.size.height;
        if (c.carDirection == carLeft) {
            if ([_animal1 is25DCollision:c]) {
                NSLog(@"汽车右端：%f,动物左端%f,汽车下端：%f,动物中间%f",(carX+carWidth/2),(animalX-animalWidth/2),(carY - carHeight/2),animalY);
                [_animal1 runDieFrameAction];
                _animal1.curFrameDirection = Die;
            }
                            
        }else if (c.carDirection == carRight){
            if ([_animal1 is25DCollision:c]) {
                NSLog(@"汽车右端：%f,动物左端%f,汽车下端：%f,动物中间%f",(carX+carWidth/2),(animalX-animalWidth/2),(carY - carHeight/2),animalY);
                [_animal1 runDieFrameAction];
                _animal1.curFrameDirection = Die;
            }
            
                            
        }
    }
}


#pragma mark    TOUCH_EVENT
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    isStart = YES;
    
    beganPoint = [touch locationInWorld];
    
}

-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (animalLayout.isEnd || specialLayout.isSpecialStart) {
        CGPoint animalSpecialPoint = [touch locationInNode:specialLayout];
        specialLayout.animalSpecial.position = animalSpecialPoint;
    }
    
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (!specialLayout.isSpecialStart) {
        float dis = 20.f;
        //两种都可以
        //    endPoint = [[CCDirector sharedDirector] convertTouchToGL:touch];
        endPoint = [touch locationInWorld];
        float disX = endPoint.x - beganPoint.x;
        float disY = endPoint.y - beganPoint.y;
        
        if (disX > dis && ABS(ABS(disX) - dis) > ABS(ABS(disY) - dis) && !_animal1.isMove) {                           //向右
            [_animal1 runRightFrameAction];
            if ([self canPass:canRight]) {
                [_animal1 goRightSpeed:Tortoise_Speed distance:Animal_Distance];
            }
        }else if (disX < -dis && ABS(ABS(disX) - dis) > ABS(ABS(disY) - dis) && !_animal1.isMove){                           //向左
            [_animal1 runLeftFrameAction];
            if ([self canPass:canLeft]) {
                [_animal1 goLeftSpeed:Tortoise_Speed distance:Animal_Distance];
            }
        }else if (disY > dis && ABS(ABS(disX) - dis) < ABS(ABS(disY) - dis) && !_animal1.isMove){                           //向前
            [_animal1 runUpFrameAction];
            if ([self canPass:canUp]) {
                [_animal1 goForwardSpeed:Tortoise_Speed distance:Animal_Distance];
            }
        }else if (disY < -dis && ABS(ABS(disX) - dis) < ABS(ABS(disY) - dis) && !_animal1.isMove){                           //向后
            [_animal1 runDownFrameAction];
            if ([self canPass:canDown]) {
                [_animal1 goBackSpeed:Tortoise_Speed distance:Animal_Distance];
            }
        }else{                          //其他情况全部向前
            if (!_animal1.isMove && [self canPass:canUp]) {
                [_animal1 runUpFrameAction];
                [_animal1 goForwardSpeed:Tortoise_Speed distance:Animal_Distance];
            }
        }
    }else{
//        specialLayout.animalSpecial.position = animalSpecialPoint;
    }
}
#pragma mark    JUEDGE_EVENT
/**
 *  @author 小泽, 16-03-27 18:03:59
 *
 *  被老鹰抓走
 */
-(void)dieForHawk
{
    CCSprite *hawk = [[CCSprite alloc]initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"hawk.png"]];
    hawk.scale = 0.2f;
    hawk.position = ccp(_animal1.position.x+SCREEN_WIDTH, _animal1.position.y+SCREEN_HEIGHT);
    [mapLayout addChild:hawk z:2];
    
    CCActionInterval *hawkMove = [[CCActionMoveTo alloc] initWithDuration:1.f position:_animal1.position];
    CCActionInterval *togetherMove = [[CCActionMoveTo alloc] initWithDuration:0.5f position:ccp(_animal1.position.x - 100*coshf(hawk.position.x - _animal1.position.x/ccpDistance(hawk.position, _animal1.position)), _animal1.position.y-100*sinhf(hawk.position.y - _animal1.position.y/ccpDistance(hawk.position, _animal1.position)))];//通过正余弦，判断老鹰继续飞行的方向
    CCActionCallBlock *callBlock = [[CCActionCallBlock alloc]initWithBlock:^{
        [_animal1 stopAllActions];
        [_animal1 removeFromParent];
    }];
    CCActionSequence *hawkSeq = [[CCActionSequence alloc]initOne:hawkMove two:callBlock];
    CCActionSequence *hawkSeq1 = [[CCActionSequence alloc]initOne:hawkSeq two:togetherMove];
    CCActionSequence *hawkSeq2 = [[CCActionSequence alloc]initOne:hawkSeq1 two:[CCActionCallBlock actionWithBlock:^{
        [self pauseGame];
        backGameBtn.visible = NO;
        [[OALSimpleAudio sharedInstance]stopBg];
        [[OALSimpleAudio sharedInstance]playBg:@"95 - Lunch Break.mp3" loop:NO];
    }]];
    [hawk runAction:hawkSeq2];
    
    [[OALSimpleAudio sharedInstance]playEffect:@"老鹰.wav" volume:0.5f pitch:1.0f pan:0.0f loop:NO];
    [self unschedule:@selector(updateMap:)];
    
}

-(void)specialEnd:(CCTime)delta
{
    specialTime+=delta;
    if (specialTime<= 1.f) {
        background.opacity = 1.f*specialTime;
    }else if(specialTime <= 2.f){
        background.opacity = 0.f;
        specialLayout.visible = NO;
        specialLayout.isSpecialStart = NO;
        specialLayout.isSpecialEnd = YES;           //特殊关卡已结束
        [self schedule:@selector(updateMap:) interval:1/60.f];
        [self schedule:@selector(updateGame:) interval:1/60.f];
    }
}


/**
 *  @author 小泽, 16-03-08 23:03:47
 *
 *  判断玩家行走方向
 *
 *  @param d canUp,canDown,canLeft,canRight
 *
 *  @return 能否通过
 */
-(BOOL)canPass:(CanPass)d
{
    CGPoint nowPoint=[mapLayout.tiledCollision tileCoordinateAt:_animal1.position];
    NSLog(@"nowPoint:%f,%f",nowPoint.x,nowPoint.y);
    switch (d) {
        case canUp:{
            for (int i = 0 ; i<4; i++) {
                int gid = [mapLayout.tiledCollision tileGIDAt:ccp(nowPoint.x, nowPoint.y+i)];
//            NSLog(@"%d,%f",gid,nowPoint.y+i);
                NSDictionary *properties = [mapLayout.tileBuilding propertiesForGID:gid];
                //            assert(properties == NULL);
                if (properties) {
//                    NSLog(@"%@",[properties valueForKey:@"Collision"]);
                    if ([[properties valueForKey:@"Collision"] isEqualToString:@"true"]) {
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }
        }
            break;
        case canDown:{
            int gid = [mapLayout.tiledCollision tileGIDAt:ccp(nowPoint.x, nowPoint.y-3)];
            NSDictionary *properties = [mapLayout.tileBuilding propertiesForGID:gid];
            //            assert(properties == NULL);
            if (properties) {
                NSLog(@"%@",[properties valueForKey:@"Collision"]);
                if ([[properties valueForKey:@"Collision"] isEqualToString:@"true"]) {
                    return NO;
                }else{
                    return YES;
                }
            }
    }
            break;
        case canLeft:{
            int gid = [mapLayout.tiledCollision tileGIDAt:ccp(nowPoint.x-3, nowPoint.y)];
            NSDictionary *properties = [mapLayout.tileBuilding propertiesForGID:gid];
            //            assert(properties == NULL);
            if (properties) {
                NSLog(@"%@",[properties valueForKey:@"Collision"]);
                if ([[properties valueForKey:@"Collision"] isEqualToString:@"true"]) {
                    return NO;
                }else{
                    return YES;
                }
            }
        }
            break;
        case canRight:{
            int gid = [mapLayout.tiledCollision tileGIDAt:ccp(nowPoint.x+3, nowPoint.y)];
            NSDictionary *properties = [mapLayout.tileBuilding propertiesForGID:gid];
            if (properties) {
                NSLog(@"%@",[properties valueForKey:@"Collision"]);
                if ([[properties valueForKey:@"Collision"] isEqualToString:@"true"]) {
                    return NO;
                }else{
                    return YES;
                }
            }
        }
            break;
        default:
            break;
    }
    return YES;
}

@end
