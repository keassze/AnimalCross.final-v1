//
//  ChooseScene.h
//  AnimalCross
//
//  Created by 何松泽 on 16/3/19.
//  Copyright © 2016年 HSZ. All rights reserved.
//

#import "CCScene.h"
#import "Animal.h"
#import "Tortoise.h"
#import "Lizard.h"
#import "Monkey.h"
/**
 *  @author 小泽, 16-03-29 15:03:52
 *
 *  选择角色界面
 */
@interface ChooseScene : CCScene
{
    CCButton *leftButton;
    CCButton *rightButton;
    CCButton *sureButton;
    CCLayout *animalLayout;
    Animal *animal;
}

@property (nonatomic, assign)int chooseAnimal;

+ (instancetype)node;
- (instancetype)init;
- (void)pushLeft:(CCButton *)sender;
- (void)pushRight:(CCButton *)sender;

@end
