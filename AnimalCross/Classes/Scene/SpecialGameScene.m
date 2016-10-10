//
//  SpecialGameScene.m
//  AnimalCross
//
//  Created by 何松泽 on 16/2/24.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "SpecialGameScene.h"
#import "InterfaceScene.h"


@implementation SpecialGameScene

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        // Background
//        [OALSimpleAudio sharedInstance].preloadCacheEnabled = YES;
        [[OALSimpleAudio sharedInstance] preloadBg:@"happyMainGameBg.mp3"];
        [[OALSimpleAudio sharedInstance] preloadBg:@"interFaceSceneBg.mp3"];
        
        [[OALSimpleAudio sharedInstance] preloadEffect:@"老鹰.wav"];
        [[OALSimpleAudio sharedInstance] playBg:@"09 - Abracadabra.mp3" volume:0.8f pan:0 loop:NO];
//        NSURL *videoURL = [NSURL URLWithString:@"file://localhost/Users/XIAOZE/Downloads/OpenAnimate（已转换）"];
//        NSURL *videoURL = [NSURL URLWithString:@"file://localhost/Users/XIAOZE/Desktop/项目/AnimalCross/AnimalCross/Resources/片头动画/OpenAnimate.mp4"];
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"openAnimate" ofType:@"mp4"];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *docDir = [paths objectAtIndex:0];
//        NSLog(@"%@,%@",soundFilePath,NSHomeDirectory());
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        [self playVideoWithURL:fileURL];
        
        _skipBtn = [[CCButton alloc]initWithTitle:@"skip" fontName:@"consolas" fontSize:14.f];
        _skipBtn.position = ccp(SCREEN_WIDTH - 20, SCREEN_HEIGHT);
        _skipBtn.visible = YES;
        [_skipBtn setTarget:self selector:@selector(skipAnimate)];
        [self addChild:_skipBtn z:10];
        [self schedule:@selector(updateGame:) interval:1.f];
        
    }
    return self;
}

-(void)skipAnimate
{
    [self.videoController dismiss];
    
    [[CCDirector sharedDirector]replaceScene:[InterfaceScene new] withTransition:
     [CCTransition transitionCrossFadeWithDuration:0.3f]];
    NSLog(@"跳过");
}

- (void)playVideoWithURL:(NSURL *)url//播放片头动画视频
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
        UIButton *skipBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80,10, 80, 30)];
        [skipBtn setTitle:@"Skip" forState:UIControlStateNormal];
        skipBtn.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:28];
        [skipBtn addTarget:self action:@selector(skipAnimate) forControlEvents:UIControlEventTouchUpInside];
        [self.videoController.view addSubview:skipBtn];
    }
    self.videoController.contentURL = url;
}

-(void)updateGame:(CCTime)delta
{
    time += delta;
    
    if (time >= 63.f) {
        [self skipAnimate];
    }
    if (time >= 20.f) {
        [[OALSimpleAudio sharedInstance] playEffect:@"钥匙碰撞声.mp3" loop:NO];
    }
    if (time >= 25.f) {
        [[OALSimpleAudio sharedInstance] stopAllEffects];
    }
    NSLog(@"%f",time);
}

//-(void)updateMap:(CCTime)delta
//{
//    time+=delta;
//    if (time>=3.f) {
//        
//        if (background.position.x<=1900-3870+610) {
//            background.position = background.position;
//        }else{
//            background.position = ccp(background.position.x - 200*delta, background.position.y);
//        }
//    }
//}

@end
