//
//  InterfaceScene.h
//  AnimalCross
//
//  Created by 何松泽 on 16/2/11.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCScene.h"

@interface InterfaceScene : CCScene


+(instancetype)node;
-(instancetype)init;
-(void)initTitle;
-(void)aboutUs;
-(void)startGame;

@end
