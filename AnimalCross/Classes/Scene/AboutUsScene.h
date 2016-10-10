//
//  AboutUsScene.h
//  糖果大作战-TileMap
//
//  Created by 何松泽 on 15/11/9.
//  Copyright © 2015年 suliwei. All rights reserved.
//

#import "CCScene.h"

@interface AboutUsScene : CCScene
{
    CCButton *usButton;
    CCButton *gameButton;
    
    CCLabelTTF *aboutLabel;
    
    BOOL canUs;
    BOOL canGame;
}

+(instancetype)node;
-(instancetype)init;
-(void)aboutGame;
-(void)aboutUs;

@end
